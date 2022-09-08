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
    private let authService: AuthService = AuthService()
    

    
    // MARK: - IBOutlets & IBActions
    // IBActions
    @IBAction func plusPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAddToolViewController", sender: self)
    }
    
    @IBOutlet weak var myToolsTableView: UITableView!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myToolsTableView.register(UINib(nibName: "ToolsTableViewCell", bundle: nil), forCellReuseIdentifier: "ToolCell")
        myToolsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myToolsTableView.reloadData()

        authFirebase.fetchTools(idUser: "va3tb28kZ1SzcQ0s3Cof9YfB32J3")
        }

    // MARK: - Functions

    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authFirebase.tools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolCell", for: indexPath) as! ToolsTableViewCell
 
        cell.toolFromCell = authFirebase.tools[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
// End of class

