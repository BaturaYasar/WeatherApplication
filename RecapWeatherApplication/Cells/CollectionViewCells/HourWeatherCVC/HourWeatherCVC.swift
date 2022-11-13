//
//  HourWeatherCVC.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 13/11/2022.
//

import UIKit
import Kingfisher

class HourWeatherCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(_ hour:Hour) {
        let fullTime = hour.time?.components(separatedBy: " ")
        self.hourLabel.text = fullTime?.last ?? ""
        if let imageUrlString = hour.condition?.icon , let url = URL(string: "https:\(imageUrlString)") {
            iconImage.kf.setImage(with: url)
        }
        self.tempLabel.text = "\(hour.tempC ?? 0.0)"
        
    }

}
