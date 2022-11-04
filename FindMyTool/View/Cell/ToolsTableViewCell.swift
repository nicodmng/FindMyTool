//
//  ToolsTableViewCell.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 29/07/2022.
//

import UIKit

class ToolsTableViewCell: UITableViewCell {

    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius()
    }
    
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
            priceToolLabel.text = (toolFromCell?.price ?? "") + " € / jour"
            CPToolLabel.text = toolFromCell?.postalCode
            localisationToolLabel.text = toolFromCell?.town
            
            guard let urlTool = URL(string: toolFromCell?.imageLink ?? "") else { return }
            toolImageView.load(url: urlTool)
        }
    }
    
    var toolEntity: ToolEntity? {
        didSet {
            titleToolLabel.text = toolEntity?.name
            priceToolLabel.text = (toolEntity?.price ?? "") + " € / jour"
            localisationToolLabel.text = toolEntity?.town
            CPToolLabel.text = toolEntity?.postalCode
            guard let urlTool = URL(string: toolFromCell?.imageLink ?? "") else { return }
            toolImageView.load(url: urlTool)
        }
    }
    
    func cornerRadius() {
        self.toolImageView.layer.cornerRadius = 8
    }
}
