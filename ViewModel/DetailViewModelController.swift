//
//  DetailViewController.swift
//  testOrange
//
//  Created by mohamed habib msahel on 2/3/2023.
//

import Foundation

class DetailViewModelController: NSObject {

    private var apiService : Service!
    private(set) var result : DetailPlace! {
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
        getPlaceDetail(id: UserDefaults.standard.string(forKey: "xid")!)
    }
    
    func getPlaceDetail(id : String){
        self.apiService.getPlaceDetails(id: id){ places in
            self.result = places
        }
    }

    }
    



