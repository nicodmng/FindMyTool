//
//  CPService.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 02/09/2022.
//

import Foundation

class CPService {
    
    // MARK: - Properties
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Functions
    func getLocation(postalCode: String, callback: @escaping (Result<[TownData], NetworkError>) -> Void) {
        guard let url = URL(string: "https://apicarto.ign.fr/api/codes-postaux/communes/\(postalCode)")
        else { return }
        session.dataTaskHomeMade(with: url, callback: callback)
    }
}
