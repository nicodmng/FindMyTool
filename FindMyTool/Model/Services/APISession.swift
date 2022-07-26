//
//  APISession.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 04/11/2022.
//

import Foundation
import FirebaseCore
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

protocol APISession {
    
    // Functions related with Tools
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, email: String, completion: ((Error?) -> Void)? )
    
    func addToolInFavorite(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, render: String, toolId: String, email: String, callback: @escaping (Error?) -> Void)
    
    func fetchFavoriteTool(render: String, callback: @escaping ([FavoriteToolData]) -> Void)
    
    func deleteFavoriteTool(docID: String, callback: @escaping (Bool) -> Void)
    
    func fetchTools(render: String, callback: @escaping ([ToolData]) -> Void)
    
    func displayUsername(callback: @escaping (String) -> Void)

    func findToolsFromDB(nameTool: String, toolCP: String, callback: @escaping ([ToolData]) -> Void)
    
    func deleteToolFromDB(id: String)
    
    func isFavoriteTool(toolId: String, callback: @escaping (Bool) -> Void)
    
    // Functions related with image
    func uploadImageToStorage(imageLocalUrl: URL, completion: @escaping () -> Void )
    
    // Functions related with authentification
    func logOut()
    
    func isUserConnected() -> Bool
    
    func getDocumentID()
    
    func getUserId(callback: @escaping (String) -> Void)
    
    func fetchUserID() -> String
    
    func getUserEmail(callback: @escaping (String) -> Void)
    
    func fetchUserEmail() -> String 
}
