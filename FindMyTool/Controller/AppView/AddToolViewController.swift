//
//  AddToolViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import UIKit

class AddToolViewController: UIViewController, ResultTownViewControllerDelegate {

    // MARK: - Properties
    
    private let databaseService: DatabaseService = DatabaseService()
    let databaseSession = DatabaseSession()

    private let imagePickerController = UIImagePickerController()
    static let didAddNewTool: Notification.Name = .init("AddToolViewController.didAddNewTool")
    
    var codePostal: String = ""
    var town: String = ""
    
    var passedDescription: String?
    var serviceCP = CPService()
    var uidRender: String?
    var uidLender: String?
    var imageLink: String?
    var imageLocalUrl: URL? {
        didSet {
            print("did set imageLocalUrl")
        }
    }
    
    var imagePath: String?
    var nameTool = ""
    let name = [
                "Aspirateur",
                "Boîte à outils",
                "Marteau-piqueur",
                "Motobineuse",
                "Motoculteur",
                "Outils de jardinage",
                "Perceuse manuelle",
                "Perceuse à percussion",
                "Perceuse sans fil",
                "Perforateur",
                "Pince monseigneur",
                "Ponceuse électrique",
                "Rallonge électrique",
                "Scie",
                "Scie cloche",
                "Scie sauteuse",
                "Taille-haie",
                "Tondeuse à gazon",
                "Tronçonneuse",
                ]

    // MARK: - Initializer
    
    
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var toolsPickerView: UIPickerView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var cpLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBAction func descriptionToolButtonPressed(_ sender: Any) {
        openDescriptionPresentModally()
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
        showPopUp()
    }
    
    @IBAction func addToolButton(_ sender: UIButton) {
        self.databaseSession.uploadImageToStorage(imageLocalUrl: self.imageLocalUrl!, completion: {
            self.addTool()
            self.databaseService.getDocumentID()
        })
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        priceTextField.inputAccessoryView = toolBar()
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Methodes
    
    func addTool() {
        self.databaseSession.addToolInDatabase(name: self.nameTool,
                                                    localisation: self.cpLabel.text ?? "",
                                                    description: self.descriptionTextView.text ?? "",
                                                    price: self.priceTextField.text ?? "",
                                                    town: self.townLabel.text ?? "",
                                                    imageLink: self.databaseSession.imageURL ?? "",
                                                    imagePath: self.imagePath ?? "",
                                                    render: self.fetchUserID(),
                                                    lender: self.uidLender ?? "",
                                                    isAvailable: true,
                                                    email: databaseSession.fetchUserEmail()) { error in
            if error == nil {
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Self.didAddNewTool, object: nil)
            } else {
                self.showAlert(message: "Votre outil n'a pas été correctement sauvegardé")
            }
        }
    }
    
    func didSelectTown(town: String, postalCode: String) {
        townLabel.text = town
        self.town = town
        self.cpLabel.text = postalCode
        self.codePostal = postalCode
    }
    
    func fetchToolId() -> String {
        var toolId = ""
        databaseSession.getToolId { id in
            toolId = id
        }
        return toolId
    }
    
    func fetchUserID() -> String {
        var userID = ""
        databaseService.getUserId { uid in
            userID = uid
        }
        return userID
    }
    
    func openDescriptionPresentModally() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let descriptionToolViewController = storyboard.instantiateViewController(withIdentifier: "DescriptionToolViewController") as! DescriptionToolViewController
        
        descriptionToolViewController.delegate = self
        descriptionToolViewController.text = descriptionTextView.text
        
        if let presentationController = descriptionToolViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        self.present(descriptionToolViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultTownViewController = segue.destination as? ResultTownViewController
        resultTownViewController?.delegate = self
    }
    
    // MARK: - Alert Controller for "Photo Library", "Camera" or "Cancel" selection
    
    private func showPopUp() {
        let actionSheet = UIAlertController(title: "FindMyTool", message: "Choisissez une photo", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
}

// MARK: - Extensions

extension AddToolViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return name.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return name[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameTool = name[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let _ = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let toolLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        
        toolLabel.text = name[row]
        toolLabel.font = .boldSystemFont(ofSize: 20)
        toolLabel.textColor = UIColor.white
        return toolLabel
    }
    
}

// MARK: - Extensions

extension AddToolViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            self.imageLocalUrl = url
            }
        imagePickerController.dismiss(animated: true)
    }
}

extension AddToolViewController: DescriptionToolViewControllerDelegate {
    
    func didChangeText(controller: DescriptionToolViewController, text: String) {
        descriptionTextView.text = text
    }
}
