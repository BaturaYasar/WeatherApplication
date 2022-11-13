//
//  RealTimeTableViewCell.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 13/11/2022.
//

import UIKit

class RealTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var minDegreeLabel: UILabel!
    @IBOutlet weak var maxDegreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.makeCorner(radius: 8)
        
    }
    
    func cellConfigure(_ current:Current, location:Location) {
        cityNameLabel.text = location.name ?? ""
        tempLabel.text = "\(current.tempC ?? 0.0)"
        conditionLabel.text = current.condition?.text ?? ""
        minDegreeLabel.text = "FeelsLike: \(current.feelslikeC ?? 0.0)"
        maxDegreeLabel.text = location.tzID ?? ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIView {
    func makeCorner(radius:CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
