//
//  AddToolViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import UIKit

class AddToolViewController: UIViewController {

    // MARK: - Properties
    let tools = ["Boîte à outils",
                "Marteau-piqueur",
                "Tondeuse à gazon",
                "Taille-haie",
                "Motoculteur"]
    
    private let authFirebase: AuthFirebase = AuthFirebase()
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var localisationTextField: UITextField!
    @IBOutlet weak var conditionTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    @IBAction func addToolButton(_ sender: UIButton) {
        authFirebase.addToolInDatabase(name: "Tournevis",
                                       price: priceTextField.text ?? "",
                                       localisation: localisationTextField.text ?? "",
                                       statut: conditionTextField.text ?? "")        
    }
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
// End of class

    // MARK: - Extensions
extension AddToolViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tools.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tools[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
