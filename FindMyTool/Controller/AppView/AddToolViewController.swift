//
//  AddToolViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import UIKit

class AddToolViewController: UIViewController {

    // MARK: - Properties
    private let authFirebase: AuthFirebase = AuthFirebase()
    private let authService: AuthService = AuthService()
    var serviceCP = CPService()
    
    var uidUser: String?
    var townUser: String?
    
    var nameTool = ""
    let name = ["Boîte à outils",
                "Marteau-piqueur",
                "Tondeuse à gazon",
                "Taille-haie",
                "Motoculteur"]
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var toolsPickerView: UIPickerView!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var localisationTextField: UITextField!
    
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    @IBAction func addToolButton(_ sender: UIButton) {
        authFirebase.addToolInDatabase(idUser: uidUser ?? "Inconnu",
                                       name: nameTool,
                                       price: priceTextField.text ?? "",
                                       localisation: localisationTextField.text ?? "",
                                       town: townUser ?? "Inconnu")
        fetchPostalCode()
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        fetchUserID()
    }
    
    // MARK: - Methodes
    func fetchUserID() {
        authService.getUserId { [weak self] uid in
            self?.uidUser = uid
        }
    }
    
    func fetchPostalCode() {
        serviceCP.getLocation(postalCode: localisationTextField.text ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let towns):
                    for town in towns {
                        var result = town.nomCommune
                        result = self?.townUser ?? "Pas de commune"
                        print(town.nomCommune)
                    }
                case .failure(let error):
                    self?.showAlert(message: error.description)
                }
            }
        }
    }
  
}
// End of class

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
