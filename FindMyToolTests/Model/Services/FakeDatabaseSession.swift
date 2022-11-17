//
//  FakeDatabaseSession.swift
//  FindMyToolTests
//
//  Created by Nicolas Demange on 04/11/2022.
//

import Foundation
import Firebase
@testable import FindMyTool

final class FakeDatabaseSession: APISession {

    enum DatabaseAction {
        case saved, notSaved
        case fetched, notFetched
        case display, notDisplay
        case finded, notFinded
        case deleted, notDeleted
        case imageUploaded, imageNotUploaded
        case logOut, notLogOut
        case connected, isNotConnected
        case getDocument, notGetDocument
        case getEmail, notGetEmail
    }
    
    // MARK: - Properties
    
    let result: Result<Void, Error>
    var databaseActions: [DatabaseAction] = []
    
    // MARK: - Initializer
    
    init(result: Result<Void, Error>) {
        self.result = result
    }
    
    // MARK: - Methods
    
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, completion: ((Error?) -> Void)?) {
        switch result {
        case .success:
            databaseActions.append(.saved)
            completion?(nil)
        case let .failure(error):
            databaseActions.append(.notSaved)
            completion?((error))
        }
    }
    
    func fetchTools(render: String, callback: @escaping ([FindMyTool.ToolData]) -> Void) {
        switch result {
        case .success:
            databaseActions.append(.fetched)
            callback([.init(docId: "hfjkahfjsfsak", name: "Motoculteur", postalCode: "74160", price: "25", lender: "", town: "Archamps")])
        case .failure:
            databaseActions.append(.notFetched)
            callback([])
        }
    }
    
    func displayUsername(callback: @escaping (String) -> Void) {
        switch result {
        case .success:
            databaseActions.append(.display)
            callback("Paul")
        case .failure:
            databaseActions.append(.notDisplay)
            callback("")
        }
    }
    
    func findToolsFromDB(nameTool: String, toolCP: String, callback: @escaping ([FindMyTool.ToolData]) -> Void) {
        switch result {
        case .success:
            databaseActions.append(.finded)
            callback([.init(docId: "ffsdfsgsd45", name: "Motoculteur", postalCode: "74160", price: "25", lender: "", town: "Archamps")])
        case .failure(_):
            callback([])
        }
    }

    func deleteToolFromDB(id: String) {
        switch result {
        case .success:
            databaseActions.append(.deleted)
        case .failure(_):
            databaseActions.append(.notDeleted)
        }
    }
    
    func uploadImageToStorage(imageLocalUrl: URL, completion: @escaping () -> Void) {
        switch result {
        case .success(()):
            databaseActions.append(.imageUploaded)
        case .failure(_):
            databaseActions.append(.imageNotUploaded)
        }
    }
    
    func logOut() {
        switch result {
        case .success(()):
            databaseActions.append(.logOut)
        case .failure:
            databaseActions.append(.notLogOut)
        }
    }
    
    func isUserConnected() -> Bool {
        switch result {
        case .success(()):
            databaseActions.append(.connected)
            return true
        case .failure:
            databaseActions.append(.isNotConnected)
            return false
        }
    }
    
    func getDocumentID() {
        switch result {
        case .success(()):
            databaseActions.append(.getDocument)
        case .failure:
            databaseActions.append(.notGetDocument)
        }
    }
    
    func getUserId(callback: @escaping (String) -> Void) {
        switch result {
        case .success(()):
            databaseActions.append(.getDocument)
            callback("userID")
        case .failure:
            databaseActions.append(.notGetDocument)
        }
    }
    
    func fetchUserID() -> String {
        switch result {
        case .success(()):
            databaseActions.append(.fetched)
            return "userID"
        case .failure:
            databaseActions.append(.notFetched)
            return ""
        }
    }
    
    func getUserEmail(callback: @escaping (String) -> Void) {
        switch result {
        case .success(()):
            databaseActions.append(.getEmail)
            callback("nicolas.demange@yahoo.fr")
        case .failure:
            databaseActions.append(.notGetEmail)
            callback("")
        }
    }
    
    func fetchUserEmail() -> String {
        switch result {
        case .success(()):
            databaseActions.append(.fetched)
            return "nicolas.demange@yahoo.fr"
        case .failure:
            databaseActions.append(.notFetched)
            return ""
        }
    }
    
}
