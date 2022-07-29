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
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
