//
//  BlockListViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/11/09.
//

import UIKit
import FirebaseFirestore
import NVActivityIndicatorView

class BlockListViewController: BaseViewController {
    let userManager = UserManager()
    var blockList = currentUser.blockList
    var blockNicknameList: [String] = []
    
    let tableView = UITableView().then {
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    let placeholderLabel = UILabel().then {
        $0.text = "차단한 사용자가 없습니다."
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .systemGray
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        fetchBlockList()
        title = "차단 목록"
        setTableView()
        setPlaceholder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    func setTableView() {
        view.addSubview(tableView)
        view.addSubview(placeholderLabel)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlockListCell.self, forCellReuseIdentifier: "BlockListCell")
        
        tableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
    }
    
    func setPlaceholder() {
        if blockList.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
    
    func fetchBlockList() {
        
        let indicator = setupIndicator()
        self.tableView.isHidden = true
        indicator.startAnimating()
        let db = Firestore.firestore()
        let dispatchGroup = DispatchGroup()
        blockNicknameList = []
        for email in blockList {
            dispatchGroup.enter()
            let query = db.collection("User").whereField("email", isEqualTo: email)
            query.getDocuments { (snapshot, error) in
                defer {
                    dispatchGroup.leave()
                }
                if let snapshot = snapshot {
                    let docs = snapshot.documents
                    for doc in docs {
                        if let nickname = doc.get("nickname") as? String {
                            self.blockNicknameList.insert(nickname, at: 0)
                        }
                    }
                }
                
            }
        }
        dispatchGroup.notify(queue: .main) {
            indicator.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func setupIndicator() -> NVActivityIndicatorView {
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 162, y: 100, width: 50, height: 50),
                                                type: .lineSpinFadeLoader,
                                                color: .BeforeInRed,
                                                padding: 0)
        self.view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        return indicator
    }
    
}


// MARK: - UITableViewDelegate
extension BlockListViewController: UITableViewDelegate {


    
}


// MARK: - UITableViewDataSource
extension BlockListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockNicknameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockListCell", for: indexPath) as! BlockListCell
        
        let user = blockList[indexPath.row]
        
        cell.configure(with: user) {
            self.showAlertTwoButton(title: "차단 해제", message: "차단을 해제하시겠습니까?", button1Title: "확인", button2Title: "취소"){
                self.userManager.removeFromBlockList(userEmail: user) { success in
                    if success {
                        DispatchQueue.main.async {
                            self.blockNicknameList.remove(at: indexPath.row)
                            self.blockList = currentUser.blockList
                            self.showAlertOneButton(title: "차단 해제", message: "차단이 해제되었습니다.", buttonTitle: "확인")
                            tableView.reloadData()
                            self.setPlaceholder()
                        }
                    } else {
                        self.showAlertOneButton(title: "차단 해제 실패", message: "차단 해제 실패했습니다.", buttonTitle: "확인")
                    }
                }
            }
        }
        let nickname = blockNicknameList[indexPath.row]
        cell.nameLabel.text = nickname
        
        return cell
    }
    
    
    
    

}
