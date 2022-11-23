//
//  ContactSupportViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 23/11/2022.
//

import UIKit
import MessageUI

class ContactSupportViewController: UIViewController {
    
    // MARK: - Properties
    
    var databaseService: DatabaseService = DatabaseService()
    var databaseSession: DatabaseSession = DatabaseSession()
    var tool: Tool?
    
    var rapport: [String] = ["un bug",
                             "une question",
                             "une remarque",
                            "une réclamation"]
    var feedback = ""
    
    // MARK: - IBOulets & IBActions
    
    @IBOutlet weak var messageSupportTextView: UITextView!
    
    @IBAction func eraseButtonPressed(_ sender: UIButton) {
        messageSupportTextView.text = ""
    }
    
    @IBAction func sendMessageToSupportPressed(_ sender: UIButton) {
        sendEmailToSupport(reportType: feedback)
    }
    
    @IBOutlet weak var choiceObjectPickerView: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !MFMailComposeViewController.canSendMail() {
            showAlert(message: "Envoi du message impossible")
            return
        }
    }
    
}

//MARK: - Extension

extension ContactSupportViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmailToSupport(reportType: String) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["nicolas.demange@yahoo.fr"])
        mail.setSubject("Ce retour concerne \(reportType).")
        mail.setMessageBody("\(String(describing: messageSupportTextView.text ?? ""))", isHTML: false)
        present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

// MARK: - Extension

extension ContactSupportViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rapport[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rapport.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        feedback = rapport[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let toolLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        toolLabel.text = rapport[row]
        toolLabel.font = .boldSystemFont(ofSize: 18)
        toolLabel.textColor = UIColor.darkGray
        return toolLabel
    }
    
}
