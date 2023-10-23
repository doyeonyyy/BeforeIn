


import UIKit
import SnapKit


//더미 데이터
let user1 = User(email: "", name: "", nickname: "lcho3878", profileImage: UIImage(systemName: "person")!, level: 1, phone: "")
let user2 = User(email: "", name: "", nickname: "cksgh0910", profileImage: UIImage(systemName: "person")!, level: 1, phone: "")

class CommunityViewController: UIViewController {
    
    let communityMainView = CommunityView()
    
    
    //더미 데이터
    let tags = ["전체보기", "요즘 문화", "우리끼리", "기타"]
    let posts: [Post] = [
    ]
    
    override func loadView() {
        view = communityMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityMainView.tagCollectionView.dataSource = self
        communityMainView.tagCollectionView.delegate = self
        communityMainView.tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        communityMainView.postTableView.dataSource = self
        communityMainView.postTableView.delegate = self
        communityMainView.postTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        communityMainView.plusButton.addTarget(self, action: #selector(plusButtonClick), for: .touchUpInside)
    }
    
    @objc func plusButtonClick() {
        let writeVC = WriteViewController()
        self.navigationController?.pushViewController(writeVC, animated: true)
    }
}

extension CommunityViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        cell.tagLabel.text = tags[indexPath.row]
        return cell
    }
    
    //태그 선택 로직
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        print("\(tag) 선택됨")
    }
    
}

extension CommunityViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configureUI(post)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let communityPageVC = CommunityPageViewController()
        self.navigationController?.pushViewController(communityPageVC, animated: true)
    }
    
}

