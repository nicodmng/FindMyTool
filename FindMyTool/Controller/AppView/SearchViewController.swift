//
//  SearchViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 26/07/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase

class SearchViewController: UIViewController, ResultTownViewControllerDelegate {
    
    // MARK: - Properties
    
    let dataBaseService = DatabaseService()
    var nameTool = ""
    let name = ["LISTE OUTILS",
                "Boîte à outils",
                "Marteau-piqueur",
                "Motoculteur",
                "Outils de jardinage",
                "Tondeuse à gazon",
                "Taille-haie",
                "Motoculteur"]
    var codePostal: String = ""
    var town: String = ""
    let db = Firestore.firestore()
    let segueToResult = "segueToResult"
    var resultTools: [ToolData] = []
    
    // MARK: - IBOutlets & IBActions
    
    // IBOutlets
    @IBOutlet weak var townNameLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    
    // IBActions
    @IBAction func SearchButton(_ sender: UIButton) {
        
        findToolsFromDB(nameTool: nameTool, toolCP: postalCodeLabel.text ?? "") { tools in
            self.resultTools = tools
            self.performSegue(withIdentifier: self.segueToResult, sender: nil)
        }

    }
    
    // MARK: - ViewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
     //MARK: - UIStoryboardSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultTownViewController = segue.destination as? ResultTownViewController
        resultTownViewController?.delegate = self
        
        if segue.identifier == segueToResult {
            let resultViewController = segue.destination as? ResultViewController
            resultViewController?.tools = resultTools
        }
    }
    
    // MARK: - Functions

    func findToolsFromDB(nameTool: String, toolCP: String, callback: @escaping ([ToolData]) -> Void) {
        var tools = [ToolData]()
        db.collection("tools").whereField("town", isEqualTo: self.town).whereField("name", isEqualTo: nameTool)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let dict = document.data()
                        let tool = ToolData(docId: document.documentID, name: dict["name"] as! String, description: dict["description"] as! String, postalCode: dict["localisation"] as! String, price: dict["price"] as! String, town: dict["town"] as! String, lender: dict["lender"] as! String)
                        tools.append(tool)
                    }
                    callback(tools)
                }
            }
    }
    
    // MARK: - ResultTownViewControllerDelegate
    
    func didSelectTown(town: String, postalCode: String) {
        townNameLabel.text = town
        self.town = town
        self.postalCodeLabel.text = postalCode
        self.codePostal = postalCode
    }
    
}

// MARK: - Extensions

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
