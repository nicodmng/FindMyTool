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

    var tool: Tool?
    
    // MARK: - IBOulets & IBActions
    
    @IBAction func sendMessage(_ sender: UIButton) {
        sendEmail(userEmail: tool?.email ?? "")
    }
    @IBAction func eraseButtonPressed(_ sender: Any) {
        messageTextView.text = ""
    }
    
    @IBOutlet weak var messageTextView: UITextView!
    
    // MARK: ViewDidLoad
    
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
    
    // MARK: - Extension's methods
    
    func sendEmail(userEmail: String) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["\(userEmail)"])
        mail.setSubject("Quelqu'un s'intéresse à votre outil !")
        mail.setMessageBody("\(String(describing: messageTextView.text ?? ""))", isHTML: false)
        present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
