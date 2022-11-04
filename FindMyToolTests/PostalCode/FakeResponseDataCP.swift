//
//  FakeResponseDataCP.swift
//  FindMyToolTests
//
//  Created by Nicolas Demange on 04/10/2022.
//

import Foundation

import Foundation

class FakeResponseDataPostalCode {
    static let url: URL = URL(string: "https://apicarto.ign.fr/api/codes-postaux/communes/74160")!

    static let responseOK = HTTPURLResponse(url: URL(string: "https://apicarto.ign.fr/api/codes-postaux/communes/74160")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    static let responseKO = HTTPURLResponse(url: URL(string: "https://apicarto.ign.fr/api/codes-postaux/communes/74160")!, statusCode: 500, httpVersion: nil, headerFields: nil)

    class NetworkError: Error {}
    static let error = NetworkError()

    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataPostalCode.self)
        let url = bundle.url(forResource: "PostalCode", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let postalCodeIncorrectData = "erreur".data(using: .utf8)!
}

