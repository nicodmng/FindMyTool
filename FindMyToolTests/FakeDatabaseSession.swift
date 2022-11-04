//
//  FakeDatabaseSession.swift
//  FindMyToolTests
//
//  Created by Nicolas Demange on 04/11/2022.
//

import Foundation
import Firebase
@testable import FindMyTool

struct FakeDB {
    var name: String?
    var price: String?
}

final class FakeDatabaseSession: FirebaseSession {

    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    
    // MARK: - Methods
    
    func addToolInDatabase(name: String, localisation: String, description: String, price: String, town: String, imageLink: String, imagePath: String, render: String, lender: String?, isAvailable: Bool, completion: ((Error?) -> Void)?) {
        <#code#>
    }
}
