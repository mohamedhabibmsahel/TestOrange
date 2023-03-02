//
//  Service.swift
//  testOrange
//
//  Created by mohamed habib msahel on 2/3/2023.
//
import Foundation

class Service :  NSObject {
    
    private let sourcesURL =  "https://api.opentripmap.com/0.1/en/places/"
    
    func getPlacesByCoordinates(point : Point, completion : @escaping (Places) -> ()){
        let urlComps = URLComponents(string: sourcesURL + "radius?apikey=5ae2e3f221c38a28845f05b6e1e72f6e6fae9bc6a9473af209e333f9&radius=\(UserDefaults.standard.string(forKey: "radius")!)&lon=\(point.lon)&lat=\(point.lat)&rate=3&format=json")
        let request = URLRequest(url: (urlComps?.url)!)
        URLSession.shared.dataTask(with: request ) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode(Places.self, from: data)
                    completion(empData)
            }
        }.resume()
    }
    func getallplaces(point : Point ,callback: @escaping (Bool,Places?)->Void){
        
         
         let jsonUrlString = sourcesURL + "radius?apikey=5ae2e3f221c38a28845f05b6e1e72f6e6fae9bc6a9473af209e333f9&radius=\(UserDefaults.standard.string(forKey: "radius")!)&lon=\(point.lon)&lat=\(point.lat)&rate=3&format=json"
             guard let url = URL(string: jsonUrlString) else
             { return }

             URLSession.shared.dataTask(with: url) { (data, response, err) in

                 guard let data =  data else{ return }

                 do {

                     let allPlaces = try JSONDecoder().decode(Places.self, from: data)
                    
                     
                 callback(true,allPlaces)
                     
          
                 } catch let jsonErr {
                     print("Error serializing json:", jsonErr)
                 }

             }.resume()
     }
    
    func getPlaceDetails(id : String, completion : @escaping (DetailPlace?) -> ()){
        let urlComps = URLComponents(string: sourcesURL + "xid/\(id)?apikey=5ae2e3f221c38a28845f05b6e1e72f6e6fae9bc6a9473af209e333f9")
        let request = URLRequest(url: (urlComps?.url)!)
        URLSession.shared.dataTask(with: request ) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                let empData = try? jsonDecoder.decode(DetailPlace.self, from: data)
                    completion(empData)
            }
        }.resume()
    }

}
