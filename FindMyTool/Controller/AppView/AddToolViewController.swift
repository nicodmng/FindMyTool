//
//  AddToolViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import UIKit

class AddToolViewController: UIViewController {

    // MARK: - Properties

    var nameTool = ""
    let name = ["Boîte à outils",
                "Marteau-piqueur",
                "Tondeuse à gazon",
                "Taille-haie",
                "Motoculteur"]
    
    var availableTool = ""
    let statut = ["Disponible",
                  "Non Disponible"]
    
    
    private let authFirebase: AuthFirebase = AuthFirebase()
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var toolsPickerView: UIPickerView!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var localisationTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    @IBAction func addToolButton(_ sender: UIButton) {
        authFirebase.addToolInDatabase(name: nameTool,
                                       price: priceTextField.text ?? "",
                                       localisation: localisationTextField.text ?? ""
                                       )
        
        authFirebase.getResultFromDatabase(name: nameTool)
        print(nameTool)
    }
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methodes
    func titleForPickerRow() {

    }
    
}
// End of class

    // MARK: - Extensions
extension AddToolViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
