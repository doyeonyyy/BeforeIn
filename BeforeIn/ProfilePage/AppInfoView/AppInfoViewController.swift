//
//  AppInfoViewController.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/28/23.
//

import UIKit
import SnapKit

class AppInfoViewController: BaseViewController {
    
    // MARK: - Properties
    let AppInfoCellList = ["앱 버전", "공지사항", "서비스 이용약관", "개인정보 처리방침", "피드백 남기기"]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
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
        self.title = "앱 정보"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AppInfoCell")
    }

    
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension AppInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppInfoCellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppInfoCell", for: indexPath)
        cell.textLabel?.text = AppInfoCellList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if indexPath.row == 0 {
            cell.accessoryType = .none
        } else {
            cell.textLabel?.text = AppInfoCellList[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
           let NoticeVC = NoticeViewController()
           self.navigationController?.pushViewController(NoticeVC, animated: true)
       } else if indexPath.row == 1 {
           let TermsAndConditionsVC = TermsAndConditionsViewController()
           self.navigationController?.pushViewController(TermsAndConditionsVC, animated: true)
       } else if indexPath.row == 2 {
           let PrivacyPolicyVC = PrivacyPolicyViewController()
           self.navigationController?.pushViewController(PrivacyPolicyVC, animated: true)
       }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


