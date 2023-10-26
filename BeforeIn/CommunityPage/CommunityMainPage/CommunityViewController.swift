


import UIKit
import SnapKit
import FirebaseFirestore


//더미 데이터
let user1 = User(email: "", name: "", nickname: "lcho3878", profileImage: "", level: 1, phone: "")
let user2 = User(email: "", name: "", nickname: "cksgh0910", profileImage: "", level: 1, phone: "")

class CommunityViewController: UIViewController {
    
    let communityMainView = CommunityView()
    var postTableView: UITableView!
    
    //더미 데이터
    let tags = ["전체보기", "요즘 문화", "우리끼리", "기타"]
    var posts: [Post] = []
//    var posts: [String] = []
    var count = 0
    
    override func loadView() {
        view = communityMainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        postTableView.reloadData()
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
    
    func fetchPosts() {
        let db = Firestore.firestore()
        let listener = db.collection("Post").addSnapshotListener { (snapshot, error) in
            if error == nil && snapshot != nil {
                
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
                                let title = data["title"] as! String
                                let writer = data["writer"] as! String
                                let writerNickName = data["writerNickName"] as! String
                                var comments: [Comment] = []
                                let commentsData = data["comments"] as? [[String: Any]]
                                for comment in commentsData! {
                                    if let commentWriter = comment["writer"] as? String,
                                       let commentPostingTime = comment["postingTime"] as? Timestamp,
                                       let commentContent = comment["content"] as? String,
                                       let commentWriterNickName = comment["writerNickName"] as? String{
                                        let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue())
                                        comments.append(newComment)
                                    }
                                       
                                }
                                let addPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue())
                                self.posts.insert(addPost, at: 0)
                                self.postTableView.reloadData()
                            }
                            
                        }
                        
                        
                    }
                    else if change.type == .removed {
                        for i in 0..<self.posts.count {
                            if self.posts[i].postID == change.document.documentID {
                                self.posts.remove(at: i)
                                break
                            }
                        }
                    }
                    else {
                        let modifyDoc = db.collection("Post").document(change.document.documentID).getDocument { (snapshot, error) in
                            if error == nil && snapshot != nil && snapshot?.data() != nil {
                                let data = snapshot!.data()!
                                let category = data["category"] as! String
                                let content = data["content"] as! String
                                let likes = data["likes"] as! Int
                                let postingTime = data["postingTime"] as! Timestamp
                                let postingID = data["postingID"] as! String
                                let title = data["title"] as! String
                                let writer = data["writer"] as! String
                                let writerNickName = data["writerNickName"] as! String
                                var comments: [Comment] = []
                                let commentsData = data["comments"] as? [[String: Any]]
                                for comment in commentsData! {
                                    if let commentWriter = comment["writer"] as? String,
                                       let commentPostingTime = comment["postingTime"] as? Timestamp,
                                       let commentContent = comment["content"] as? String,
                                       let commentWriterNickName = comment["writerNickName"] as? String{
                                        let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue())
                                        comments.append(newComment)
                                    }
                                       
                                }
                                let modifyPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue())
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
                    self.postTableView.reloadData()
                }
            } else {
                // error. do something
            }
        }
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
        let post = posts[indexPath.row]
        let communityPageVC = CommunityPageViewController()
        communityPageVC.post = post
        self.navigationController?.pushViewController(communityPageVC, animated: true)
    }
    
}

