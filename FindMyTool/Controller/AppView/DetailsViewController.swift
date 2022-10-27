//
//  DetailViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 04/10/2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var tool: Tool?
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var toolImage: UIImageView!
    @IBOutlet weak var nameToolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var idRenderLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    
    @IBAction func contactButton(_ sender: UIButton) {
        openPresentModally()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayDetails()
    }
    
    
    // MARK: - Methods
    func displayDetails() {
        nameToolLabel.text = tool?.name
        priceLabel.text = tool?.price
        descriptionTextView.text = tool?.description
        townLabel.text = tool?.town
        postalCodeLabel.text = tool?.postalCode
        
        guard let urlTool = URL(string: tool?.imageLink ?? "") else { return }
        toolImage.load(url: urlTool)
    }
    
    func openPresentModally() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ContactViewController")
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        self.present(viewController, animated: true)
    }
}
