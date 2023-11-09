//
//  UserManager.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/18.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


struct UserManager {
    let db = Firestore.firestore()
    
    // 유저 생성
    func addUser(user: User) {
        db.collection("User").addDocument(data: [
            "email": user.email,
            "name": user.name,
            "nickname": user.nickname,
            "profileImage": user.profileImage,
            "level": user.level,
            "phone": user.phone,
            "blockList": user.blockList
        ])
    }
    
    // 유저 삭제
    func deleteUser(user: FirebaseAuth.User){
        if let email = user.email {
            db.collection("User").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
    }
    
    // 유저 찾기
    func findUser(email: String, completion: @escaping (User?) -> Void) {
        let userDB = db.collection("User")
        let query = userDB.whereField("email", isEqualTo: email)
        query.getDocuments { (snapShot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let qs = snapShot, !qs.documents.isEmpty {
                if let data = qs.documents.first?.data() {
                    let email = data["email"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let nickname = data["nickname"] as? String ?? ""
                    let profileImage = data["profileImage"] as? String ?? ""
                    let level = data["level"] as? Int ?? 0
                    let phone = data["phone"] as? String ?? ""
                    let blockList = data["blockList"] as? [String] ?? [String]()
                    let user = User(email: email, name: name, nickname: nickname, profileImage: profileImage, level: level, phone: phone, blockList: blockList)
                    completion(user)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // 닉네임 찾기
    func findNickname(nickname: String, completion: @escaping (User?) -> Void) {
        let userDB = db.collection("User")
        let query = userDB.whereField("nickname", isEqualTo: nickname)
        query.getDocuments { (snapShot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let qs = snapShot, !qs.documents.isEmpty {
                if let data = qs.documents.first?.data() {
                    let email = data["email"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let nickname = data["nickname"] as? String ?? ""
                    let profileImage = data["profileImage"] as? String ?? ""
                    let level = data["level"] as? Int ?? 0
                    let phone = data["phone"] as? String ?? ""
                    let user = User(email: email, name: name, nickname: nickname, profileImage: profileImage, level: level, phone: phone)
                    completion(user)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }

    // 이미지 업로드
    func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("이미지 데이터를 생성하는데 실패했습니다.")
            return
        }
        let storageRef = Storage.storage().reference().child("profileImages/\(currentUser.email).jpg")
        
        let metadata = StorageMetadata()
        StorageMetadata().contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Storage 업로드 오류: \(error.localizedDescription)")
            } else {
                print("Storage 업로드 성공")
                
                storageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        let stringURL = downloadURL.absoluteString
                        currentUser.profileImage = stringURL
                        self.saveImageURL(imageURL: stringURL)
                        
                        ImageCacheManager.shared.setObject(image, forKey: "\(downloadURL)" as NSString)
                        if ImageCacheManager.shared.object(forKey: "\(downloadURL)" as NSString) != nil {
                            print("프로필 이미지 캐싱 성공")
                        } else {
                            print("프로필 이미지 캐싱 실패")
                        }
                    } else if let error = error {
                        print("다운로드 URL 가져오기 오류: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    // 이미지URL 저장
    func saveImageURL(imageURL: String) {
        if let userEmail = Auth.auth().currentUser?.email {
            let userCollection = Firestore.firestore().collection("User")
            userCollection.whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("에러: \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    let userDocument = documents[0]
                    userDocument.reference.updateData(["profileImage": imageURL]) { error in
                        if let error = error {
                            print("이미지 저장 실패: \(error.localizedDescription)")
                        } else {
                            print("이미지 저장 성공")
                            currentUser.profileImage = imageURL
                        }
                    }
                }
            }
        } else {
            print("사용자 이메일을 가져올 수 없음.")
        }
    }

    // 차단
    func addToBlockList(userEmail: String) {
        if let currentUserEmail = Auth.auth().currentUser?.email {
            let userCollection = Firestore.firestore().collection("User")
            userCollection.whereField("email", isEqualTo: currentUserEmail).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("에러: \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    let userDocument = documents[0]
                    var blockList = userDocument["blockList"] as? [String] ?? []
                    
                    // 이미 추가되어 있는지 확인
                    if !blockList.contains(userEmail) {
                        blockList.append(userEmail)
                        userDocument.reference.updateData(["blockList": blockList]) { error in
                            if let error = error {
                                print("blockList 추가 실패: \(error.localizedDescription)")
                            } else {
                                print("blockList 추가 성공")
                                currentUser.blockList = blockList
                            }
                        }
                    } else {
                        print("이미 차단됨")
                    }
                }
            }
        } else {
            print("사용자 이메일을 가져올 수 없음.")
        }
    }

    // 차단해제
    func removeFromBlockList(userEmail: String, completion: @escaping (Bool) -> Void) {
        if let currentUserEmail = Auth.auth().currentUser?.email {
            let userCollection = Firestore.firestore().collection("User")
            userCollection.whereField("email", isEqualTo: currentUserEmail).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("에러: \(error.localizedDescription)")
                    completion(false) 
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    let userDocument = documents[0]
                    var blockList = userDocument["blockList"] as? [String] ?? []

                    if let index = blockList.firstIndex(of: userEmail) {
                        blockList.remove(at: index)
                        userDocument.reference.updateData(["blockList": blockList]) { error in
                            if let error = error {
                                print("차단 해제 실패: \(error.localizedDescription)")
                                completion(false)
                            } else {
                                print("차단 해제 성공")
                                currentUser.blockList = blockList
                                completion(true)
                            }
                        }
                    } else {
                        print("차단 목록에서 사용자를 찾을 수 없음")
                        completion(false)
                    }
                }
            }
        } else {
            print("사용자 이메일을 가져올 수 없음.")
            completion(false)
        }
    }

    
    
}
