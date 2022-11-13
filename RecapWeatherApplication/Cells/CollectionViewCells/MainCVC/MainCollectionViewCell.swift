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
        let uinibHorizontal = UINib(nibName: HorizontalSecondTVC.identifier, bundle: nil)
        tableView.register(uinibHorizontal, forCellReuseIdentifier: HorizontalSecondTVC.identifier)
    }

}

extension MainCollectionViewCell: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RealTimeTableViewCell.identifier, for: indexPath) as! RealTimeTableViewCell
            if let current = self.forecastResponse?.current , let location = self.forecastResponse?.location{
                cell.cellConfigure(current, location: location)
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HorizontalSecondTVC.identifier, for: indexPath) as! HorizontalSecondTVC
            cell.hours = self.forecastResponse?.forecast?.forecastday?.first?.hour
            cell.collectionView.reloadData()
            return cell
        }
        return UITableViewCell()
    }
}

extension MainCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 225
        }else if indexPath.section == 1 {
            return 150
        }
        return 0
    }
}
