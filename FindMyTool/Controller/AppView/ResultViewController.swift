//
//  ResultViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 12/09/2022.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    // MARK: - Properties
    
    var tools = [Tool]()
    var toolsResult = [ToolsResult]()
    
    @IBOutlet weak var resultTableView: UITableView!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.register(UINib(nibName: "ToolsTableViewCell", bundle: nil), forCellReuseIdentifier: "ToolCell")
        resultTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resultTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toolsResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolCell", for: indexPath) as! ToolsTableViewCell
        
        cell.resultFromCell = toolsResult[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ResultViewController: UITableViewDelegate {
    
}

