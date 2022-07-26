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
    
    let db = Firestore.firestore()
    
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
    
    var codePostal: String = ""
    var town: String = ""
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
    
    // MARK: - ViewDidLoad & ViewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    //MARK: - UIStoryboardSegue
    
    // Take values from resultTownVC to resultVC
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
        db.collection("tools").whereField("town", isEqualTo: self.town).whereField("name", isEqualTo: nameTool).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    let dict = document.data()
                    let tool = ToolData(description: dict["description"] as? String, docId: document.documentID, name: dict["name"] as! String, postalCode: dict["localisation"] as! String, price: dict["price"] as! String, lender: dict["lender"] as! String, imageLink: dict["imageLink"] as? String, town: dict["town"] as! String, toolId: document.documentID, email: dict["email"] as? String)
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
    
    // Picker view
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
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        30
    }
    
    // Customize Picker view
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let _ = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let toolLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        
        toolLabel.text = name[row]
        toolLabel.font = .boldSystemFont(ofSize: 25)
        toolLabel.textColor = UIColor.white
        return toolLabel
    }
    
}
