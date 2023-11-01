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
            "phone": user.phone
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
//        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
//        let path = "ProfileImages/\(imageName)"
       // let storageRef = Storage.storage().reference().child(path)
        let userId = currentUser.email
        let storageRef = Storage.storage().reference().child("profileImages/\(userId).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Storage 업로드 오류: \(error.localizedDescription)")
            } else {
                print("Storage 업로드 성공")
                
                storageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        self.saveImageURL(imageURL: downloadURL.absoluteString)
                        print("이미지 다운로드 URL 가져오기 성공")
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
    
    // 이미지파싱
    func parseImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // 네트워크 오류 발생
                print("네트워크 오류: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("이미지 다운로드 또는 파싱 오류")
                completion(nil)
            }
        }.resume()
    }
}
