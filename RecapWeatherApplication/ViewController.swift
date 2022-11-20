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
    @IBOutlet weak var pageControl: UIPageControl!
    var forecastResponse:ForecastResponse?
    var locationManager:CLLocationManager!
    var userLocation:CLLocation?
    var userLocationArray = [CLLocation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        requestLocation()
        title = "WeatherApplication"
        
        
    }
    
    private func requestForecastWeather(_ userLocation:CLLocation) {
        NetworkManager.shared.forecastWeather(q: "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)") { result in
            switch result {
            case .success(let model):
                self.forecastResponse = model
                self.reloadCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updatePageControlNumber(){
        pageControl.numberOfPages = userLocationArray.count
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
    
    
    @IBAction func barButtonTouched(_ sender: Any) {
        let vc = SearchVC()
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension ViewController: SearchVCDelegate {
    func userSelect(_ userLocation: CLLocation) {
        userLocationArray.append(userLocation)
        updatePageControlNumber()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userLocationArray.count
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentCount = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = currentCount
        let currentData = userLocationArray[currentCount]
        requestForecastWeather(currentData)
    }
}

// MARK: CLLocationManagerDelegate
extension ViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if userLocationArray.count > 0 {
                userLocationArray.remove(at: 0)
            }
            userLocationArray.insert(location, at: 0)
            requestForecastWeather(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
