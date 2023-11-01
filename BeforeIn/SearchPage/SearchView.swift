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
    }
    
    lazy var searchButton = UIButton().then {
        let image = UIImage(systemName: "magnifyingglass")
        $0.setImage(image, for: .normal)
        $0.tintColor = .darkGray
        $0.backgroundColor = .none
    }
    
    let categoryCollectionViewLayout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 8
        $0.itemSize = CGSize(width: 82, height: 30)
    }

    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryCollectionViewLayout).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    let divider = UIView().then {
        $0.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 20
        $0.itemSize = CGSize(width: 345, height: 116)
    }

    lazy var etiquetteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)

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
        addSubview(searchTextField)
        addSubview(searchButton)
        addSubview(categoryCollectionView)
        addSubview(divider)
        addSubview(etiquetteCollectionView)
    }
    
    func configureUI() {
        
        // makeConstraints
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-16)
            $0.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField)
            $0.trailing.equalToSuperview().offset(-24)
            $0.width.equalTo(41)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(self)
            $0.height.equalTo(35)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            $0.height.equalTo(1)
            $0.leading.trailing.width.equalToSuperview()
        }
        
        etiquetteCollectionView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
