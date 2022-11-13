//
//  WeatherAPI.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 13/11/2022.
//

import Foundation
import Moya

enum WeatherAPI {
    case forecast(q:String, days:Int, language:String)
}

extension WeatherAPI:TargetType {
    
    var baseURL: URL {
        if let url = URL(string: "https://weatherapi-com.p.rapidapi.com") {
            return url
        }else {
            fatalError("baseURL is not correct!")
        }
    }
    
    var path: String {
        return "forecast.json"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .forecast(let q, let days, let language):
            return .requestParameters(parameters: ["q":q, "days":days, "lang":language], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let headers = [
            "X-RapidAPI-Key": "4d0d5ea12cmsh428363f07a05d6bp1a6fd8jsnc7eaa04c8974",
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]
        return headers
    }
    
    
    
}
