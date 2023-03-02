//
//  Region.swift
//  testOrange
//
//  Created by mohamed habib msahel on 2/3/2023.
//

import Foundation

// MARK: - Region
struct Region: Codable {
    let name, country: String
    let lat, lon: Double
    let population: Int
    let timezone, status: String
}
