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
    
    var tool: Tool!
    let databaseSession = DatabaseSession()
    
    var favoriteImage: UIImage {
        return UIImage(systemName: "star.fill")!
    }
    var unfavoriteImage: UIImage {
        return UIImage(systemName: "star")!
    }
    var toolIsFavorite: Bool? {
        didSet {
            guard let toolIsFavorite else { return }

            if toolIsFavorite {
                self.favoriteButton.setBackgroundImage(self.favoriteImage, for: .normal)
            } else {
                self.favoriteButton.setBackgroundImage(self.unfavoriteImage, for: .normal)
            }
        }
    }
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var toolImage: UIImageView!
    @IBOutlet weak var nameToolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var idRenderLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        guard let toolIsFavorite else { return }

        let tappedButton = sender as? UIButton
        //tappedButton?.isEnabled = false
        
        if toolIsFavorite {
            databaseSession.deleteFavoriteTool(docID: tool.docId ?? "") { status in
                if status {
                    //tappedButton?.isEnabled = true
                    self.toolIsFavorite?.toggle()
                }
            }
        } else {
            databaseSession.addToolInFavorite(name: tool?.name ?? "", localisation: tool?.postalCode ?? "", description: tool?.description ?? "", price: tool?.price ?? "", town: tool?.town ?? "", imageLink: tool?.imageLink ?? "", render: databaseSession.fetchUserID(), toolId: tool.toolId!, email: tool?.email ?? "") { error in
                //tappedButton?.isEnabled = true
                if error == nil {
                    self.toolIsFavorite?.toggle()
                }
            }
        }
    }
    
    @IBAction func contactButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueDetailsToContact", sender: nil)
        openPresentModally()
        
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        displayDetails()
        
        favoriteButton.isHidden = true

        databaseSession.isFavoriteTool(toolId: tool.toolId!) { isFavorite in
            self.toolIsFavorite = isFavorite
            self.favoriteButton.isHidden = false
            if isFavorite {
                self.favoriteButton.setBackgroundImage(self.favoriteImage, for: .normal)
            } else {
                self.favoriteButton.setBackgroundImage(self.unfavoriteImage, for: .normal)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Methods
    
    func displayDetails() {
        nameToolLabel.text = tool?.name
        priceLabel.text = (tool?.price ?? "") + " € / jour"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailsToContact",
           let next = segue.destination as? ContactViewController {
            next.tool = tool
        }
    }
    

}
