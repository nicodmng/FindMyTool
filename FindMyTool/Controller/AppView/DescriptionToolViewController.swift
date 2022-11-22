//
//  DescriptionToolViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 10/11/2022.
//

import Foundation
import UIKit

protocol DescriptionToolViewControllerDelegate: AnyObject {
    func didChangeText(controller: DescriptionToolViewController, text: String)
}

class DescriptionToolViewController: UIViewController {
    
    weak var delegate: DescriptionToolViewControllerDelegate?
    var text: String?
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var descriptionToolTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionToolTextView.text = text
    }
    
    @IBAction func eraseButtonPressed(_ sender: UIButton) {
        descriptionToolTextView.text = ""
    }
    
    @IBAction func validateButtonPressed(_ sender: UIButton) {
        delegate?.didChangeText(controller: self, text: descriptionToolTextView.text)
        dismissViewController()
    }

    func dismissViewController() {
        self.dismiss(animated: true)
    }
    
}
