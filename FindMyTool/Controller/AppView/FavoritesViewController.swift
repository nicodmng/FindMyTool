//
//  FavoritesViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 17/11/2022.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let cellId = "ToolCell"
    private let databaseSession: DatabaseSession = DatabaseSession()
    private let databaseService: DatabaseService = DatabaseService()
    var favoritesTools = [FavoriteToolData]()
    var tool: Tool?
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoritesTools()
        let nibCell = UINib(nibName: "ToolsTableViewCell", bundle: .main)
        favoritesTableView.register(nibCell, forCellReuseIdentifier: cellId)
    }
    
    // MARK: - Methodes
    func fetchFavoritesTools() {
        databaseService.fetchFavoriteTool(render: databaseService.fetchUserID()) { tools in
            self.favoritesTools = tools
            self.favoritesTableView.reloadData()
        }
    }
    
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesTools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ToolsTableViewCell
        cell.favToolFromCell = favoritesTools[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = favoritesTools[indexPath.row].docId
            databaseSession.deleteFavoriteTool(docID: id) { _ in
            }
            favoritesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let messageForUser = UILabel()
        messageForUser.text = "Votre liste de favoris est vide."
        messageForUser.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        messageForUser.textAlignment = .center
        messageForUser.textColor = .darkGray
        return messageForUser
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoritesTools.isEmpty ? 400 : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favTool = favoritesTools[indexPath.row]
        self.tool = Tool(name: favTool.name, price: favTool.price, town: favTool.town, imageLink: favTool.imageLink, postalCode: favTool.localisation, description: favTool.description, toolId: favTool.toolId ?? "", docId: favTool.docId ?? "", email: favTool.email ?? "")
        
        performSegue(withIdentifier: "segueFavoritesToDetails", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFavoritesToDetails",
           let next = segue.destination as? DetailsViewController {
            next.tool = tool
        }
    }
    
}
