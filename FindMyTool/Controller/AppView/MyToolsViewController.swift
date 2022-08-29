//
//  MyToolsViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 27/07/2022.
//

import UIKit
import Foundation

class MyToolsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    private let authFirebase: AuthFirebase = AuthFirebase()

    // MARK: - IBOutlets & IBActions
    // IBActions
    @IBAction func plusPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAddToolViewController", sender: self)

    }
    
    @IBOutlet weak var myToolsTableView: UITableView!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myToolsTableView.register(UINib(nibName: "ToolsTableViewCell", bundle: nil), forCellReuseIdentifier: "CellTool")
        myToolsTableView.delegate = self
        myToolsTableView.reloadData()
    }
    
    // MARK: - Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myToolsTableView.dequeueReusableCell(withIdentifier: "ToolsTableViewCell", for: indexPath)
        
        return cell
    }
    
}
// End of class

