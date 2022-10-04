//
//  PostalCodeTestCase.swift
//  FindMyToolTests
//
//  Created by Nicolas Demange on 04/10/2022.
//

import XCTest
@testable import FindMyTool

final class PostalCodeTestCase: XCTestCase {

    // MARK: - Let
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    // MARK: - Tests
    func testsGetPostalCode_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (nil, nil, FakeResponseDataExchange.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CPService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getLocation(postalCode: "74160") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetPostalCode_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (FakeResponseDataExchange.exchangeCorrectData, FakeResponseDataExchange.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CPService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getLocation(postalCode: "74160") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetPostalCode_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (FakeResponseDataExchange.exchangeIncorrectData, FakeResponseDataExchange.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CPService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getLocation(postalCode: "74160") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testsGetExchange_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldACorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (FakeResponseDataExchange.exchangeCorrectData, FakeResponseDataExchange.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CPService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getLocation(postalCode: "74160") { result in
            guard case .success(let cp) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(cp[0].codePostal == "74160" )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}

