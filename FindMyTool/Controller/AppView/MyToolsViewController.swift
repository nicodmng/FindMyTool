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
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveDidAddNewTool), name: AddToolViewController.didAddNewTool, object: nil)
    }
    
    @objc
    func didReceiveDidAddNewTool() {
        fetchTools()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTools()
    }
    
    func fetchTools() {
        databaseService.fetchTools(render: databaseService.fetchUserID()) { tools in
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
            _ = tools[indexPath.row].imagePath

            databaseService.deleteToolFromDB(id: id)
            // databaseService.deleteImageFromDB(toolImage: image ?? "")
            
            tools.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

    // MARK: - UITableViewDelegate

extension MyToolsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let messageForUser = UILabel()
        messageForUser.text = "Votre liste d'outil est vide."
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

