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
    var timer: Timer?
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var toolImage: UIImageView!
    @IBOutlet weak var nameToolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var idRenderLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            print("test")
        })

        displayDetails()
    }
    
    
    // MARK: - Methods
    func displayDetails() {
        nameToolLabel.text = tool?.name
        priceLabel.text = tool?.price
        descriptionTextView.text = tool?.description
        townLabel.text = tool?.town
        postalCodeLabel.text = tool?.postalCode
    }
}
