//
//  AppInfoViewController.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/28/23.
//

import UIKit
import SnapKit
import MessageUI

class AppInfoViewController: BaseViewController {
    
    // MARK: - Properties
    let AppInfoCellList = ["공지사항", "서비스 이용약관", "개인정보 처리방침", "문의하기", "앱 버전"]
    let AppVersion = "1.2"
    
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
        
        if indexPath.row == AppInfoCellList.count - 1 {
            let appVersionLabel = UILabel()
            appVersionLabel.text = AppVersion
            appVersionLabel.textAlignment = .center
            appVersionLabel.font = UIFont.systemFont(ofSize: 16)
            appVersionLabel.sizeToFit()
            cell.accessoryView = appVersionLabel
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
        } else if indexPath.row == 3 {
            setMail()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - MFMailComposeViewControllerDelegat
extension AppInfoViewController: MFMailComposeViewControllerDelegate {
    
    func setMail() {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
        
        if MFMailComposeViewController.canSendMail() {
            
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            
            compseVC.setToRecipients([Secret.email])
            compseVC.setSubject("비포인 오류 및 문의사항")
            compseVC.setMessageBody("""
                                       앱을 사용하면서 발생한 오류 및 문의사항을 입력해주세요.
                                       
                                       App Version: \(appVersion)
                                       Device: \(UIDevice.iPhoneModel)
                                       OS: \(UIDevice.iOSVersion)
                                       
                                       사용자 아이디: "사용중이신 아이디를 입력해주세요."
                                       
                                       오류 및 문의사항: "오류 및 문의사항을 입력해주세요."
                                       
                                       """, isHTML: false)
            
            self.present(compseVC, animated: true, completion: nil)
            
        }
        else {
            self.showSendMailErrorAlert()
        }
    }
    
    func showSendMailErrorAlert() {
        let message = """
        이메일 설정을 확인하고 다시 시도해주세요.
        아이폰 설정 > Mail > 계정 > 계정추가
        """
        
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { (action) in
        }
        
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    
    @objc func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
