



import UIKit
import FirebaseAuth
import SnapKit

class ProfileViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userManager = UserManager()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "000님"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let mentLabel: UILabel = {
        let label = UILabel()
        label.text = "의 프로필 입니다"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let grayRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "000님은 현재"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "검은머리 짐승"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let level: UILabel = {
        let label = UILabel()
        label.text = "Lv l"
        label.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let mentBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "입니다"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let levelRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myLevelRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let cellData: [String] = [
        "디스플레이",
        "정보",
        "로그아웃",
        "회원탈퇴"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nicknameLabel)
        view.addSubview(mentLabel)
        view.addSubview(idLabel)
        view.addSubview(circularImageView)
        view.addSubview(shadowView)
        view.addSubview(grayRectangle)
        view.addSubview(nameBoxLabel)
        view.addSubview(levelLabel)
        view.addSubview(level)
        view.addSubview(mentBoxLabel)
        view.addSubview(levelRectangle)
        view.addSubview(myLevelRectangle)
        view.addSubview(line)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        defineLayoutConstraints()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 2 {
            // 로그아웃
            showAlertTwoButton(title: "로그아웃", message: "정말 로그아웃하시겠습니까?", button1Title: "확인", button2Title: "취소") {
                do {
                    try Auth.auth().signOut()
                    let loginViewController = LoginViewController()
                    self.transitionToRootView(view: UINavigationController(rootViewController: loginViewController))
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
            }
        } else if indexPath.row == 3 {
            // 회원탈퇴
            showAlertTwoButton(title: "회원탈퇴", message: "정말 탈퇴하시겠습니까?", button1Title: "확인", button2Title: "취소") {
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
    
    
    private func defineLayoutConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(90)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        mentLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(94)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(2)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        circularImageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.trailing.equalTo(view.snp.trailing).offset(-24)
            make.top.equalTo(view.snp.top).offset(86)
        }
        
        grayRectangle.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(200)
            make.top.equalTo(idLabel.snp.bottom).offset(32)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        nameBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(grayRectangle.snp.top).offset(16)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(8)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        level.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(8)
            make.trailing.equalTo(grayRectangle.snp.trailing).offset(-24)
        }
        
        mentBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(14)
            make.leading.equalTo(levelLabel.snp.trailing).offset(4)
        }
        
        levelRectangle.snp.makeConstraints { make in
            make.width.equalTo(313)
            make.height.equalTo(12)
            make.bottom.equalTo(grayRectangle.snp.bottom).offset(-16)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        myLevelRectangle.snp.makeConstraints { make in
            make.width.equalTo(62)
            make.height.equalTo(12)
            make.bottom.equalTo(grayRectangle.snp.bottom).offset(-16)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        line.snp.makeConstraints { make in
            make.width.equalTo(393)
            make.height.equalTo(4)
            make.top.equalTo(grayRectangle.snp.bottom).offset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        shadowView.addSubview(grayRectangle)
        grayRectangle.snp.makeConstraints { make in
            make.edges.equalTo(shadowView)
        }
    }
}
