//
//  PlaceViewController.swift
//  testOrange
//
//  Created by mohamed habib msahel on 2/3/2023.
//
import Foundation

class PlacesViewModel: NSObject {
    
    private var apiService : Service!

    private(set) var result = Places () {
        didSet {
            DispatchQueue.main.async {
                self.binPlacesViewModelToController()
            }
        }
    }
    
    var binPlacesViewModelToController : (() -> ()) = {
    }
    
    
    override init(){
        super.init()
        self.apiService = Service()
        getPlacesByCoordinates(point: Point(lon: Double(UserDefaults.standard.string(forKey: "long")!)!, lat: Double(UserDefaults.standard.string(forKey: "lat")!)!))
    }
    
    func getPlacesByCoordinates(point : Point){
        self.apiService.getPlacesByCoordinates(point: point){ places in
            self.result = places
        }
        
    }
    
}

