//
//  ViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Gifu
import SnapKit
import Then
import UIKit

class MainViewController: BaseViewController {
    private var handle: AuthStateDidChangeListenerHandle?
    let userManager = UserManager()
    var firebaseDB: DatabaseReference!
    var recommendedEtiquetteCollectionView: UICollectionView!
    var recentlyEtiquetteCollectionView: UICollectionView!
    var recommendedEtiquetteList: [Etiquette] = []
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.mainViewModel?.updateUser(currentUser)
        fetchEtiquetteContent()
        setRecentlyLabel()
        recentlyEtiquetteCollectionView.reloadData()
        recommendedEtiquetteCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainView.indicator.startAnimating()
        setCurrentUser()
        setupCollectionView()
        fetchEtiquetteList()
        mainView.seeMoreButton.addTarget(self, action: #selector(seeMoreButtonClick), for: .touchUpInside)
        mainView.quizButton.addTarget(self, action: #selector(quizButtonClick), for: .touchUpInside)
        mainView.randomButton.addTarget(self, action: #selector(randomButtonClick), for: .touchUpInside)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func seeMoreButtonClick() {
        if let tabBarController = self.tabBarController{
            tabBarController.selectedIndex = 1
        }
    }
    
    @objc func quizButtonClick() {
        let quizIntroVC = QuizIntroViewController()
        quizIntroVC.modalPresentationStyle = .fullScreen
        present(quizIntroVC, animated: true)
    }
    
    @objc func randomButtonClick(){
        fetchEtiquetteContent()
    }
    
    func setRecentlyLabel() {
        if !EtiquetteManager.shared.recentlyEtiquetteList.isEmpty {
            mainView.recentlyEtiquetteLabel.isHidden = true
        } else {
            mainView.recentlyEtiquetteLabel.isHidden = false
        }
    }
    
    private func setCurrentUser(){
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user, let email = user.email {
                self.userManager.findUser(email: email) { findUser in
                    if let user = findUser {
                        currentUser = user
                        self.mainView.mainViewModel = MainViewModel(user: currentUser)
                        if let imageURL = URL(string: user.profileImage) {
                            self.mainView.profileImageView.setImageUrl(imageURL.absoluteString)
                        }
                    }
                }
            }
        }
    }
    
    
    func setupCollectionView() {
        mainView.recentlyEtiquetteCollectionView.delegate = self
        mainView.recentlyEtiquetteCollectionView.dataSource = self
        mainView.recentlyEtiquetteCollectionView.register(RecentItemCell.self, forCellWithReuseIdentifier: "RecentItemCell")
        mainView.recommendEtiquetteCollectionView.delegate = self
        mainView.recommendEtiquetteCollectionView.dataSource = self
        mainView.recommendEtiquetteCollectionView.register(RecommendItemCell.self, forCellWithReuseIdentifier: "RecommendItemCell")
        recommendedEtiquetteCollectionView = mainView.recommendEtiquetteCollectionView
        recentlyEtiquetteCollectionView = mainView.recentlyEtiquetteCollectionView
    }
    
    func fetchEtiquetteContent() {
        if etiquetteList.count != 0 {
            let randomNumber = Int.random(in: 0..<etiquetteList.count)
            let content = etiquetteList[randomNumber]
            mainView.mainViewModel?.updateEtiquette(content)
        }
        else {
            return
        }
    }
    
    func fetchEtiquetteList() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        firebaseDB = Database.database().reference()
        
        firebaseDB.child("SavedData/Etiquette/").getData { [weak self] error, snapshot in
            guard let self = self, error == nil else {
                return
            }
            
            etiquetteList = []
            let data = snapshot?.value as! [String: Any]
            let dispatchGroup = DispatchGroup() // Create a DispatchGroup
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let imageCacheDirectoryURL = documentsURL?.appendingPathComponent("ImageCache")
            if !fileManager.fileExists(atPath: imageCacheDirectoryURL!.path) {
                do {
                    try fileManager.createDirectory(at: imageCacheDirectoryURL!, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Error creating image cache directory: \(error)")
                    return
                }
            }
            
            
            for key in data.keys {
                var good: [EtiquetteContent] = []
                var bad: [EtiquetteContent] = []
                
                let etiquette = data[key] as! [String: Any]
                let category = etiquette["category"] as! String
                let place = etiquette["place"] as! String
                let description = etiquette["description"] as! String
                let contentData = etiquette["content"] as! [String: Any]
                let goodContent = contentData["good"] as! [[String: String]]
                let badContent = contentData["bad"] as! [[String: String]]
                let gsLink = etiquette["gsReference"] as! String
                var mainImage = UIImage(systemName: "person.fill")
                
                dispatchGroup.enter()
                loadImageFromCacheOrDownload(gsLink) { image in
                    if let image = image {
                        mainImage = image
                        dispatchGroup.leave()
                    }
                }
                
                for content in goodContent {
                    let mainContent = content["mainContent"] as! String
                    let subContent = content["subContent"] as! String
                    let imageLink = content["imageLink"] as! String
                    let imageReference = storage.reference(forURL: imageLink)
                    
                    dispatchGroup.enter() // Enter the dispatch group
                    let etiquetteContent = EtiquetteContent(mainContent: mainContent, subContent: subContent, contentImage: nil, contentImageLink: imageLink)
                    good.append(etiquetteContent)
                    dispatchGroup.leave() // Leave the dispatch group
                    
                }
                
                for content in badContent {
                    let mainContent = content["mainContent"] as! String
                    let subContent = content["subContent"] as! String
                    let imageLink = content["imageLink"] as! String
                    let imageReference = storage.reference(forURL: imageLink)
                    
                    dispatchGroup.enter() // Enter the dispatch group
                    
                    let etiquetteContent = EtiquetteContent(mainContent: mainContent, subContent: subContent, contentImage: nil, contentImageLink: imageLink)
                    bad.append(etiquetteContent)
                    
                    dispatchGroup.leave() // Leave the dispatch group
                    //
                }
                
                dispatchGroup.notify(queue: .main) {
                    let newEtiquette = Etiquette(category: category, place: place, content: ["good": good, "bad": bad], backgroundImage: mainImage!, mainImage: mainImage!, description: description)
                    etiquetteList.append(newEtiquette)
//                    self.recommendedEtiquetteCollectionView.reloadData()
//                    print("에티켓 리스트 업데이트 됨")
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.fetchEtiquetteContent()
                self.fetchRecommendedEtiquetteList()
                self.recommendedEtiquetteCollectionView.reloadData()
                self.mainView.indicator.stopAnimating()
            }
            
        }
    }
 
    private func fetchRecommendedEtiquetteList() {
        let groupedEtiquettes = Dictionary(grouping: etiquetteList, by: { $0.category })
        for (_, etiquettes) in groupedEtiquettes {
            var shuffledEtiquettes = etiquettes.shuffled()
            if shuffledEtiquettes.count >= 2 {
                recommendedEtiquetteList.append(contentsOf: Array(shuffledEtiquettes.prefix(2)))
            } else {
                recommendedEtiquetteList.append(contentsOf: shuffledEtiquettes)
            }
        }
    }
}



extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            return EtiquetteManager.shared.recentlyEtiquetteList.count
        }
        else {
            return recommendedEtiquetteList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentItemCell", for: indexPath) as? RecentItemCell else { return UICollectionViewCell()}
            let etiquette = EtiquetteManager.shared.recentlyEtiquetteList[indexPath.row]
            cell.configureUI(etiquette)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendItemCell", for: indexPath) as? RecommendItemCell else { return UICollectionViewCell()}
            let etiquette = recommendedEtiquetteList[indexPath.row]
            cell.configureUI(etiquette)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedEtiquette: Etiquette
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            selectedEtiquette = EtiquetteManager.shared.recentlyEtiquetteList[indexPath.row]
        } else {
            selectedEtiquette = recommendedEtiquetteList[indexPath.row]
        }
        EtiquetteManager.shared.fetchRecentlyEtiquetteList(selectedEtiquette)
        let detailVC = DetailViewController()
        detailVC.selectedEtiquette = selectedEtiquette
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


