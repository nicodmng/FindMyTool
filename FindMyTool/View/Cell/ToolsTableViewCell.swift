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
    @IBOutlet weak var localisationToolLabel: UILabel!
    
    // MARK: - Properties
    var toolFromCell: Tools? {
        didSet {
            titleToolLabel.text = toolFromCell?.name
            priceToolLabel.text = toolFromCell?.price
            localisationToolLabel.text = toolFromCell?.localisation
        }
    }
    
}
