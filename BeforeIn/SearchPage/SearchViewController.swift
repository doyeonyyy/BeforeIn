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
    private let etiquetteCategories: [String] = ["전체", "경조사", "일상에서", "교통", "운동"]
    /// 더미데이터
    private let dummyEtiquetteTitle: [String] = ["영화관", "도서관", "소개팅", "목욕탕", "찜질방", "반려동물 산책 시"]
    
    private lazy var searchTextField = UITextField().then {
        $0.placeholder = "검색어를 입력하세요"
        $0.borderStyle = .none
        $0.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addLeftPadding(8)
        $0.rightView = searchButtonContainer
        $0.rightViewMode = .unlessEditing
    }
    
    private lazy var searchButton = UIButton().then{
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private lazy var searchButtonContainer = UIView().then {
        $0.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
        }
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .none
        $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private lazy var categoryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let divider = UIView().then {
        $0.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
    }
    
    private let etiquetteTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
//        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods & Selectors
    func configureUI() {
        navigationController?.isNavigationBarHidden = true

        addButtonsToCategoryStackView()
        configureTableView()
        
        // addSubview
        scrollView.addSubview(categoryStackView)
        
        view.addSubview(searchTextField)
        view.addSubview(cancelButton)
        view.addSubview(scrollView)
        view.addSubview(divider)
        view.addSubview(etiquetteTableView)
        
        // makeConstraints
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20) // TODO: top 60을 어디를 기준으로 잡아야할지..
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-16)
            $0.height.equalTo(50)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        categoryStackView.snp.makeConstraints {
            $0.top.leading.trailing.height.centerY.equalTo(scrollView)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryStackView.snp.bottom).offset(16)
            $0.height.equalTo(3)
            $0.width.equalToSuperview()
        }
        
        etiquetteTableView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
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
            categoryStackView.addArrangedSubview(button)
        }
    }
    
    private func configureTableView() {
        etiquetteTableView.register(EtiquetteTableViewCell.self, forCellReuseIdentifier: "EtiquetteTableViewCell")
        etiquetteTableView.dataSource = self
        etiquetteTableView.delegate = self
        
    }
    
    @objc func searchButtonTapped() {
        print("검색 버튼 터치")
        // TODO: 검색 버튼 터치시 작업 내용
    }
    
    @objc func cancelButtonTapped() {
        print("취소 버튼 터치")
        // TODO: 취소 버튼 터치시 작업 내용
    }
    @objc func categoryButtonTapped(_ sender: UIButton) {
        
        for subview in categoryStackView.arrangedSubviews {
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
            print("전체 누름")
        case 1:
            print("경조사 누름")
        case 2:
            print("일상에서 누름")
        case 3:
            print("교통 누름")
        case 4:
            print("운동 누름")
        default:
            break
        }
        
    }
}

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
