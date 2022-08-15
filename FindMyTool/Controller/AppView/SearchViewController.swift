//
//  SearchViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 26/07/2022.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    let toolsCellId = "ToolsTableViewCell"
    
    
    // MARK: - IBOutlets & IBActions
    // IBOutlets
//    @IBOutlet weak var searchToolsTextField: UITextField!
//    
//    @IBOutlet weak var toolsResultTableView: UITableView!
//    let tools = [Tools]()
    
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Functions

}
// End of class
