//
//  DetailViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    private let detailView = DetailView()
    /// 더미데이터
    private let dummyTitle: [String] = ["흰색 의상은 피해주세요.", "굶고 가지 마세요", "춤추지 마세요"]
    private let dummyDescription = "신부의 아름다운 드레스를 위해 참아주세요"

    // MARK: - Life Cycle
    override func loadView(){
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupAddTarget()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDontsCollectionView()
    }
    
    // MARK: - Methods
    func setupAddTarget(){
        /// firstDetailView
        detailView.firstDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureDontsCollectionView() {
        /// secondDetailView
        detailView.secondDetailView.dontsCollectionView.register(EtiquetteDetailCell.self, forCellWithReuseIdentifier: "EtiquetteDetailCell")
        detailView.secondDetailView.dontsCollectionView.dataSource = self
        detailView.secondDetailView.dontsCollectionView.delegate = self
        /// thirdDetailView
        detailView.thirdDetailView.dosCollectionView.register(EtiquetteDetailCell.self, forCellWithReuseIdentifier: "EtiquetteDetailCell")
        detailView.thirdDetailView.dosCollectionView.dataSource = self
        detailView.thirdDetailView.dosCollectionView.delegate = self
    }
    
    private func setUI() {
        /// secondDetailView
        detailView.secondDetailView.etiquetteTotalCountLabel.text = "/\(dummyTitle.count)"
        /// thirdDetailView
        detailView.thirdDetailView.etiquetteTotalCountLabel.text = "/\(dummyTitle.count)"
    }
    
    
    // MARK: - @objc
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - CollectionView
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailView.secondDetailView.dontsCollectionView {
            /// dontsCollectionView 내용
            return dummyTitle.count
        } else if collectionView == detailView.thirdDetailView.dosCollectionView {
            /// dosCollectionView 내용
            return dummyTitle.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EtiquetteDetailCell", for: indexPath) as! EtiquetteDetailCell

        if collectionView == detailView.secondDetailView.dontsCollectionView {
            /// dontsCollectionView 내용
            cell.backgroundColor = .clear
            cell.titleLabel.text = "11\(dummyTitle[indexPath.row])"
            cell.descriptionLabel.text = "11\(dummyDescription)"
        } else if collectionView == detailView.thirdDetailView.dosCollectionView {
            /// dosCollectionView 내용
            cell.backgroundColor = .clear
            cell.titleLabel.text = "22\(dummyTitle[indexPath.row])"
            cell.descriptionLabel.text = "22\(dummyDescription)"
        }
        return cell
    }
}
