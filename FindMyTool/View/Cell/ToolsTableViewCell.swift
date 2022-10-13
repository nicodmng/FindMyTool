//
//  ToolsTableViewCell.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import UIKit

class ToolsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets & IBActions
    // IBOutlets
    @IBOutlet weak var toolImageView: UIImageView!
    @IBOutlet weak var titleToolLabel: UILabel!
    @IBOutlet weak var priceToolLabel: UILabel!
    @IBOutlet weak var CPToolLabel: UILabel!
    @IBOutlet weak var localisationToolLabel: UILabel!
    
    
    // MARK: - Properties
    var toolFromCell: ToolData? {
        didSet {
            titleToolLabel.text = toolFromCell?.name
            priceToolLabel.text = toolFromCell?.price
            CPToolLabel.text = toolFromCell?.postalCode
            localisationToolLabel.text = toolFromCell?.town
            
            guard let urlTool = URL(string: toolFromCell?.imageTool ?? "") else { return }
            toolImageView.load(url: urlTool)
        }
    }
    
}
