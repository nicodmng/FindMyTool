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
//import FirebaseStorage

class DatabaseService {
    
    // MARK: - Properties
    
    let db = Firestore.firestore()
    var toolId: ToolData?
    var town: String = ""
    
    // MARK: - Methodes
    
    func displayUsername(callback: @escaping (String) -> Void) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            callback(username)
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
                    let tool = ToolData(docId: document.documentID, name: dict["name"] as! String, postalCode: dict["localisation"] as! String, price: dict["price"] as! String, town: dict["town"] as! String, lender: dict["lender"] as! String)
                    tools.append(tool)
                }
                callback(tools)
            }
        })
    }
    
    func addToolInDatabase(name: String, localisation: String, price: String, town: String, imageTool: String, render: String, lender: String?, isAvailable: Bool) {
        db.collection("tools").addDocument(data: [
            "name": name,
            "localisation": localisation,
            "price": price,
            "town": town,
            "imageTool": imageTool,
            "render": render,
            "lender": lender as Any,
            "isAvailable": isAvailable
        ])
    }
    
//    func addPhotoInDatabase(fileURL: URL) {
//        let storage = Storage.storage()
//        let data = Data()
//        let storageRef = storage.reference()
//        let localFile = fileURL
//        let photoRef = storageRef.child("images/file.png")
//        let uploadTask = photoRef.putFile(from: localFile, metadata: nil) { (medaData, error) in
//            guard medaData != nil else {
//                print(error?.localizedDescription)
//                
//                storageRef.child("images/file.png").downloadURL { url, error in
//                    guard let url = url, error == nil else {
//                        return
//                    }
//                    let urlString = url.absoluteString
//                    print("Download URL: \(urlString)")
//                }
//                return
//            }
//            print("Photo Uploaded !")
//        }
//    }
    
    func findToolsFromDB(nameTool: String, toolCP: String, callback: @escaping ([ToolData]) -> Void) {
        var tools = [ToolData]()
        db.collection("tools").whereField("town", isEqualTo: self.town).whereField("name", isEqualTo: nameTool)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let dict = document.data()
                        let tool = ToolData(docId: document.documentID, name: dict["name"] as! String, postalCode: dict["localisation"] as! String, price: dict["price"] as! String, town: dict["town"] as! String, lender: dict["lender"] as! String)
                        tools.append(tool)
                    }
                    callback(tools)
                }
            }
    }
    
    func deleteToolFromDB(id: String) {
        // TODO: trouver comment insérer ID Document dans document
        db.collection("tools").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err) ")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func getImageTool() {
        
    }
    
}
