//
//  Weather.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/22.
//

import Foundation

struct Weather: Decodable {
    
    let current: Current
    struct Current: Decodable {
        let temp: Double?
        let pressure: Double?
    }
}
