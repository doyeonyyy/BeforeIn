



import UIKit
import FirebaseAuth
import SnapKit

class ProfileViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userManager = UserManager()
    let chanho = User(email: "leech3878@naver.com", name: "이찬호", nickname: "lcho3878", profileImage: UIImage(systemName: "person.fill")!, level: 5)
    let profileView = ProfileView()
    private let cellData: [String] = [
        "디스플레이",
        "정보",
        "로그아웃",
        "회원탈퇴"
    ]
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileViewModel = profileViewModel(user: chanho)
        profileView.profileViewModel = profileViewModel
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
        profileView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        profileView.tableView.separatorStyle = .none
        
//        configureUser()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let displayVC = DisplayViewController()
            present(displayVC, animated: true)
        }
        
        else if indexPath.row == 1 {
            let infoVC = InfoViewController()
            present(infoVC, animated: true)
        }
        
        else if indexPath.row == 2 {
            // 3. 로그아웃
            showAlertOneButton(title: "로그아웃", message: "정말 로그아웃하시겠습니까?", buttonTitle: "확인") {
                do {
                    try Auth.auth().signOut()
                    let loginViewController = LoginViewController()
                    self.transitionToRootView(view: UINavigationController(rootViewController: loginViewController))
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
            }
        } else if indexPath.row == 3 {
            // 4. 회원탈퇴
            showAlertOneButton(title: "회원탈퇴", message: "정말 탈퇴하시겠습니까?", buttonTitle: "확인") {
                if let user = Auth.auth().currentUser {
                    self.userManager.deleteUser(user: user)
                    user.delete { error in
                        if let error = error {
                            print("Firebase Error: \(error)")
                        } else {
                            print("회원탈퇴 성공")
                            let loginViewController = LoginViewController()
                            self.transitionToRootView(view: UINavigationController(rootViewController: loginViewController))
                        }
                    }
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = cellData[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(line)
        
        line.snp.makeConstraints { make in
            make.leading.equalTo(cell.contentView.snp.leading)
            make.trailing.equalTo(cell.contentView.snp.trailing)
            make.bottom.equalTo(cell.contentView.snp.bottom)
            make.height.equalTo(1)
        }
        
        
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
}
