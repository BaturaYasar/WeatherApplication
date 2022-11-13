//
//  HorizontalSecondTVC.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 13/11/2022.
//

import UIKit

class HorizontalSecondTVC: UITableViewCell {
    
    var hours:[Hour]?

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let uinib = UINib(nibName: HourWeatherCVC.identifier, bundle: nil)
        collectionView.register(uinib, forCellWithReuseIdentifier: HourWeatherCVC.identifier)
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension HorizontalSecondTVC: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hours?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourWeatherCVC.identifier, for: indexPath) as! HourWeatherCVC
        if let hours = self.hours?[indexPath.row] {
            cell.cellConfigure(hours)
        }
        
        return cell
    }
    
    
}

extension HorizontalSecondTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 150)
    }
}
