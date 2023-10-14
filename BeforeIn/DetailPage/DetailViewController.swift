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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailView.secondDetailView.beforeInButton.sendActions(for: .touchUpInside)
        detailView.thirdDetailView.beforeInButton.sendActions(for: .touchUpInside)
        configureDontsCollectionView()
    }
    
    // MARK: - Methods
    func setupAddTarget(){
        /// firstDetailView
        detailView.firstDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        /// secondDetailView
        detailView.secondDetailView.beforeInButton.addTarget(self, action: #selector(dontsContextualButtonTapped), for: .touchUpInside)
        detailView.secondDetailView.afterInButton.addTarget(self, action: #selector(dontsContextualButtonTapped), for: .touchUpInside)
        detailView.secondDetailView.beforeOutButton.addTarget(self, action: #selector(dontsContextualButtonTapped), for: .touchUpInside)
        /// thirdDetailView
        detailView.thirdDetailView.beforeInButton.addTarget(self, action: #selector(dosContextualButtonTapped), for: .touchUpInside)
        detailView.thirdDetailView.afterInButton.addTarget(self, action: #selector(dosContextualButtonTapped), for: .touchUpInside)
        detailView.thirdDetailView.beforeOutButton.addTarget(self, action: #selector(dosContextualButtonTapped), for: .touchUpInside)
    }
    
    private func configureDontsCollectionView() {
        /// secondDetailView
        detailView.secondDetailView.dontsCollectionView.register(DontsCell.self, forCellWithReuseIdentifier: "DontsCell")
        detailView.secondDetailView.dontsCollectionView.dataSource = self
        detailView.secondDetailView.dontsCollectionView.delegate = self
        /// thirdDetailView
        detailView.thirdDetailView.dosCollectionView.register(DontsCell.self, forCellWithReuseIdentifier: "DontsCell")
        detailView.thirdDetailView.dosCollectionView.dataSource = self
        detailView.thirdDetailView.dosCollectionView.delegate = self
    }
    
    
    // MARK: - @objc
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dontsContextualButtonTapped(sender: UIButton) {
        let boldFont = UIFont.systemFont(ofSize: 20, weight: .black)

        detailView.secondDetailView.beforeInButton.setTitleColor(.lightGray, for: .normal)
        detailView.secondDetailView.afterInButton.setTitleColor(.lightGray, for: .normal)
        detailView.secondDetailView.beforeOutButton.setTitleColor(.lightGray, for: .normal)

        sender.setTitleColor(.beforeInRed, for: .normal)
        sender.titleLabel?.font = boldFont
        
        switch sender {
            case detailView.secondDetailView.beforeInButton:
                print("'들어가기전' 버튼 누름")
                // TODO: - 들어가기전 버튼 터치시 작업 내용
            case detailView.secondDetailView.afterInButton:
                print("'들어가서' 버튼 누름")
                // TODO: - 들어가서 버튼 터치시 작업 내용
            case detailView.secondDetailView.beforeOutButton:
                print("'나오면서' 버튼 누름")
                // TODO: - 나오면서 버튼 터치시 작업 내용
            default:
                break
        }
    }
    
    @objc func dosContextualButtonTapped(sender: UIButton) {
        let boldFont = UIFont.systemFont(ofSize: 20, weight: .black)

        detailView.thirdDetailView.beforeInButton.setTitleColor(.lightGray, for: .normal)
        detailView.thirdDetailView.afterInButton.setTitleColor(.lightGray, for: .normal)
        detailView.thirdDetailView.beforeOutButton.setTitleColor(.lightGray, for: .normal)

        sender.setTitleColor(.beforeInBlue, for: .normal)
        sender.titleLabel?.font = boldFont
        
        switch sender {
            case detailView.thirdDetailView.beforeInButton:
                print("'들어가기전' 버튼 누름")
                // TODO: - 들어가기전 버튼 터치시 작업 내용
            case detailView.thirdDetailView.afterInButton:
                print("'들어가서' 버튼 누름")
                // TODO: - 들어가서 버튼 터치시 작업 내용
            case detailView.thirdDetailView.beforeOutButton:
                print("'나오면서' 버튼 누름")
                // TODO: - 나오면서 버튼 터치시 작업 내용
            default:
                break
        }
    }
    
}

// MARK: - dontsCollectionView / dosCollectionView
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DontsCell", for: indexPath) as! DontsCell
        cell.backgroundColor = .clear
        cell.titleLabel.text = dummyTitle[indexPath.row]
        cell.descriptionLabel.text = dummyDescription
        return cell
    }
}
