//
//  DisplayViewController.swift
//  BeforeIn
//
import UIKit
import SnapKit
import Then

class DisplayViewController: BaseViewController {
    
    // MARK: - Properties
    private var isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    private var isSystemMode = UserDefaults.standard.bool(forKey: "isSystemMode")
    
    private let customView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let modeStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 16
    }
    
    private let autoModePreviewImage = UIView().then {
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }
    
    private let whiteView = UIView().then {
        $0.backgroundColor = .white
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
    
    private let autoModeLabel = UILabel().then {
        $0.text = "자동 모드"
        $0.font = UIFont.systemFont(ofSize: 18)
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
    
    private let autoModeCheckButton = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
        $0.tintColor = .systemGray
    }
    
    private let lightModeCheckButton = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
        $0.tintColor = .systemGray
    }
    
    private let darkModeCheckButton = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
        $0.tintColor = .systemGray
    }
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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
        customView.addSubview(modeStackView)
        autoModePreviewImage.addSubview(whiteView)
        
        modeStackView.addArrangedSubview(autoModePreviewImage)
        modeStackView.addArrangedSubview(lightModePreviewImage)
        modeStackView.addArrangedSubview(darkModePreviewImage)
        
        customView.addSubview(lightModeLabel)
        customView.addSubview(lightModeCheckButton)
        
        customView.addSubview(autoModeLabel)
        customView.addSubview(darkModeLabel)
        
        
        customView.addSubview(autoModeCheckButton)
        customView.addSubview(darkModeCheckButton)
        
        /// makeConstraints
        customView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(333)
        }
        
        modeStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().inset(96)
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
//        lightModePreviewImage.snp.makeConstraints { make in
//            make.width.equalTo(88)
//            make.height.equalTo(180)
//            make.top.equalToSuperview().offset(32)
////            make.centerX.equalToSuperview()
//        }
//
//        autoModePreviewImage.snp.makeConstraints { make in
//            make.width.equalTo(88)
//            make.height.equalTo(180)
//            make.top.equalToSuperview().offset(32)
////            make.leading.equalToSuperview().offset(24)
//        }
//
//        darkModePreviewImage.snp.makeConstraints { make in
//            make.width.equalTo(88)
//            make.height.equalTo(180)
//            make.top.equalToSuperview().offset(32)
////            make.leading.equalTo(lightModePreviewImage.snp.trailing).offset(24)
//        }
        
        autoModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(autoModePreviewImage.snp.centerX)
            make.top.equalTo(autoModePreviewImage.snp.bottom).offset(16)
        }
        
        lightModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(lightModePreviewImage.snp.centerX)
            make.top.equalTo(lightModePreviewImage.snp.bottom).offset(16)
        }
        
        darkModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(darkModePreviewImage.snp.centerX)
            make.top.equalTo(darkModePreviewImage.snp.bottom).offset(16)
        }
        
        autoModeCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.centerX.equalTo(autoModeLabel.snp.centerX)
            make.top.equalTo(autoModeLabel.snp.bottom).offset(16)
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
        if isSystemMode {
            autoModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
            lightModeCheckButton.image = UIImage(systemName: "circle")
            darkModeCheckButton.image = UIImage(systemName: "circle")
        }
        else {
            switch isDarkMode {
            case false:
                autoModeCheckButton.image = UIImage(systemName: "circle")
                lightModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
                darkModeCheckButton.image = UIImage(systemName: "circle")
            case true:
                autoModeCheckButton.image = UIImage(systemName: "circle")
                lightModeCheckButton.image = UIImage(systemName: "circle")
                darkModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
            default:
                break
            }
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
        
        let autoModePreviewImageTapped = UITapGestureRecognizer(target: self, action: #selector(autoModeTapped))
        autoModePreviewImage.addGestureRecognizer(autoModePreviewImageTapped)
        autoModePreviewImage.isUserInteractionEnabled = true
        let autoModeLabelTapped = UITapGestureRecognizer(target: self, action: #selector(autoModeTapped))
        autoModeLabel.addGestureRecognizer(autoModeLabelTapped)
        darkModeLabel.isUserInteractionEnabled = true
        let autoModeCheckButtonTapped = UITapGestureRecognizer(target: self, action: #selector(autoModeTapped))
        autoModeCheckButton.addGestureRecognizer(autoModeCheckButtonTapped)
        autoModeCheckButton.isUserInteractionEnabled = true
    }
    
    // MARK: - @objc
    @objc func autoModeTapped() {
        isSystemMode = true
        UserDefaults.standard.setValue(isSystemMode, forKey: "isSystemMode")
        view.window?.overrideUserInterfaceStyle = .unspecified
        
        autoModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
        lightModeCheckButton.image = UIImage(systemName: "circle")
        darkModeCheckButton.image = UIImage(systemName: "circle")
    }

    @objc func lightModeTapped() {
        isSystemMode = false
        isDarkMode = false
        UserDefaults.standard.setValue(isSystemMode, forKey: "isSystemMode")
        UserDefaults.standard.setValue(isDarkMode, forKey: "isDarkMode")
        view.window?.overrideUserInterfaceStyle = .light
        
        autoModeCheckButton.image = UIImage(systemName: "circle")
        lightModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
        darkModeCheckButton.image = UIImage(systemName: "circle")
    }

    @objc func darkModeTapped() {
        isSystemMode = false
        isDarkMode = true
        UserDefaults.standard.setValue(isSystemMode, forKey: "isSystemMode")
        UserDefaults.standard.setValue(isDarkMode, forKey: "isDarkMode")
        view.window?.overrideUserInterfaceStyle = .dark
        
        autoModeCheckButton.image = UIImage(systemName: "circle")
        lightModeCheckButton.image = UIImage(systemName: "circle")
        darkModeCheckButton.image = UIImage(systemName: "checkmark.circle.fill")
    }

}
