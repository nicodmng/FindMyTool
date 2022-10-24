//
//  ContactViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 21/10/2022.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController {
    
    var userFindMyTool = "Nicolas"
    var nameTool = "motoculteur"
    
    @IBAction func sendMessage(_ sender: UIButton) {
        sendEmail(name: userFindMyTool, tool: nameTool)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - Extension

extension ContactViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail(name: String, tool: String) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["nicolas.demange@yahoo.fr"])
        mail.setSubject("\(name) aimerait louer votre \(tool)")
        mail.setMessageBody("\(name) aimerait louer votre \(tool)", isHTML: false)
        present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
