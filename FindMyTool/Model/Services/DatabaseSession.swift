//
//  DatabaseSession.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 10/11/2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

final class DatabaseSession: APISession {

    

    
    // MARK: - Properties
    var db = Firestore.firestore()
    var town: String = ""
    var imageURL: String?
    
    // MARK: - Functions
    
    func fetchTools(render: String, callback: @escaping ([ToolData]) -> Void) {
        db.collection("tools").whereField("render", isEqualTo: render).getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var tools = [ToolData]()
                for document in querySnapshot!.documents {
                    let dict = document.data()
                    let tool = ToolData(description: dict["description"] as? String,
                                        docId: document.documentID,
                                        name: dict["name"] as! String,
                                        postalCode: dict["localisation"] as! String,
                                        price: dict["price"] as! String,
                                        lender: dict["lender"] as! String,
                                        imageLink: dict["imageLink"] as? String,
                                        town: dict["town"] as! String)
                    tools.append(tool)
                }
                callback(tools)
            }
        })
    }
    
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, completion: ((Error?) -> Void)?) {
        db.collection("tools").addDocument(data: [
            "name": name,
            "localisation": localisation,
            "description": description,
            "price": price,
            "town": town,
            "imageLink": imageLink,
            "imagePath": imagePath,
            "render": render,
            "lender": lender as Any,
            "isAvailable": isAvailable
        ]) { error in
            completion?(error)
        }
    }
    
    func findToolsFromDB(nameTool: String, toolCP: String, callback: @escaping ([ToolData]) -> Void) {
        var tools = [ToolData]()
        
        db.collection("tools").whereField("town", isEqualTo: self.town).whereField("name", isEqualTo: nameTool)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let dict = document.data()
                        let tool = ToolData(description: dict["description"] as? String,
                                            docId: document.documentID, name: dict["name"] as! String,
                                            postalCode: dict["localisation"] as! String,
                                            price: dict["price"] as! String,
                                            lender: dict["lender"] as! String,
                                            imageLink: dict["imageLink"] as? String,
                                            town: dict["town"] as! String)
                        tools.append(tool)
                    }
                    callback(tools)
                }
            }
    }
    
    func deleteToolFromDB(id: String) {
        db.collection("tools").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err) ")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func uploadImageToStorage(imageLocalUrl: URL, completion: @escaping () -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let path = "images/\(UUID().uuidString)"
        let imageRef = storageRef.child(path)
        
        imageRef.putFile(from: imageLocalUrl, metadata: nil) { metadata, error in
            guard metadata != nil else {
                completion()
                return
            }
            
            imageRef.downloadURL { url, error in
                guard url != nil else {return}
                let urlString: String = url?.absoluteString ?? "no url"
                self.imageURL = urlString
                print(self.imageURL ?? "")
                completion()
            }
        }
    }
    
    // Authentification
    
    func displayUsername(callback: @escaping (String) -> Void) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            callback(username)
        }
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            //print("Impossible de se déconnecter")
        }
    }
    
    func isUserConnected() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func getDocumentID() {
        let ref = Firestore.firestore().collection("tools")
        ref.getDocuments { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    _ = document.documentID
                }
            }
        }
    }
    
    func getUserId(callback: @escaping (String) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            callback(uid)
        }
    }
    
    func fetchUserID() -> String {
        var userID = ""
        getUserId { uid in
            userID = uid
        }
        return userID
    }
    
    func getUserEmail(callback: @escaping (String) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            guard let email = user.email else { return }
            callback(email)
            print(email)
        }
    }
    
    func fetchUserEmail() -> String {
        var userMail = ""
        getUserEmail { mail in
            userMail = mail
        }
        return userMail
    }
}
