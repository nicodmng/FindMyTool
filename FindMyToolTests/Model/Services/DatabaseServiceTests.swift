//
//  DatabaseServiceTests.swift
//  FindMyToolTests
//
//  Created by Nicolas Demange on 28/10/2022.
//

import XCTest
import Foundation
import Firebase
@testable import FindMyTool

class DatabaseServiceTests: XCTestCase {
    
    // MARK: - Properties
    let imageDB = URL(string: "https://image-tool.jpg")

    // MARK: - Test functions
    
    // Add Tools :
    func testAddTool_WhenToolIsSaved_ThenShouldAddToolInDatabase() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        
        sut.addToolInDatabase(name: "Tondeuse", localisation: "74160", description: "Très bon outil", price: "20", town: "Archamps", imageLink: "", imagePath: "", render: "jj", lender: "", isAvailable: true) { _ in
            print("")
        }
        
        XCTAssertEqual(session.databaseActions, [.saved])
    }
    
    func testAddTool_WhenToolIsNotSaved_ThenShouldNotAddToolInDatabase() {
        let session = FakeDatabaseSession(result: .failure(NSError()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.addToolInDatabase(name: "Tondeuse", localisation: "74160", description: "Très bon outil", price: "20", town: "Archamps", imageLink: "", imagePath: "", render: "jj", lender: "", isAvailable: true) { _ in
            XCTAssertEqual(session.databaseActions, [.notSaved])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    // Fetch Tools :
    func testFetchTools_WhenToolsAreFetched_ThenShouldFetchTools() throws {
        // Given
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        // When -> action
        sut.fetchTools(render: "") { arrToolData in
            XCTAssertEqual(session.databaseActions, [.fetched])
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchTools_WhenToolsAreNotFetched_ThenShouldNotFetchTools() {
        // Given
        let session = FakeDatabaseSession(result: .failure(NSError()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        // When -> action
        sut.fetchTools(render: "") { arrToolData in
            XCTAssertEqual(session.databaseActions, [.notFetched])
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDisplayUsername_WhenUsernameIsDisplay_ThenShouldDisplayUsername() {
        // Given
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        // When -> action
        sut.displayUsername { username in
            XCTAssertEqual(session.databaseActions, [.display])
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFindTools_WhenToolsAreFinded_ThenShouldFindTools() {
        // Given
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        // When -> action
        sut.findToolsFromDB(nameTool: "Motoculteur", toolCP: "74160") { toolData in
            XCTAssertEqual(session.databaseActions, [.finded])
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDeletedToolFromDB_WhenUserDeleteATool_ThenShouldDeleteToolFromDB() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.deleteToolFromDB(id: "aabbccdd123")
        XCTAssertEqual(session.databaseActions, [.deleted])
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testImageUploadedToStorage_WhenUserUploadAnImage_ThenShouldImageUploaded() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.uploadImageToStorage(imageLocalUrl: imageDB!) {
            XCTAssertEqual(session.databaseActions, [.imageUploaded])
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLogOut_WhenUserPressButtonDisconnect_ThenUserLogOut() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.logOut()
        XCTAssertEqual(session.databaseActions, [.logOut])
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLog_WhenUserConnect_ThenShouldUserConnected() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        _ = sut.isUserConnected()
        XCTAssertEqual(session.databaseActions, [.connected])
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetDocumentID_WhenUserAddTool_ThenShouldDocumentIDInDB() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.getDocumentID()
        XCTAssertEqual(session.databaseActions, [.getDocument])
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetUserID_WhenUserAddTool_ThenShouldPutIDInDB() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.getUserId { userID in
            XCTAssertEqual(session.databaseActions, [.getDocument])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testfetchUserID_WhenUserAddTool_ThenShouldInDB() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.fetchUserID()
        XCTAssertEqual(session.databaseActions, [.fetched])
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetEmail_WhenUserAddTool_ThenShouldEmailInDB() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        sut.getUserEmail { email in
            XCTAssertEqual(session.databaseActions, [.getEmail])
            expectation.fulfill()
            
            self.wait(for: [expectation], timeout: 0.1)
        }
    }
    
    func testFetchEmail_WhenUserAddTool_ThenShouldFetchEmail() {
        let session = FakeDatabaseSession(result: .success(()))
        let sut = DatabaseService(session: session)
        let expectation = expectation(description: "Waiting...")
        
        _ = sut.fetchUserEmail()
        XCTAssertEqual(session.databaseActions, [.fetched])
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 0.1)
    }
}




