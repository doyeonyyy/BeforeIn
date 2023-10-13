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
    private let etiquetteCategories: [String] = ["전체", "경조사", "일상에서", "교통", "운동"]
    
    /// 더미데이터
    private let dummyEtiquetteTitle: [String] = ["영화관", "도서관", "소개팅", "목욕탕", "찜질방", "반려동물 산책 시"]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupAddTarget()
        addButtonsToCategoryStackView()
        configureTableView()
    }
    
    // MARK: - Methods
    override func loadView() {
        view = searchView
    }
    
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
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24) // TODO: contentEdgeInsets 대체제 찾기
//            button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 24, bottom: 5, trailing: 24)
            button.layer.cornerRadius = 16.5
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .black)
            button.tag = index
            searchView.categoryStackView.addArrangedSubview(button)
        }
    }
    
    private func configureTableView() {
        searchView.etiquetteTableView.register(EtiquetteTableViewCell.self, forCellReuseIdentifier: "EtiquetteTableViewCell")
        searchView.etiquetteTableView.dataSource = self
        searchView.etiquetteTableView.delegate = self
    }
    
    // MARK: - @objc
    @objc func searchButtonTapped() {
        print("검색 버튼 터치")
        // TODO: 검색 버튼 터치시 작업 내용
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

        sender.backgroundColor = UIColor.beforeInRed
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
// MARK: - TableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyEtiquetteTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EtiquetteTableViewCell", for: indexPath) as! EtiquetteTableViewCell
        cell.titleLabel.text = dummyEtiquetteTitle[indexPath.row]
        cell.descriptionLabel.text = "설명이이자리에들어옵니다설명이이자리에들어옵니다설명이이자리에들어옵니다설명이이자리에들어옵니다설명이이자리에들어옵니다"
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12 // 원하는 간격으로 설정
    }
    
    
}
