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
    var forecastDay:Forecastday?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
   
    
    func setupTableView() {
        let uinib = UINib(nibName: RealTimeTableViewCell.identifier, bundle: nil)
        tableView.register(uinib, forCellReuseIdentifier: RealTimeTableViewCell.identifier)
        let uinibHorizontal = UINib(nibName: HorizontalSecondTVC.identifier, bundle: nil)
        tableView.register(uinibHorizontal, forCellReuseIdentifier: HorizontalSecondTVC.identifier)
        let uinibVertical = UINib(nibName: VerticalDaysTVC.identifier, bundle: nil)
        tableView.register(uinibVertical, forCellReuseIdentifier: VerticalDaysTVC.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }

}

extension MainCollectionViewCell: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }else if section == 2 {
            return forecastResponse?.forecast?.forecastday?.count ?? 3
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
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: VerticalDaysTVC.identifier, for: indexPath) as! VerticalDaysTVC
            if let forecastDay = forecastResponse?.forecast?.forecastday?[indexPath.row] {
                cell.cellConfigure(forecastDay: forecastDay)
            }
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
        }else if indexPath.section == 2 {
            return 55
        }
        return 0
    }
}
