


import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseAuth


//더미 데이터
let user1 = User(email: "", name: "", nickname: "lcho3878", profileImage: "", level: 1, phone: "")
let user2 = User(email: "", name: "", nickname: "cksgh0910", profileImage: "", level: 1, phone: "")

class CommunityViewController: UIViewController {
    
    let communityMainView = CommunityView()
    var postTableView: UITableView!
    private var handle: AuthStateDidChangeListenerHandle?
    let userManager = UserManager()
  
    //더미 데이터
    let tags = ["전체보기", "일상잡담", "요즘문화", "궁금해요", "기타"]
    var posts: [Post] = []
    var count = 0
    
    override func loadView() {
        view = communityMainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetchPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityMainView.tagCollectionView.dataSource = self
        communityMainView.tagCollectionView.delegate = self
        communityMainView.tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        communityMainView.postTableView.dataSource = self
        communityMainView.postTableView.delegate = self
        communityMainView.postTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        postTableView = communityMainView.postTableView
        communityMainView.plusButton.addTarget(self, action: #selector(plusButtonClick), for: .touchUpInside)
        fetchPosts()
    }
    
    @objc func plusButtonClick() {
        let writeVC = WriteViewController()
        self.navigationController?.pushViewController(writeVC, animated: true)
    }
    
    func observeBlockListChanges() {
        print(#function)
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user, let email = user.email {
                self.userManager.findUser(email: email) { findUser in
                    if let user = findUser {
                        currentUser = user
                        self.postTableView.reloadData()
                    }
                }
            }
        }
    }
    

}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
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
    
    
    func fetchPosts() {
        print(#function)
        let db = Firestore.firestore()
        let listener = db.collection("Post").addSnapshotListener { (snapshot, error) in
            if error == nil && snapshot != nil {
                var blockedEmails = currentUser.blockList
                // 변화가 있는것만 가져올 수 있다.
                for change in snapshot!.documentChanges {
                    // change type remove, modified 일때도 로직 추가 예정
                    if change.type == .added {
                        let addDoc = db.collection("Post").document(change.document.documentID).getDocument { (snapshot, error) in
                            if error == nil && snapshot != nil && snapshot?.data() != nil {
                                let data = snapshot!.data()!
                                let category = data["category"] as! String
                                let content = data["content"] as! String
                                let likes = data["likes"] as! Int
                                let postingTime = data["postingTime"] as! Timestamp
                                let postingID = data["postingID"] as! String
                                var title = data["title"] as! String
                                let writer = data["writer"] as! String
                                let writerNickName = data["writerNickName"] as! String
                                if blockedEmails.contains(writer) {
                                                        return
                                                     }
                                
                                var comments: [Comment] = []
                                if let commentsData = data["comments"] as? [[String: Any]] {
                                    for comment in commentsData {
                                        if let commentWriter = comment["writer"] as? String,
                                           let commentPostingTime = comment["postingTime"] as? Timestamp,
                                           var commentContent = comment["content"] as? String,
                                           let commentWriterNickName = comment["writerNickName"] as? String{
                                            let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue(), reportUserList: [])
                                            comments.append(newComment)
                                        }
                                    }
                                }
                                var reportUserList: [String] = []
                                let reportedData = data["reportUserList"] as? [String]
                                if let reportedData = reportedData {
                                    for email in reportedData {
                                        reportUserList.append(email)
                                    }
                                }
                                if reportUserList.count >= 1 {
//                                    print("차단글 발견")
                                    title = "신고당한 글이라 삭제됨"
                                }
                                let addPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue(), reportUserList: reportUserList)
                                self.posts.append(addPost)
                            }
                            self.posts.sort{$0.postingTime > $1.postingTime}
                            self.postTableView.reloadData()
                            
                        }
                        
                        
                    }
                    else if change.type == .removed {
                        for i in 0..<self.posts.count {
                            if self.posts[i].postID == change.document.documentID {
                                self.posts.remove(at: i)
                                break
                            }
                        }
                        self.postTableView.reloadData()
                    }
                    else {
                        let modifyDoc = db.collection("Post").document(change.document.documentID).getDocument { (snapshot, error) in
                            if error == nil && snapshot != nil && snapshot?.data() != nil {
                                let data = snapshot!.data()!
                                let category = data["category"] as! String
                                let likes = data["likes"] as! Int
                                let postingTime = data["postingTime"] as! Timestamp
                                let postingID = data["postingID"] as! String
                                let writer = data["writer"] as! String
                                let writerNickName = data["writerNickName"] as! String
                                var comments: [Comment] = []
                                if let commentsData = data["comments"] as? [[String: Any]] {
                                    for comment in commentsData {
                                        if let commentWriter = comment["writer"] as? String,
                                           let commentPostingTime = comment["postingTime"] as? Timestamp,
                                           var commentContent = comment["content"] as? String,
                                           let commentWriterNickName = comment["writerNickName"] as? String{
                                            let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue(), reportUserList: [])
                                            comments.append(newComment)
                                        }
                                    }
                                }
                                var reportUserList: [String] = []
                                let reportedData = data["reportUserList"] as? [String]
                                if let reportedData = reportedData {
                                    for email in reportedData {
                                        reportUserList.append(email)
                                    }
                                }
                                var title = data["title"] as! String
                                var content = data["content"] as! String
                                if reportUserList.count >= 1 {
                                    title = "신고당한 글이라 삭제됨"
                                }
                                
                                let modifyPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue(), reportUserList: reportUserList)
                                for i in 0..<self.posts.count {
                                    if self.posts[i].postID == change.document.documentID {
                                        self.posts[i] = modifyPost
                                        break
                                    }
                                }
                                self.postTableView.reloadData()
                            }
                            
                        }
                    }
                }
            } else {
                // error. do something
            }
        }
    }
}



// MARK: - UITableViewDataSource, UITableViewDelegate
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let communityPageVC = CommunityPageViewController()
        communityPageVC.post = post
        self.navigationController?.pushViewController(communityPageVC, animated: true)
    }
    
}

