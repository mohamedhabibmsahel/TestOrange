//
//  Place.swift
//  testOrange
//
//  Created by mohamed habib msahel on 2/3/2023.
//

import Foundation

// MARK: - Place
struct Place: Codable {
    let xid, name: String?
    let dist: Double?
    let rate: Int?
    let osm, wikidata, kinds: String?
    let point: Point
}

// MARK: - Point
struct Point: Codable {
    let lon, lat: Double
}
typealias Places = [Place]
