//
//  AddToolViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import UIKit

class AddToolViewController: UIViewController {
    
    // MARK: - Properties
    
    private let databaseService: DatabaseService = DatabaseService()
    
    private let authService: AuthService = AuthService()
    private let imagePickerController = UIImagePickerController()
    static let didAddNewTool: Notification.Name = .init("AddToolViewController.didAddNewTool")
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
                "Boîte à outils",
                "Marteau-piqueur",
                "Motoculteur",
                "Outils de jardinage",
                "Scie",
                "Tondeuse à gazon",
                "Taille-haie",
                "Motoculteur"]

    // MARK: - Initializer
    
    
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var toolsPickerView: UIPickerView!
    
    @IBOutlet weak var priceTextField: UITextField!

    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var cpLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    @IBAction func addImageButton(_ sender: UIButton) {
        showPopUp()
    }
    
    @IBAction func addToolButton(_ sender: UIButton) {
        
        self.databaseService.uploadImageToStorage(imageLocalUrl: self.imageLocalUrl!, completion: {
            self.addTool()

            self.authService.getDocumentID()
        })
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methodes
    
    func addTool() {
        self.databaseService.addToolInDatabase(name: self.nameTool,
                                                    localisation: self.cpLabel.text ?? "",
                                                    description: self.descriptionTextView.text ?? "",
                                                    price: self.priceTextField.text ?? "",
                                                    town: self.townLabel.text ?? "",
                                                    imageLink: self.databaseService.imageURL ?? "",
                                                    imagePath: self.imagePath ?? "",
                                                    render: self.fetchUserID(),
                                                    lender: self.uidLender ?? "",
                                          isAvailable: true) { error in
            if error == nil {
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Self.didAddNewTool, object: nil)
            } else {
                self.showAlert(message: "Votre outil n'a pas été correctement sauvegardé")
            }
        }
    }
    
    func fetchUserID() -> String {
        var userID = ""
        authService.getUserId { uid in
            userID = uid
        }
        return userID
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
