//
//  ViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit
import SnapKit
import Then
import Gifu

class MainViewController: BaseViewController {
    let mainViewModel = MainViewModel(name: "이찬호", level: "지성인",etiquetteContent: "소개팅 자리를 나가기 전에는 양치를 꼭 하고 나가야 합니다.")
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainView.mainViewModel = mainViewModel
        mainView.recentlyEtiquetteCollectionView.delegate = self
        mainView.recentlyEtiquetteCollectionView.dataSource = self
        mainView.recentlyEtiquetteCollectionView.register(RecentItemCell.self, forCellWithReuseIdentifier: "RecentItemCell")
        mainView.recommendEtiquetteCollectionView.delegate = self
        mainView.recommendEtiquetteCollectionView.dataSource = self
        mainView.recommendEtiquetteCollectionView.register(RecommendItemCell.self, forCellWithReuseIdentifier: "RecommendItemCell")
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            return 10
        }
        else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.recentlyEtiquetteCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentItemCell", for: indexPath)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendItemCell", for: indexPath)
            return cell
        }
        
    }
    
}


