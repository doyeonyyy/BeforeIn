//
//  DisplayViewController.swift
//  BeforeIn
//
import UIKit
import SnapKit
import Then

class DisplayViewController: UIViewController {
    
    // MARK: - Properties
    private var isDarkMode = false
    
    private let customView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let lightModePreviewImage = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let darkModePreviewImage = UIView().then {
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let lightModeLabel = UILabel().then {
        $0.text = "라이트 모드"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let darkModeLabel = UILabel().then {
        $0.text = "다크 모드"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let lightModeCheckButton = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    private let darkModeCheckButton = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userInterfaceStyleDetection()
        setTapGesture()
    }
    
    
    // MARK: - Methods
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        self.title = "화면 설정"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        /// addSubview
        view.addSubview(customView)
        view.addSubview(lightModePreviewImage)
        view.addSubview(darkModePreviewImage)
        view.addSubview(lightModeLabel)
        view.addSubview(darkModeLabel)
        view.addSubview(lightModeCheckButton)
        view.addSubview(darkModeCheckButton)
        
        /// makeConstraints
        customView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.width.equalTo(345)
            make.height.equalTo(333)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        lightModePreviewImage.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(180)
            make.leading.equalTo(view.snp.leading).offset(69)
            make.top.equalTo(customView.snp.top).offset(32)
        }
        
        darkModePreviewImage.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(180)
            make.trailing.equalTo(view.snp.trailing).offset(-69)
            make.top.equalTo(customView.snp.top).offset(32)
        }
        
        lightModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(lightModePreviewImage.snp.centerX)
            make.top.equalTo(lightModePreviewImage.snp.bottom).offset(16)
        }
        
        darkModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(darkModePreviewImage.snp.centerX)
            make.top.equalTo(darkModePreviewImage.snp.bottom).offset(16)
        }
        
        lightModeCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.centerX.equalTo(lightModeLabel.snp.centerX)
            make.top.equalTo(lightModeLabel.snp.bottom).offset(16)
        }
        
        darkModeCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.centerX.equalTo(darkModeLabel.snp.centerX)
            make.top.equalTo(darkModeLabel.snp.bottom).offset(16)
        }
    }
    
    private func userInterfaceStyleDetection() {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        switch userInterfaceStyle {
        case .light:
            lightModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
            darkModeCheckButton.image = UIImage(systemName: "circle")
        case .dark:
            lightModeCheckButton.image = UIImage(systemName: "circle")
            darkModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
        default:
            break
        }
    }
    
    private func setTapGesture() {
        let lightModePreviewImageTapped = UITapGestureRecognizer(target: self, action: #selector(lightModeTapped))
        lightModePreviewImage.addGestureRecognizer(lightModePreviewImageTapped)
        lightModePreviewImage.isUserInteractionEnabled = true
        let lightModeLabelTapped = UITapGestureRecognizer(target: self, action: #selector(lightModeTapped))
        lightModeLabel.addGestureRecognizer(lightModeLabelTapped)
        lightModeLabel.isUserInteractionEnabled = true
        let lightModeCheckButtonTapped = UITapGestureRecognizer(target: self, action: #selector(lightModeTapped))
        lightModeCheckButton.addGestureRecognizer(lightModeCheckButtonTapped)
        lightModeCheckButton.isUserInteractionEnabled = true
        
        let darkModePreviewImageTapped = UITapGestureRecognizer(target: self, action: #selector(darkModeTapped))
        darkModePreviewImage.addGestureRecognizer(darkModePreviewImageTapped)
        darkModePreviewImage.isUserInteractionEnabled = true
        let darkModeLabelTapped = UITapGestureRecognizer(target: self, action: #selector(darkModeTapped))
        darkModeLabel.addGestureRecognizer(darkModeLabelTapped)
        darkModeLabel.isUserInteractionEnabled = true
        let darkModeCheckButtonTapped = UITapGestureRecognizer(target: self, action: #selector(darkModeTapped))
        darkModeCheckButton.addGestureRecognizer(darkModeCheckButtonTapped)
        darkModeCheckButton.isUserInteractionEnabled = true
    }
    
    // MARK: - @objc
    @objc func lightModeTapped() {
        isDarkMode = false
        self.view.window?.overrideUserInterfaceStyle = .light

        lightModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
        darkModeCheckButton.image = UIImage(systemName: "circle")
    }
    
    @objc func darkModeTapped() {
        isDarkMode = true
        self.view.window?.overrideUserInterfaceStyle = .dark

        lightModeCheckButton.image = UIImage(systemName: "circle")
        darkModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
    }
}
