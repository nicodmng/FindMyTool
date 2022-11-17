//
//  FavoriteViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 04/11/2022.
//

import CoreData
import UIKit

//class FavoriteViewController: UITableViewController {
//
//    // MARK: - Properties
////    var coreDataService: CoreDataService?
//    var tool: Tool?
//
//    let cellReuseIdentifier = "ToolCell"
//    private let segueToToolDetail = "segueFromFavoriteToDetails"
//
//    // MARK: - IBOutlets
//
//    @IBOutlet weak var favoriteTableView: UITableView!
//
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let nibName = UINib(nibName: "ToolsTableViewCell", bundle: nil)
//        favoriteTableView.register(nibName, forCellReuseIdentifier: cellReuseIdentifier)
//
////        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
////        let coredataStack = appDelegate.coreDataStack
////        coreDataService = CoreDataService(coreDataStack: coredataStack)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        favoriteTableView.reloadData()
//    }
//
//    // MARK: - TableView DataSource
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return coreDataService?.toolsFavorite.count ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
//                as? ToolsTableViewCell else { return UITableViewCell() }
//
//        let toolFav = coreDataService?.toolsFavorite[indexPath.row]
//
//        favoriteCell.toolEntity = toolFav
//
//        return favoriteCell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let favoriteTool = coreDataService?.toolsFavorite[indexPath.row] else { return }
//
//        tool = Tool(entity: favoriteTool)
//
//        performSegue(withIdentifier: "segueFromFavoriteToDetails", sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueFromFavoriteToDetails",
//            let next = segue.destination as? DetailsViewController {
//            next.tool = tool
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard let coreData = coreDataService else { return }
//        let removeTool = coreData.toolsFavorite[indexPath.row]
//        guard let name = removeTool.name else { return }
//
//        if editingStyle == .delete {
//            coreData.deleteTool(name: name)
//            favoriteTableView.reloadData()
//        }
//    }
//
//
//    // MARK: - Functions
//
//    // Text if favorite is empty :
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let informationForUser = UILabel()
//        informationForUser.text = "Votre liste de favoris est vide."
//        informationForUser.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//        informationForUser.textAlignment = .center
//        informationForUser.textColor = .darkGray
//        return informationForUser
//    }
//
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return coreDataService?.toolsFavorite.isEmpty ?? true ? 400 : 0
//    }
//
//}

