//
//  MyToolsViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 27/07/2022.
//

import UIKit
import FirebaseFirestore

class MyToolsViewController: UIViewController {
    
    // MARK: - IBOutlets & IBActions
    // IBActions
    @IBAction func plusPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAddToolViewController", sender: self)
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func createTool(name: String, price: String, localisation: String, statut: Bool) {
        let db = Firestore.firestore()
        db.collection("tools").document(name).setData([
            "name": name,
            "price": price,
            "localisation" : localisation,
            "statut": statut
        ]) { (error: Error?) in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("Document correctement sauvegardé")
            }
        }
    }
    
}
// End of class
