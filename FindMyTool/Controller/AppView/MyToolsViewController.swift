//
//  MyToolsViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 27/07/2022.
//

import UIKit
import Foundation

class MyToolsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let databaseService: DatabaseService = DatabaseService()
    private let authService: AuthService = AuthService()
    
    var tools = [ToolData]()
    
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
        databaseService.fetchTools(render: authService.fetchUserID()) { tools in
            self.tools = tools
            self.myToolsTableView.reloadData()
        }
    }

}

    // MARK: - UITableViewDataSource

extension MyToolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolCell", for: indexPath) as! ToolsTableViewCell
        cell.toolFromCell = tools[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = tools[indexPath.row].docId
            databaseService.deleteToolFromDB(id: id)
            
            tools.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

    // MARK: - UITableViewDelegate

extension MyToolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let messageForUser = UILabel()
        messageForUser.text = "Aucun outil dans la liste"
        messageForUser.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        messageForUser.textAlignment = .center
        messageForUser.textColor = .darkGray
        return messageForUser
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tools.isEmpty ? 400 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

