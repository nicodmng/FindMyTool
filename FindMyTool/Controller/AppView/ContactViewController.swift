//
//  ContactViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 21/10/2022.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController {
    
    // MARK: - Properties
    
    var userLender = ""
    var userRender = ""
    var nameTool = "motoculteur"
    var databaseService: DatabaseService = DatabaseService()
    
    // MARK: - IBOulets & IBActions
    
    @IBAction func sendMessage(_ sender: UIButton) {
        sendEmail(userLender: databaseService.fetchUserID() , tool: nameTool)
    }
    
    @IBAction func eraseButtonPressed(_ sender: Any) {
        messageTextView.text = ""
    }
    
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !MFMailComposeViewController.canSendMail() {
            showAlert(message: "Envoi du message impossible")
            return
        }
    }
    
}

//MARK: - Extension

extension ContactViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail(userLender: String, tool: String) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["nicolas.demange@yahoo.fr"])
        mail.setSubject("\(userLender) aimerait louer votre \(tool)")
        mail.setMessageBody("\(String(describing: messageTextView.text ?? ""))", isHTML: false)
        present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
