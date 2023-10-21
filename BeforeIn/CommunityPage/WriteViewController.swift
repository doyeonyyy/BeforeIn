


import UIKit
import SnapKit

class WriteViewController: UIViewController {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let mainCustomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        view.layer.cornerRadius = 6
        return view
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let contentsCustomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    let categoryMainLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리 설정"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let categoryView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "요즘 문화"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        return label
    }()
    
    let categoryView2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
        return view
    }()
    
    let categoryLabel2: UILabel = {
        let label = UILabel()
        label.text = "우리 끼리"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        return label
    }()
    
    let buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        view.layer.cornerRadius = 26
        return view
    }()
    
    let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "글 올리기"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainLabel)
        view.addSubview(contentsLabel)
        view.addSubview(mainCustomView)
        view.addSubview(contentsCustomView)
        view.addSubview(categoryMainLabel)
        view.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        view.addSubview(categoryView2)
        categoryView2.addSubview(categoryLabel2)
        view.addSubview(buttonView)
        buttonView.addSubview(buttonLabel)
        
        
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(120)
        }
        
        mainCustomView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
            make.width.equalTo(361)
            make.height.equalTo(44)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(mainCustomView.snp.bottom).offset(24)
        }
        
        contentsCustomView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(contentsLabel.snp.bottom).offset(8)
            make.width.equalTo(361)
            make.height.equalTo(140)
        }
        
        categoryMainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(contentsCustomView.snp.bottom).offset(24)
            
        }
        
        categoryView.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(16)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(categoryView)
        }
        
        categoryView2.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(16)
            make.leading.equalTo(categoryView.snp.trailing).offset(8)
        }
        
        categoryLabel2.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(categoryView2)
        }
        
        buttonView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(categoryView2.snp.bottom).offset(120)
            make.width.equalTo(361)
            make.height.equalTo(44)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(buttonView)
        }
    }
    
}
