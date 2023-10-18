//
//  SearchViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import SnapKit
import Then
import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    private let searchView = SearchView()
    private let searchViewModel = SearchViewModel()
    private let etiquetteCategories: [String] = ["전체", "경조사", "일상에서", "대중교통", "공공장소"]
    var filteredEtiquetteList: [Etiquette] = etiquetteList
    var etiquetteCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        addButtonsToCategoryStackView()
        configureCollectionView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let categoryButton = searchView.categoryStackView.arrangedSubviews.first as? UIButton {
            categoryButton.sendActions(for: .touchUpInside)
        }
    }
    
    // MARK: - Methods
    func setupAddTarget(){
        searchView.searchButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    private func addButtonsToCategoryStackView() {
        for (index, category) in etiquetteCategories.enumerated() {
            let button = UIButton()
            button.setTitle(category, for: .normal)
            button.setTitleColor(.BeforeInRed, for: .normal)
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.BeforeInRed?.cgColor
            button.layer.borderWidth = 1
            button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
            // TODO: contentEdgeInsets 대체제 찾기
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24)
            button.layer.cornerRadius = 16.5
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
            button.tag = index
            searchView.categoryStackView.addArrangedSubview(button)
        }
    }
    
    private func configureCollectionView() {
        searchView.etiquetteCollectionView.register(EtiquetteCell.self, forCellWithReuseIdentifier: "EtiquetteCell")
        searchView.etiquetteCollectionView.dataSource = self
        searchView.etiquetteCollectionView.delegate = self
        etiquetteCollectionView = searchView.etiquetteCollectionView
    }
    
    // MARK: - @objc
    @objc func textFieldDidChanged(_ sender: Any?) {
        if let searchText = searchView.searchTextField.text, !searchText.isEmpty {
            searchView.searchButton.setTitle("취소", for: .normal)
            searchView.searchButton.setTitleColor(.black, for: .normal)
            searchView.searchButton.setImage(nil, for: .normal)

            filteredEtiquetteList = searchText.isEmpty ? etiquetteList : etiquetteList.filter { $0.place.lowercased().contains(searchText.lowercased()) }
            self.etiquetteCollectionView.reloadData()
        } else {
            cancelButtonTapped()
        }
    }
    
    @objc func cancelButtonTapped() {
        if let categoryButton = searchView.categoryStackView.arrangedSubviews.first as? UIButton {
            categoryButton.sendActions(for: .touchUpInside)
        }
        
        let image = UIImage(systemName: "magnifyingglass")
        searchView.searchButton.setImage(image, for: .normal)
        searchView.searchButton.tintColor = .darkGray
        searchView.searchButton.setTitle(nil, for: .normal)
        
        searchView.searchTextField.text = ""
        searchView.searchTextField.resignFirstResponder() // 포커스 해제
        
        filteredEtiquetteList = etiquetteList
        self.etiquetteCollectionView.reloadData()
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        for subview in searchView.categoryStackView.arrangedSubviews {
            if let button = subview as? UIButton {
                button.setTitleColor(.BeforeInRed, for: .normal)
                button.backgroundColor = .white
                button.layer.borderColor = UIColor.BeforeInRed?.cgColor
                button.layer.borderWidth = 1
            }
        }

        sender.backgroundColor = UIColor.BeforeInRed
        sender.setTitleColor(.white, for: .normal)
        
        switch sender.tag {
        case 0: // 카테고리 "전체"
            filteredEtiquetteList = etiquetteList
        case 1: // 카테고리 "경조사"
            filteredEtiquetteList = etiquetteList.filter { $0.category == "경조사" }
        case 2: // 카테고리 "일상에서"
            filteredEtiquetteList = etiquetteList.filter { $0.category == "일상에서" }
        case 3: // 카테고리 "대중교통"
            filteredEtiquetteList = etiquetteList.filter { $0.category == "대중교통" }
        case 4: // 카테고리 "공공장소"
            filteredEtiquetteList = etiquetteList.filter { $0.category == "공공장소" }
        default:
            break
        }
        self.etiquetteCollectionView.reloadData()
    }
}
// MARK: - etiquetteCollectionView
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return etiquetteList.count
        return filteredEtiquetteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EtiquetteCell", for: indexPath) as! EtiquetteCell
        
        let etiquette = filteredEtiquetteList[indexPath.row]
        
        cell.imageView.image = etiquette.mainImage
        cell.titleLabel.text = etiquette.place
        cell.descriptionLabel.text = etiquette.content.first

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? EtiquetteCell {
            if let title = cell.titleLabel.text {
                print("컬렉션 뷰 - '\(title)' 셀 누름")
                navigationController?.pushViewController(DetailViewController(), animated: true) // DetailViewController 작업 확인용
            }
        }
    }
}
