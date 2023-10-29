//
//  TermsAndPolicyViewController.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/28/23.
//

import UIKit
import SnapKit

class TermsAndPolicyViewController: UIViewController {
    
    // MARK: - Properties
    let TermsAndPolicyCellList = ["서비스 이용약관", "개인정보 처리방침", "피드백 남기기"]
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTableView()
    }

    // MARK: - Methods
    private func configureUI() {
        
        setNavigationBar()
        
        // addSubView
        view.addSubview(tableView)
        
        // makeConstraints
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        view.backgroundColor = .systemBackground
        self.title = "약관 및 정책"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TermsAndPolicyCell")
    }
    
}

extension TermsAndPolicyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TermsAndPolicyCellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TermsAndPolicyCell", for: indexPath)
        cell.textLabel?.text = TermsAndPolicyCellList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


