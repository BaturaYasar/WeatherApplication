//
//  BottomSheetVC.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 20/11/2022.
//

import UIKit
import CoreLocation

protocol BottomSheetVCDelegate {
    func userSelection(_ location:CLLocation)
}

class BottomSheetVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var cardCityLabel: UILabel!
    @IBOutlet weak var cardTimeLabel: UILabel!
    @IBOutlet weak var cardCTempLabel: UILabel!
    @IBOutlet weak var cardContinentLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    var selectedName:String?
    var delegate: BottomSheetVCDelegate?
    var forecast:ForecastResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        NetworkManager.shared.forecastWeather(q: selectedName ?? "") { result in
            switch result {
            case .success(let model):
                self.setupUI(model)
                self.forecast = model
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupUI(_ forecast:ForecastResponse) {
        cityLabel.text = "Current Weather"
        cardCityLabel.text = forecast.location?.name ?? ""
        cardTimeLabel.text = forecast.location?.localtime ?? ""
        cardCTempLabel.text = "\(forecast.current?.tempC ?? 0.0)"
        cardContinentLabel.text = forecast.location?.tzID ?? ""
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let selectedLat  = self.forecast?.location?.lat
        let selectedLong  = self.forecast?.location?.lon
        let location = CLLocation(latitude: selectedLat ?? 0.0, longitude: selectedLong ?? 0.0)
        delegate?.userSelection(location)
        dismiss(animated: true)
    }
    
}
