//
//  NetworkManager.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 13/11/2022.
//

import Foundation
import Moya

protocol NetworkManagerDelegate {
    
    var provider: MoyaProvider<WeatherAPI> {get}
    
    func forecastWeather(q:String, days:Int, language:String, completion:@escaping(Result<ForecastResponse, Error>) -> ())
    
}

class NetworkManager: NetworkManagerDelegate {
    
    static let shared = NetworkManager()
    
    var provider = MoyaProvider<WeatherAPI>(plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    func forecastWeather(q: String, days: Int, language: String, completion: @escaping (Result<ForecastResponse, Error>) -> ()) {
        request(target: .forecast(q: q, days: days, language: language), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: WeatherAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
