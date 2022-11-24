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
    
    // Retrieves tool items from database
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
                                        town: dict["town"] as! String,
                                        email: dict["email"] as? String)
                    tools.append(tool)
                }
                callback(tools)
            }
        })
    }
    
    // Retrieves favorite tool items from database
    func fetchFavoriteTool(render: String, callback: @escaping ([FavoriteToolData]) -> Void) {
        db.collection("favorites").whereField("render", isEqualTo: render).getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var favoritesTools = [FavoriteToolData]()
                for document in querySnapshot!.documents {
                    let dict = document.data()
                    let favoriteTool = FavoriteToolData(description: dict["description"] as? String,
                                                docId: document.documentID,
                                                name: dict["name"] as! String,
                                                localisation: dict["localisation"] as! String,
                                                price: dict["price"] as! String,
                                                imageLink: dict["imageLink"] as? String,
                                                town: dict["town"] as! String,
                                                render: dict["render"] as! String,
                                                toolId: dict["toolId"] as? String,
                                                email: dict["email"] as? String)
                    favoritesTools.append(favoriteTool)
                }
                callback(favoritesTools)
            }
        })
    }
    
    // Adds tool items to database
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, email: String, completion: ((Error?) -> Void)?) {
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
            "isAvailable": isAvailable,
            "email": email,
        ]) { error in
            completion?(error)
        }
    }
    
    // Adds favorite tool items to database
    func addToolInFavorite(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, render: String, toolId: String, email: String, callback: @escaping (Error?) -> Void) {
        db.collection("favorites").addDocument(data:[
            "name": name,
            "localisation": localisation,
            "description": description,
            "price": price,
            "town": town,
            "imageLink": imageLink,
            "render": render,
            "toolId": toolId,
            "email": email],
            completion: callback)
    }
    
    // Catch boolean if tool is already in favorites in Firebase
    func isFavoriteTool(toolId: String, callback: @escaping (Bool) -> Void) {
        db.collection("favorites").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                callback(false)
                return
            }
            
            let isFavorite = documents.contains(where: { document in
                let ref = document.data()["toolId"] as? String
                return ref == toolId
            })
            callback(isFavorite)
        }
    }
    
    // Remove favorite tool from "favorites" collection in Firebase
    func deleteFavoriteTool(docID: String, callback: @escaping (Bool) -> Void) {
        db.collection("favorites").getDocuments { qs, error in
            let favoritesIdToDelete = qs?.documents.map({ doc in
                self.db.collection("favorites").document(docID).delete() { error in
                    if error == nil {
                        callback(true)
                    } else {
                        callback(false)
                    }
                }
            })
        }
    }
    
    // Remove tool from "tools" collection in Firebase
    func deleteToolFromDB(id: String) {
        db.collection("tools").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err) ")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // Catch a tool with a filter function from Firebase
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
                                            docId: document.documentID,
                                            name: dict["name"] as! String,
                                            postalCode: dict["localisation"] as! String,
                                            price: dict["price"] as! String,
                                            lender: dict["lender"] as! String,
                                            imageLink: dict["imageLink"] as? String,
                                            town: dict["town"] as! String,
                                            toolId: document.documentID)
                        tools.append(tool)
                    }
                    callback(tools)
                }
            }
    }
    
    // Create a path in FirebaseStorage and download the URL image
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
                completion()
            }
        }
    }
    
    // Retrieve tool's identification
    func getToolId(callback: @escaping (String) -> Void) {
        let toolId = db.collection("tools").document().documentID
        callback(toolId)
    }
    
    // Retrieve username of the user
    func displayUsername(callback: @escaping (String) -> Void) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            callback(username)
        }
    }
    
    // Disconnect the user out of the application
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            //print("Impossible de se déconnecter")
        }
    }
    
    // Catch a boolean if the user is connected
    func isUserConnected() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    // Retrieve the document ID
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
    
    // Retrieve the favorite document ID
    func getFavoriteDocumentID() -> String {
        var id = ""
        let ref = Firestore.firestore().collection("favorites")
        ref.getDocuments { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    id = document.documentID
                }
            }
        }
        return id
    }
    
    // Retrieves the logged in user's email
    func getEmailFromRender(callback: @escaping (String) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email ?? ""
            callback(email)
        }
    }
    
    // Retrieves email and username
    func getUsername(callback: @escaping (String) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email ?? ""
            let username = user.displayName ?? ""
            callback(username)
        }
    }
    
    // Retrieves username for display
    func fetchUsername() -> String {
        var user = ""
        getUsername { username in
            user = username
        }
        return user
    }
    
    // Retrieves user ID
    func getUserId(callback: @escaping (String) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            callback(uid)
        }
    }
    
    // Retrieves user ID for display
    func fetchUserID() -> String {
        var userID = ""
        getUserId { uid in
            userID = uid
        }
        return userID
    }
    
    // Retrieves user's email
    func getUserEmail(callback: @escaping (String) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            guard let email = user.email else { return }
            callback(email)
        }
    }
    
    // Retrieves user's email for display
    func fetchUserEmail() -> String {
        var userMail = ""
        getUserEmail { mail in
            userMail = mail
        }
        return userMail
    }
}
