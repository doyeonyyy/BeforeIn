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
    private let etiquetteCategories: [String] = ["전체", "경조사", "일상에서", "대중교통", "운동"]
    var filteredEtiquetteList: [Etiquette] = etiquetteList
    var categoryCollectionView: UICollectionView!
    var etiquetteCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupAddTarget()
        configureCollectionView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let indexPath = IndexPath(item: 0, section: 0)
        searchView.categoryCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        collectionView(searchView.categoryCollectionView, didSelectItemAt: indexPath)
        searchView.etiquetteCollectionView.reloadData()
    }
    
    // MARK: - Methods
    func setupAddTarget(){
        searchView.searchButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    private func configureCollectionView() {
        searchView.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        searchView.categoryCollectionView.dataSource = self
        searchView.categoryCollectionView.delegate = self

        searchView.etiquetteCollectionView.register(EtiquetteCell.self, forCellWithReuseIdentifier: "EtiquetteCell")
        searchView.etiquetteCollectionView.dataSource = self
        searchView.etiquetteCollectionView.delegate = self
        
        categoryCollectionView = searchView.categoryCollectionView
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
        let indexPath = IndexPath(item: 0, section: 0)
        searchView.categoryCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        collectionView(searchView.categoryCollectionView, didSelectItemAt: indexPath)
        
        let image = UIImage(systemName: "magnifyingglass")
        searchView.searchButton.setImage(image, for: .normal)
        searchView.searchButton.tintColor = .darkGray
        searchView.searchButton.setTitle(nil, for: .normal)
        
        searchView.searchTextField.text = ""
        searchView.searchTextField.resignFirstResponder()
        
        filteredEtiquetteList = etiquetteList
        self.etiquetteCollectionView.reloadData()
    }
    
}
// MARK: - categoryCollectionView / etiquetteCollectionView
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return etiquetteCategories.count
        } else if collectionView == etiquetteCollectionView {
            return filteredEtiquetteList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.categoryLabel.text = etiquetteCategories[indexPath.row]
            return cell
        } else if collectionView == etiquetteCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EtiquetteCell", for: indexPath) as! EtiquetteCell
            let etiquette = filteredEtiquetteList[indexPath.row]
            cell.imageView.image = etiquette.mainImage
            cell.titleLabel.text = etiquette.place
            cell.descriptionLabel.text = etiquette.description

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let selectedCategory = etiquetteCategories[indexPath.row]
            switch selectedCategory {
                case "전체":
                    filteredEtiquetteList = etiquetteList
                case "경조사":
                    filteredEtiquetteList = etiquetteList.filter { $0.category == "경조사" }
                case "일상에서":
                    filteredEtiquetteList = etiquetteList.filter { $0.category == "일상에서" }
                case "대중교통":
                    filteredEtiquetteList = etiquetteList.filter { $0.category == "대중교통" }
                case "운동":
                    filteredEtiquetteList = etiquetteList.filter { $0.category == "운동" }
                default:
                    break
            }
            
            self.etiquetteCollectionView.reloadData()
            
        } else if collectionView == etiquetteCollectionView {
            let selectedEtiquette = filteredEtiquetteList[indexPath.row]
            EtiquetteManager.shared.fetchRecentlyEtiquetteList(selectedEtiquette)
            let detailVC = DetailViewController()
            detailVC.selectedEtiquette = selectedEtiquette
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
