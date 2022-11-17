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
    
    let session: APISession
    var imageURL: String?
    
    // MARK: - Initializer
    
    init(session: APISession = DatabaseSession()) {
        self.session = session
    }
    
    // MARK: - Methodes
    // Tool Manager
    
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, completion: ((Error?) -> Void)? ) {
        session.addToolInDatabase(name: name, localisation: localisation, description: description, price: price, town: town, imageLink: imageLink, imagePath: imagePath, render: render, lender: lender, isAvailable: isAvailable, completion: completion)
    }
    
    func fetchTools(render: String, callback: @escaping ([ToolData]) -> Void) {
        session.fetchTools(render: render, callback: callback)
    }
    
    func findToolsFromDB(nameTool: String, toolCP: String, callback: @escaping ([ToolData]) -> Void) {
        session.findToolsFromDB(nameTool: nameTool, toolCP: toolCP, callback: callback)
    }
    
    func deleteToolFromDB(id: String) {
        session.deleteToolFromDB(id: id)
    }
    
    // Image Manager
    
    func uploadImageToStorage(imageLocalUrl: URL, completion: @escaping () -> Void ) {
        session.uploadImageToStorage(imageLocalUrl: imageLocalUrl, completion: completion)
    }
    
    // Authentification
    
    func displayUsername(callback: @escaping (String) -> Void) {
        session.displayUsername(callback: callback)
    }
    
    func logOut() {
        session.logOut()
    }
    
    func isUserConnected() -> Bool {
        session.isUserConnected()
    }
    
    func getDocumentID() {
        session.getDocumentID()
    }
    
    func getUserId(callback: @escaping (String) -> Void) {
        session.getUserId(callback: callback)
    }
    
    @discardableResult func fetchUserID() -> String {
        session.fetchUserID()
    }
    
    func getUserEmail(callback: @escaping (String) -> Void) {
        session.getUserEmail(callback: callback)
    }
    
    func fetchUserEmail() -> String {
        session.fetchUserEmail()
    }
}

//    func deleteImageFromDB(toolImage: String) {
//        let storeRef = Storage.storage()
//        let imageRef = storeRef.reference().child(toolImage)
//
//        imageRef.delete { error in
//            if let error = error {
//                print("Oups \(error.localizedDescription)")
//            } else {
//                print("Image deleted !")
//            }
//        }
//    }
