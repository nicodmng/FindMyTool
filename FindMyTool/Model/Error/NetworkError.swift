//
//  NetworkError.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 02/09/2022.
//

import Foundation

enum NetworkError: Error {
    case noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    
    // Some error for different case
    var description: String {
        switch self {
        case .noData:
            return "Le service est momentanément indisponible"
        case .invalidResponse:
            return "Le service est momentanément indisponible"
        case .undecodableData:
            return "Le service est momentanément indisponible"
        }
    }
}
