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
                                imageRef: dict["imageRef"] as? String,
                                town: dict["town"] as! String)
                    tools.append(tool)
                }
                callback(tools)
            }
        })
    }
    
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageTool: String, render: String, lender: String?, isAvailable: Bool) {
        db.collection("tools").addDocument(data: [
            "name": name,
            "localisation": localisation,
            "description": description,
            "price": price,
            "town": town,
            "imageTool": imageTool,
            "render": render,
            "lender": lender as Any,
            "isAvailable": isAvailable
        ])
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
                        let tool = ToolData(description: dict["description"] as? String, docId: document.documentID, name: dict["name"] as! String, postalCode: dict["localisation"] as! String, price: dict["price"] as! String, lender: dict["lender"] as! String, town: dict["town"] as! String)
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
    
    func uploadImage(fileURL: URL) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let path = "images/\(UUID().uuidString).jpg"
        let imageRef = storageRef.child(path)
        imageRef.putFile(from: fileURL, metadata: nil) { metadata, error in
            guard metadata != nil else { return }
        }
    }
    
}
