


import UIKit
import SnapKit
import FirebaseFirestore


//더미 데이터
let user1 = User(email: "", name: "", nickname: "lcho3878", profileImage: "", level: 1, phone: "")
let user2 = User(email: "", name: "", nickname: "cksgh0910", profileImage: "", level: 1, phone: "")

class CommunityViewController: UIViewController {
    
    let communityMainView = CommunityView()
    var postTableView: UITableView!
//    var blockList: [String] = [] {
//        didSet {
//            blockedEmails = blockList
//        }
//    }
//    
    //더미 데이터
    let tags = ["전체보기", "일상잡담", "요즘문화", "궁금해요", "기타"]
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
                var blockedEmails = currentUser.blockList
                var filteredPosts: [Post] = [] // 블록되지 않은 게시물을 저장할 배열
                
                for change in snapshot!.documentChanges {
                    if change.type == .added {
                        let data = change.document.data()
                        let writerEmail = data["writer"] as? String
                        
                        // 작성자의 이메일이 차단 목록에 있다면 이 게시물은 무시
                        if let writerEmail = writerEmail, blockedEmails.contains(writerEmail) {
                            continue
                        }
            
                        let writer = data["writer"] as! String
                        let category = data["category"] as! String
                        let content = data["content"] as! String
                        let likes = data["likes"] as! Int
                        let postingTime = data["postingTime"] as! Timestamp
                        let postingID = data["postingID"] as! String
                        let title = data["title"] as! String
                        let writerNickName = data["writerNickName"] as! String
                        var comments: [Comment] = []
                        
                        if let commentsData = data["comments"] as? [[String: Any]] {
                            for comment in commentsData {
                                if let commentWriter = comment["writer"] as? String,
                                   let commentPostingTime = comment["postingTime"] as? Timestamp,
                                   var commentContent = comment["content"] as? String,
                                   let commentWriterNickName = comment["writerNickName"] as? String {
                                    let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue(), reportUserList: [])
                                    comments.append(newComment)
                                }
                            }
                        }
                        
                        let addPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue(), reportUserList: [])
                        filteredPosts.insert(addPost,at: 0)
                        self.postTableView.reloadData()
                    } else if change.type == .removed {
                        // 삭제된 게시물을 처리
                        let removedPostID = change.document.documentID
                        filteredPosts = filteredPosts.filter { $0.postID != removedPostID }
                    } else {
                        let data = change.document.data()
                        let writerEmail = data["writer"] as? String
                        
                        // 작성자의 이메일이 차단 목록에 있다면 이 게시물은 무시
                        if let writerEmail = writerEmail, blockedEmails.contains(writerEmail) {
                            continue
                        }
                        
                        // 나머지 코드는 작성자가 차단되지 않은 경우에만 실행
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
                                   let commentWriterNickName = comment["writerNickName"] as? String {
                                    let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue(), reportUserList: [])
                                    comments.append(newComment)
                                }
                            }
                        }
                        
                        var reportUserList: [String] = []
                        
                        if let reportedData = data["reportUserList"] as? [String: String] {
                            for (_, email) in reportedData {
                                reportUserList.append(email)
                            }
                        }
                        
                        var title = data["title"] as! String
                        var content = data["content"] as! String
                        
                        if reportUserList.count >= 1 {
                            title = "신고당한 글이라 삭제됨"
                            content = "신고당한 글이라 삭제됨"
                        }
                        
                        let modifyPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue(), reportUserList: reportUserList)
                        
                        if let index = filteredPosts.firstIndex(where: { $0.postID == change.document.documentID }) {
                            filteredPosts[index] = modifyPost
                        }
                    }
                }
                self.posts = filteredPosts
                self.postTableView.reloadData()
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

