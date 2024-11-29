//
//  AuthService.swift
//  JHApp
//
//  Created by Егорио on 26.11.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    public static let shared = AuthService()
    
    private init() {}
    
    public func registerUser(with userRequest: RegisterUserRequest, nickname: String , completion:
                             @escaping (Bool, Error?) -> Void) {
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "email": email,
                    "password": password,
                    "nickname": nickname
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
        
    }
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func forgotPassword (with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    public func fetchUserCompletion(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let snapshot = snapshot, let snapshotData = snapshot.data(),
                   let email = snapshotData["email"] as? String,
                   let nickname = snapshotData["nickname"] as? String {
                    let user = User(email: email, userUID: userUID, nickname: nickname)
                    completion(user, nil)
                } else {
                    completion(nil, NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                }
            }
    }
    
    public func updateNickname(to newNickname: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(userUID)
            .updateData([
                "nickname": newNickname
            ]) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                completion(true, nil)
            }
    }
    
}
