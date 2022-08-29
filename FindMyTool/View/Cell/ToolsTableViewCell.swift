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
    @IBOutlet weak var statutToolLabel: UILabel!
    
    // MARK: - Properties
    var tool: Tools? {
        didSet {
            titleToolLabel.text = "\(String(describing: tool?.name))"
            priceToolLabel.text = "\(String(describing: tool?.price))"
            localisationToolLabel.text = "\(String(describing: tool?.localisation))"
            statutToolLabel.text = "\(String(describing: tool?.statut))"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
