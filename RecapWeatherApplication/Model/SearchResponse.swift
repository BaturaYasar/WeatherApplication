//
//  SearchResponse.swift
//  RecapWeatherApplication
//
//  Created by Mehmet Baturay Yasar on 20/11/2022.
//

import Foundation

// MARK: - SearchResponseElement
struct SearchResponse: Codable {
    let id: Int?
    let name, region, country: String?
    let lat, lon: Double?
    let url: String?
}
//
//typealias SearchResponse = [SearchResponseElement]
