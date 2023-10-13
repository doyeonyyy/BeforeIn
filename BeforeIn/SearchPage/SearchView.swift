//
//  SearchView.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/13/23.
//

import UIKit

class SearchView: UIView {

    // MARK: - UI Properties
    lazy var searchTextField = UITextField().then {
        $0.placeholder = "검색어를 입력하세요"
        $0.borderStyle = .none
        $0.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addLeftPadding(8)
        $0.rightView = searchButtonContainer
        $0.rightViewMode = .unlessEditing
    }
    
    lazy var searchButton = UIButton().then{
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .gray
    }
    
    lazy var searchButtonContainer = UIView().then {
        $0.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
        }
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .none
    }
    
    lazy var categoryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    let divider = UIView().then {
        $0.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 24
        $0.itemSize = CGSize(width: 345, height: 116)
    }

    lazy var etiquetteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func addSubview(){
        scrollView.addSubview(categoryStackView)
        
        addSubview(searchTextField)
        addSubview(cancelButton)
        addSubview(scrollView)
        addSubview(divider)
        addSubview(etiquetteCollectionView)
    }
    
    func configureUI() {
        
        // makeConstraints
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
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
            $0.trailing.equalTo(self)
            $0.height.equalTo(35)
        }
        
        categoryStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.height.centerY.equalTo(scrollView)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryStackView.snp.bottom).offset(16)
            $0.height.equalTo(3)
            $0.leading.trailing.width.equalToSuperview()
        }
        
        etiquetteCollectionView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
