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
    }
    
    // MARK: - Methods
    func setupAddTarget(){
        detailView.firstDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        detailView.secondDetailView.beforeInButton.addTarget(self, action: #selector(contextualButtonTapped), for: .touchUpInside)
        detailView.secondDetailView.afterInButton.addTarget(self, action: #selector(contextualButtonTapped), for: .touchUpInside)
        detailView.secondDetailView.beforeOutButton.addTarget(self, action: #selector(contextualButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func contextualButtonTapped(sender: UIButton) {
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
}
