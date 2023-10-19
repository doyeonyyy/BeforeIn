//
//  ViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import FirebaseDatabase
import FirebaseStorage
import Gifu
import SnapKit
import Then
import UIKit

class MainViewController: BaseViewController {
    var firebaseDB: DatabaseReference!
    var recommendedEtiquetteCollectionView: UICollectionView!
    
    private var user1 = User(email: "lcho3878@naver.com", name: "이찬호", nickname: "lcho3878", profileImage: UIImage(systemName: "person.fill")!, level: 5, phone: "")
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mainViewModel = MainViewModel(user: self.user1)
        mainView.mainViewModel = mainViewModel
        setupCollectionView()
        mainView.seeMoreButton.addTarget(self, action: #selector(seeMoreButtonClick), for: .touchUpInside)
        mainView.quizButton.addTarget(self, action: #selector(quizButtonClick), for: .touchUpInside)
    }
    
    @objc func seeMoreButtonClick() {
        self.fetchEtiquetteList()
    }
    
    @objc func quizButtonClick() {
        self.fetchEtiquetteContent()
    }
    
    func setupCollectionView() {
        mainView.recentlyEtiquetteCollectionView.delegate = self
        mainView.recentlyEtiquetteCollectionView.dataSource = self
        mainView.recentlyEtiquetteCollectionView.register(RecentItemCell.self, forCellWithReuseIdentifier: "RecentItemCell")
        mainView.recommendEtiquetteCollectionView.delegate = self
        mainView.recommendEtiquetteCollectionView.dataSource = self
        mainView.recommendEtiquetteCollectionView.register(RecommendItemCell.self, forCellWithReuseIdentifier: "RecommendItemCell")
        recommendedEtiquetteCollectionView = mainView.recommendEtiquetteCollectionView
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
                
                for content in goodContent {
                    let mainContent = content["mainContent"] as! String
                    let subContent = content["subContent"] as! String
                    let imageLink = content["imageLink"] as! String
                    let imageReference = storage.reference(forURL: imageLink)
                    
                    dispatchGroup.enter() // Enter the dispatch group
                    
                    imageReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Handle error
                            print("컨텐츠 이미지 다운 실패")
                        } else {
                            // Data for "images/island.jpg" is returned
                            let image = UIImage(data: data!)
                            print("컨텐츠 이미지 다운 완료")
                            let etiquetteContent = EtiquetteContent(mainContent: mainContent, subContent: subContent, contentImage: image!)
                            good.append(etiquetteContent)
                     }
                        dispatchGroup.leave() // Leave the dispatch group
                    }
                }
                
                for content in badContent {
                    let mainContent = content["mainContent"] as! String
                    let subContent = content["subContent"] as! String
                    let imageLink = content["imageLink"] as! String
                    let imageReference = storage.reference(forURL: imageLink)
                    
                    dispatchGroup.enter() // Enter the dispatch group
                    
                    imageReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Handle error
                            print("컨텐츠 이미지 다운 실패")
                        } else {
                            // Data for "images/island.jpg" is returned
                            let image = UIImage(data: data!)
                            print("컨텐츠 이미지 다운 완료")
                            let etiquetteContent = EtiquetteContent(mainContent: mainContent, subContent: subContent, contentImage: image!)
                            bad.append(etiquetteContent)
                        }
                        dispatchGroup.leave() // Leave the dispatch group
                    }
                }
                
                let gsLink = etiquette["gsReference"] as! String
                var mainImage = UIImage(systemName: "person.fill")
                let gsReference = storage.reference(forURL: gsLink)
                
                dispatchGroup.enter() // Enter the dispatch group
                
                gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        // Handle error
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        print("\(place) 사진 로드 성공")
                        mainImage = image
                    }
                    dispatchGroup.leave() // Leave the dispatch group
                    
                    // Create and update the Etiquette object after image is loaded
                    
                }
                dispatchGroup.notify(queue: .main) {
                    let newEtiquette = Etiquette(category: category, place: place, content: ["good": good, "bad": bad], backgroundImage: mainImage!, mainImage: mainImage!, description: description)
                    etiquetteList.append(newEtiquette)
                    print("에티켓 리스트 업데이트 됨")
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.recommendedEtiquetteCollectionView.reloadData()
            }
            
        }
    }


}



extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            return 6
        }
        else {
            return etiquetteList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentItemCell", for: indexPath) as? RecentItemCell else { return UICollectionViewCell()}
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendItemCell", for: indexPath) as? RecommendItemCell else { return UICollectionViewCell()}
            let etiquette = etiquetteList[indexPath.row]
            cell.configureUI(etiquette)
            return cell
        }
        
    }
    
}


