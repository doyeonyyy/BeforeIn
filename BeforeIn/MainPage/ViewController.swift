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
    
    private var user1 = User(email: "lcho3878@naver.com", name: "이찬호", nickname: "lcho3878", profileImage: UIImage(systemName: "person.fill")!, level: 5)
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
        firebaseDB = Database.database().reference()
        firebaseDB.child("SavedData/Etiquette/").getData{ error, snapshot in
            guard error == nil else {
                return
            }
            etiquetteList = []
            let data = snapshot?.value as! [String: Any]
            for key in data.keys{
                let etiquette = data[key] as! [String: Any]
                let category = etiquette["category"] as! String
                let place = etiquette["place"] as! String
                let content = etiquette["content"] as! [String]
                let gsLink = etiquette["gsReference"] as! String
                print("\(place) : \(content)")
                var mainImage = UIImage(systemName: "person.fill")
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let gsReference = storage.reference(forURL: gsLink)
                gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        // Uh-oh, an error occurred!
                        print("\(place) 사진 로드 실패")
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async{
                            print("\(place) 사진 로드 성공")
                            mainImage = image
                            let newEtiquette = Etiquette(category: category, place: place, content: content, backgroundImage: mainImage!, mainImage: mainImage!)
                            etiquetteList.append(newEtiquette)
                            self.recommendedEtiquetteCollectionView.reloadData()
                        }
                    }
                }
            }
        }
        
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            return 10
        }
        else {
            return etiquetteList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentItemCell", for: indexPath)
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


