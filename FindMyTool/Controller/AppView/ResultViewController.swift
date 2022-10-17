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
    
    var tools: [ToolData] = []
    var tool: Tool?
    
    // MARK: - IBOutlet & IBAction
    
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
        return tools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolCell", for: indexPath) as! ToolsTableViewCell
        
        cell.toolFromCell = tools[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tool = tools[indexPath.row]
        
        self.tool = Tool(name: tool.name, price: tool.price, town: tool.town, imageLink: tool.imageLink, postalCode: tool.postalCode, description: tool.description)
        
        performSegue(withIdentifier: "segueToDetails", sender: nil)
    }
}

    // MARK: - UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails",
            let next = segue.destination as? DetailsViewController {
            next.tool = tool
            
        }
    }
}
