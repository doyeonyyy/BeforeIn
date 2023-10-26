


import UIKit
import SnapKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let infoCancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 16
        return tableView
    }()
    
    
    let infoDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cellIdentifier = "InfoCell"
    let tableData = ["서비스 이용약관", "개인정보 처리방침", "위치기반서비스 이용약관"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(infoCancelButton)
        view.addSubview(tableView)
        view.addSubview(infoDoneButton)
        infoCancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        infoDoneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        
        infoCancelButton.snp.makeConstraints { make in
            make.width.equalTo(41)
            make.height.equalTo(27)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.top.equalTo(view.snp.top).offset(24)
        }
        
        infoDoneButton.snp.makeConstraints { make in
            make.width.equalTo(41)
            make.height.equalTo(27)
            make.trailing.equalTo(view.snp.trailing).offset(-24)
            make.top.equalTo(view.snp.top).offset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(238)
            make.top.equalTo(infoCancelButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20) // 원하는 폰트 및 크기로 설정
        cell.accessoryType = .disclosureIndicator // 화살표 아이콘 추가

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
