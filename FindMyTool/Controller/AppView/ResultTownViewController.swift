//
//  ResultTownViewController.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 19/09/2022.
//

import Foundation
import UIKit

    // MARK: - Protocol

protocol ResultTownViewControllerDelegate {
    func didSelectTown(town: String, postalCode: String)
}

class ResultTownViewController: UIViewController {
    
    // MARK: - Properties
    
    var serviceCP = CPService()
    var townList: [TownData]?
    var delegate: ResultTownViewControllerDelegate?
        
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    @IBOutlet weak var townTableView: UITableView!
    
    @IBAction func getTownButton(_ sender: UIButton) {
        fetchPostalCode()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        townTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methodes
    
    func fetchPostalCode() {
        serviceCP.getLocation(postalCode: postalCodeTextField.text ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let towns):
                    self?.townList = towns
                    self?.townTableView.reloadData()
                case .failure(let error):
                    self?.showAlert(message: error.description)
                }
            }
        }
    }
    
}

    // MARK: - Tableview Delegate & Datasource

extension ResultTownViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "townCell", for: indexPath)
        cell.textLabel?.text = townList?[indexPath.row].nomCommune
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectTown(town: townList?[indexPath.row].nomCommune ?? "",
                                postalCode: townList?[indexPath.row].codePostal ?? "")
        dismiss(animated: true)
    }
    
}
