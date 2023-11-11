



import UIKit
import FirebaseAuth
import SnapKit
import PhotosUI

class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    var picker: PHPickerViewController?
    let userManager = UserManager()
    let profileView = ProfileView()
    let header = ["커뮤니티", "기기설정", "계정관리"]
    private let cellData = [["차단한 사용자", "에티켓숲 이용규칙"], ["화면설정", "앱 정보"], ["비밀번호 변경", "로그아웃", "회원탈퇴"]]
    
    // MARK: - Life Cycle
    override func loadView() {
        view = profileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileView.profileViewModel?.updateUser(currentUser)
        profileView.updateProfileImage()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.profileViewModel = ProfileViewModel(user: currentUser)
        setPicker()
        setTableView()
        addTarget()
        //        configureUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Methods
    
    func setTableView(){
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
        profileView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        profileView.tableView.separatorStyle = .none
    }
    
    func setPicker(){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        picker = PHPickerViewController(configuration: configuration)
    }
    
    func addTarget(){
        profileView.editNicknameButton.addTarget(self, action: #selector(editNicknameButtonTapped), for: .touchUpInside)
        profileView.editProfileButton.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
    }
    
    
    
    // MARK: - @objc
    @objc func editNicknameButtonTapped() {
        let nicknameEditVC = NicknameEditViewController()
        self.navigationController?.pushViewController(nicknameEditVC, animated: true)
    }
    
    @objc func editProfileButtonTapped(){
        if let picker = picker {
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
        profileView.updateProfileImage()
    }
    
    
}


// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.textLabel?.text = header[section]
        headerView.textLabel?.textColor = .systemGray2
        headerView.textLabel?.textAlignment = .left
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section < header.count - 1 {
            let footerView = UIView()
            footerView.backgroundColor = .clear
            
            let separatorLine = UIView()
            separatorLine.backgroundColor = .systemGray6
            footerView.addSubview(separatorLine)
            
            separatorLine.snp.makeConstraints { make in
                make.leading.equalTo(footerView.snp.leading)
                make.trailing.equalTo(footerView.snp.trailing)
                make.bottom.equalTo(footerView.snp.bottom).offset(10)
                make.height.equalTo(1)
            }
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < header.count - 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellText = cellData[indexPath.section][indexPath.row]
        
        switch cellText {
        case "차단한 사용자":
            let blockListVC = BlockListViewController()
            self.navigationController?.pushViewController(blockListVC, animated: true)
        case "에티켓숲 이용규칙":
            let ruleListVC = CommunityRuleViewController()
            self.navigationController?.pushViewController(ruleListVC, animated: true)
        case "화면설정":
            let displayVC = DisplayViewController()
            self.navigationController?.pushViewController(displayVC, animated: true)
        case "앱 정보":
            let appInfoVC = AppInfoViewController()
            self.navigationController?.pushViewController(appInfoVC, animated: true)
        case "비밀번호 변경":
            let passwordEditVC = PasswordEditViewController()
            self.navigationController?.pushViewController(passwordEditVC, animated: true)
        case "로그아웃":
            showAlertTwoButton(title: "로그아웃", message: "정말 로그아웃하시겠습니까?", button1Title: "확인", button2Title: "취소") {
                do {
                    try Auth.auth().signOut()
                    let loginViewController = LoginViewController()
                    self.transitionToRootView(view: UINavigationController(rootViewController: loginViewController))
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
            }
        case "회원탈퇴":
            let userAccountDeletionVC = UserAccountDeletionViewController()
            self.navigationController?.pushViewController(userAccountDeletionVC, animated: true)
        default:
            break
        }
    }

    
}



// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = cellData[indexPath.section][indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        let chevronImageView = UIImageView()
        chevronImageView.image = UIImage(systemName: "chevron.forward")
        chevronImageView.tintColor = .gray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(chevronImageView)
        
        chevronImageView.snp.makeConstraints { make in
            make.width.equalTo(14)
            make.height.equalTo(22)
            make.centerY.equalTo(cell.contentView)
            make.trailing.equalTo(cell.contentView).offset(-24)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    //        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //            let numberOfCells = tableView.numberOfRows(inSection: indexPath.section)
    //            return tableView.bounds.height / CGFloat(numberOfCells)
    //        }
    
    
}


// MARK: - PHPickerViewControllerDelegate
extension ProfileViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let selectedImage = results.first?.itemProvider, selectedImage.canLoadObject(ofClass: UIImage.self) else {
            return
        }
        selectedImage.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let self = self, let image = image as? UIImage, error == nil else { return }
            userManager.uploadImage(image)
            self.updateProfileImage(image)
            let alertController = UIAlertController(title: "프로필 사진을 변경중입니다", message: "", preferredStyle: .alert)
            present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                alertController.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func updateProfileImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.profileView.circularImageView.image = image
        }
    }
    
}


