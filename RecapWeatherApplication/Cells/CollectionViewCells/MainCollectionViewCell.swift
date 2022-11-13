//
//  MainCollectionViewCell.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 13/11/2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    var forecastResponse:ForecastResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    func setupTableView() {
        let uinib = UINib(nibName: RealTimeTableViewCell.identifier, bundle: nil)
        tableView.register(uinib, forCellReuseIdentifier: RealTimeTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension MainCollectionViewCell: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RealTimeTableViewCell.identifier, for: indexPath) as! RealTimeTableViewCell
        if let current = self.forecastResponse?.current , let location = self.forecastResponse?.location{
            cell.cellConfigure(current, location: location)
        }
        
        return cell
    }
    
    
    
}

extension MainCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}
