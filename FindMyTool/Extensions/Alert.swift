//
//  Alert.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 27/07/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alertController: UIAlertController = .init(title: "Attention", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    func showInformation(message: String) {
        let alertController: UIAlertController = .init(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
}
