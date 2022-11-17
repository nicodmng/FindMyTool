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
        URLProtocolFake.fakeURLs = [FakeResponseDataPostalCode.url: (nil, nil, FakeResponseDataPostalCode.error)]
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
        URLProtocolFake.fakeURLs = [FakeResponseDataPostalCode.url: (FakeResponseDataPostalCode.exchangeCorrectData, FakeResponseDataPostalCode.responseKO, nil)]
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
        URLProtocolFake.fakeURLs = [FakeResponseDataPostalCode.url: (FakeResponseDataPostalCode.postalCodeIncorrectData, FakeResponseDataPostalCode.responseOK, nil)]
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
        URLProtocolFake.fakeURLs = [FakeResponseDataPostalCode.url: (FakeResponseDataPostalCode.exchangeCorrectData, FakeResponseDataPostalCode.responseOK, nil)]
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

