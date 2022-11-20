//
//  SearchVC.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 20/11/2022.
//

import UIKit
import CoreLocation

protocol SearchVCDelegate {
    func userSelect(_ location:CLLocation)
}


class SearchVC: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var delegate:SearchVCDelegate?
    var searchResponse:[SearchResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupTableView()
        
    }
    
    func getSearchResult(_ searchText:String) {
        NetworkManager.shared.search(q: searchText) { result in
            switch result {
            case .success(let model):
                self.searchResponse = model
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("error")
            }
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let uinib = UINib(nibName: BasicTextTVC.identifier, bundle: nil)
        tableView.register(uinib, forCellReuseIdentifier: BasicTextTVC.identifier)
    }
    
    func setupTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textChange(_:)), for: .editingChanged)
    }
    
    @objc func textChange(_ textField:UITextField) {
        if textField.text == "" {
            self.searchResponse?.removeAll()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchVC: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasicTextTVC.identifier, for: indexPath) as! BasicTextTVC
        cell.cityLabel.text = searchResponse?[indexPath.row].name
        return cell
    }
    
    
    
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedName = searchResponse?[indexPath.row].name {
            let vc = BottomSheetVC()
            vc.selectedName = selectedName
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true)
        }
       
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {return false}
        self.view.endEditing(true)
        getSearchResult(textField.text ?? "")
        return true
    }
}


extension SearchVC:BottomSheetVCDelegate {
    func userSelection(_ location: CLLocation) {
        delegate?.userSelect(location)
        self.navigationController?.popViewController(animated: true)
    }
}

