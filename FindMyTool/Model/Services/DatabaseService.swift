//
//  AuthFirebase.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation

import FirebaseCore
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class DatabaseService {
    
    // MARK: - Properties
    
    let db = Firestore.firestore()
    var town: String = ""
    var imageURL: String?
    var imageName: String?

    
    // MARK: - Methodes
    
    // Username Manager
    
    func displayUsername(callback: @escaping (String) -> Void) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            callback(username)
        }
    }
    
    // Tool Manager
    
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, completion: ((Error?) -> Void)? ) {
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
    
    func fetchTools(render: String, callback: @escaping ([ToolData]) -> Void) {
        
        var tools = [ToolData]()
        db.collection("tools").whereField("render", isEqualTo: render).getDocuments(completion: { (querySnapshot, err) in
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
                                        town: dict["town"] as! String)
                    tools.append(tool)
                }
                callback(tools)
            }
        })
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
    
    // Image Manager
    
    func deleteImageFromDB(toolImage: String) {
        let storeRef = Storage.storage()
        let imageRef = storeRef.reference().child(toolImage)
        
        imageRef.delete { error in
            if let error = error {
                print("Oups \(error.localizedDescription)")
            } else {
                print("Image deleted !")
            }
        }
    }
    
    func uploadImageToStorage(imageLocalUrl: URL, completion: @escaping () -> Void ) {
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

}
    
