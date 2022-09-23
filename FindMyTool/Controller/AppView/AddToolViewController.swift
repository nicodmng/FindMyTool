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
    var serviceCP = CPService()
    
    var uidRender: String?
    var uidLender: String?
 
    var townUser: String?
    var imageTool: URL?
    var isAvailable: Bool?
    
    var nameTool = ""
    let name = ["Boîte à outils",
                "Marteau-piqueur",
                "Motoculteur",
                "Outils de jardinage",
                "Tondeuse à gazon",
                "Taille-haie",
                "Motoculteur"]
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var toolsPickerView: UIPickerView!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var localisationTextField: UITextField!
    
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    @IBAction func addToolButton(_ sender: UIButton) {
        databaseService.addToolInDatabase(name: nameTool,
                                       localisation: localisationTextField.text ?? "",
                                       price: priceTextField.text ?? "",
                                       town: townUser ?? "",
                                       render: fetchUserID(),
                                       lender: uidLender ?? "",
                                       isAvailable: true)
        authService.getDocumentID()
        }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
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
