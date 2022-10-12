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
            
            guard let urlTool = URL(string: "https://firebasestorage.googleapis.com:443/v0/b/findmytool-380cd.appspot.com/o/images%2F0B000C29-2867-47D3-8B5A-254C0DAE2370?alt=media&token=3c413a19-04da-4707-8348-c7870299ae2b") else { return }
            toolImageView.load(url: urlTool)
        }
    }
    
}
