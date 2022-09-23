//
//  AuthFirebase.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 18/08/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class DatabaseService {
    // MARK: - Properties
    
    let db = Firestore.firestore()
    var toolId: Tool?
    
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
    
    func fetchTools(render: String, callback: @escaping ([Tool]) -> Void) {
        var tools = [Tool]()
        db.collection("tools").whereField("render", isEqualTo: render).getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dict = document.data()
                    let tool = Tool(name: dict["name"] as! String, localisation: dict["localisation"] as! String, price: dict["price"] as! String, town: dict["town"] as! String, lender: dict["lender"] as! String)
                    tools.append(tool)
                }
                callback(tools)
            }
        })
    }
    
    func addToolInDatabase(name: String, localisation: String, price: String, town: String, render: String, lender: String?, isAvailable: Bool) {
        db.collection("tools").addDocument(data: [
            "name": name,
            "localisation": localisation,
            "price": price,
            "town": town,
            "render": render,
            "lender": lender as Any,
            "isAvailable": isAvailable
        ])
    }
    
    func deleteToolFromDB() {
        db.collection("tools").document().delete() { err in
            if let err = err {
                print("Error removing document: \(err) ")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
