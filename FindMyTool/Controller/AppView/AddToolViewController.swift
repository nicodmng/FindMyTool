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
    
    var serviceCP = CPService()
    
    var uidRender: String?
    var uidLender: String?
    
    var imageTool: String?
    var isAvailable: Bool?
    
    var nameTool = ""
    let name = ["LISTE OUTILS",
                "Boîte à outils",
                "Marteau-piqueur",
                "Motoculteur",
                "Outils de jardinage",
                "Tondeuse à gazon",
                "Taille-haie",
                "Motoculteur"]
    
    func UrlBuild() {
        var components = URLComponents(string: "")!
        components.host = "gs://findmytool-380cd.appspot.com"
        components.path = "nom du fichier"
        components.path = ""
    }
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var toolsPickerView: UIPickerView!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var localisationTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBAction func addImageButton(_ sender: UIButton) {
        showPopUp()
    }
    
    @IBAction func addToolButton(_ sender: UIButton) {
        databaseService.addToolInDatabase(name: nameTool,
                                          localisation: localisationTextField.text ?? "",
                                          price: priceTextField.text ?? "",
                                          town: townTextField.text ?? "",
                                          imageTool: imageTool ?? "http://apple.com/chfr",
                                          render: fetchUserID(),
                                          lender: uidLender ?? "",
                                          isAvailable: true)
        authService.getDocumentID()
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
//            databaseService.addPhotoInDatabase(fileURL: url)
            print(url)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
}
