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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
}

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
