//
//  ViewController.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 13/11/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var forecastResponse:ForecastResponse?
    var locationManager:CLLocationManager!
    var userLocation:CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        requestLocation()
        title = "WeatherApplication"
        
    }
    
    private func requestLocation()  {
        // Create a CLLocationManager and assign a delegate
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = 100
        // Request a user’s location once
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
        private func requestForecastWeather(_ userLocation:CLLocation) {
        NetworkManager.shared.forecastWeather(q: "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)", days: 3, language: "tr") { result in
            switch result {
            case .success(let success):
                self.forecastResponse = success
                self.reloadCollectionView()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func setupCollectionView() {
        let uinib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        collectionView.register(uinib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.forecastResponse = self.forecastResponse
        cell.tableView.reloadData()
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.size
        return CGSize(width: size.width, height: size.height)
    }
}

// MARK: CLLocationManagerDelegate
extension ViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.userLocation = location
            requestForecastWeather(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
