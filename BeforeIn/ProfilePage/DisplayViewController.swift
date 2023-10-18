


import UIKit
import SnapKit

class DisplayViewController: UIViewController {
        
    let disCancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let customView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 4, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lightrectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.917, green: 0.917, blue: 0.917, alpha: 1)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let darkrectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0.036, blue: 0.358, alpha: 1)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lightModeLabel: UILabel = {
        let label = UILabel()
        label.text = "라이트 모드"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let darkModeLabel: UILabel = {
        let label = UILabel()
        label.text = "다크 모드"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lightModeCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let darkModeCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isDarkMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        disCancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        
        
        let lightModeTapGesture = UITapGestureRecognizer(target: self, action: #selector(lightModeTapped))
        lightModeCircle.addGestureRecognizer(lightModeTapGesture)
        lightModeCircle.isUserInteractionEnabled = true
        
        let darkModeTapGesture = UITapGestureRecognizer(target: self, action: #selector(darkModeTapped))
        darkModeCircle.addGestureRecognizer(darkModeTapGesture)
        darkModeCircle.isUserInteractionEnabled = true
    }
    
    @objc func lightModeTapped() {
        if isDarkMode == true {
            isDarkMode = false
        }
        if isDarkMode == true {
            lightModeCircle.backgroundColor = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
            lightModeCircle.layer.borderWidth = 0
            darkModeCircle.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
            darkModeCircle.layer.borderWidth = 1
        }
        else {
            lightModeCircle.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
            lightModeCircle.layer.borderWidth = 1
            darkModeCircle.backgroundColor = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
            darkModeCircle.layer.borderWidth = 0
        }
    }
    
    @objc func darkModeTapped() {
        if isDarkMode == false {
            isDarkMode = true
        }
        if isDarkMode == false {
            lightModeCircle.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
            lightModeCircle.layer.borderWidth = 1
            darkModeCircle.backgroundColor = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
            darkModeCircle.layer.borderWidth = 0
        }
        else {
            lightModeCircle.backgroundColor = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
            lightModeCircle.layer.borderWidth = 0
            darkModeCircle.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
            darkModeCircle.layer.borderWidth = 1
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
        view.addSubview(disCancelButton)
        view.addSubview(doneButton)
        view.addSubview(customView)
        view.addSubview(lightrectangleView)
        view.addSubview(darkrectangleView)
        view.addSubview(lightModeLabel)
        view.addSubview(darkModeLabel)
        view.addSubview(lightModeCircle)
        view.addSubview(darkModeCircle)
        
        disCancelButton.snp.makeConstraints { make in
            make.width.equalTo(41)
            make.height.equalTo(27)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.top.equalTo(view.snp.top).offset(24)
        }
        
        doneButton.snp.makeConstraints { make in
            make.width.equalTo(41)
            make.height.equalTo(27)
            make.trailing.equalTo(view.snp.trailing).offset(-24)
            make.top.equalTo(view.snp.top).offset(24)
        }
                
        customView.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(333)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.top.equalTo(view.snp.top).offset(88)
        }
        
        lightrectangleView.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(180)
            make.leading.equalTo(view.snp.leading).offset(69)
            make.top.equalTo(customView.snp.top).offset(32)
        }

        darkrectangleView.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(180)
            make.trailing.equalTo(view.snp.trailing).offset(-69)
            make.top.equalTo(customView.snp.top).offset(32)
        }
        
        lightModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(lightrectangleView.snp.centerX)
            make.top.equalTo(lightrectangleView.snp.bottom).offset(16)
        }
        
        darkModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(darkrectangleView.snp.centerX)
            make.top.equalTo(darkrectangleView.snp.bottom).offset(16)
        }
        
        lightModeCircle.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
            make.centerX.equalTo(lightModeLabel.snp.centerX)
            make.top.equalTo(lightModeLabel.snp.bottom).offset(16)
        }
        
        darkModeCircle.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
            make.centerX.equalTo(darkModeLabel.snp.centerX)
            make.top.equalTo(darkModeLabel.snp.bottom).offset(16)
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
