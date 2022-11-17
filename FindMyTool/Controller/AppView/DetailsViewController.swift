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
//    var coreDataService: CoreDataService?
    
    var favoriteImage: UIImage {
        return UIImage(systemName: "star.fill")!
    }
    
    var unfavoriteImage: UIImage {
        return UIImage(systemName: "star")!
    }
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var toolImage: UIImageView!
    @IBOutlet weak var nameToolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var idRenderLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!


    @IBAction func favoriteButtonPressed(_ sender: Any) {
//        addToFavorites()
    }
    
    @IBAction func contactButton(_ sender: UIButton) {
        openPresentModally()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let coreDataStack = appDelegate.coreDataStack
//        coreDataService = CoreDataService(coreDataStack: coreDataStack)
        
        displayDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    // MARK: - Methods
    
//    func addToFavorites() {
//        guard let tool = tool else { return }
//        guard let coreDataService = coreDataService else { return }
//
//        if coreDataService.isToolRegistered(name: tool.name) {
//            coreDataService.deleteTool(name: tool.name)
//        } else {
//            coreDataService.createFavoriteTool(tool: tool)
//        }
//    }
    
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
