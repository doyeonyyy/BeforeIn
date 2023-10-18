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
    private let etiquetteCategories: [String] = ["전체", "경조사", "일상에서", "교통", "운동"]
    
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
        searchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        searchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
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
    }
    
    // MARK: - @objc
    @objc func searchButtonTapped() {
        searchViewModel.searchEtiquette()
    }
    
    @objc func cancelButtonTapped() {
        print("취소 버튼 터치")
        // TODO: 취소 버튼 터치시 작업 내용
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

        // TODO: 카테고리 버튼 index 번호에 따른 터치시 작업 내용
        switch sender.tag {
        case 0:
            print("에티켓 카테고리 - '전체' 누름")
        case 1:
            print("에티켓 카테고리 - '경조사' 누름")
        case 2:
            print("에티켓 카테고리 - '일상에서' 누름")
        case 3:
            print("에티켓 카테고리 - '교통' 누름")
        case 4:
            print("에티켓 카테고리 - '운동' 누름")
        default:
            break
        }
        
    }
}
// MARK: - etiquetteCollectionView
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return etiquetteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EtiquetteCell", for: indexPath) as! EtiquetteCell
        
        let etiquette = etiquetteList[indexPath.row]
        
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
