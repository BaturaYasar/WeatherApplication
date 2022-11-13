//
//  NSObject+Ext.swift
//  WeatherApplication
//
//  Created by Mehmet Baturay Yasar on 08/11/2022.
//

import Foundation

@objc extension NSObject {

    class var identifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
