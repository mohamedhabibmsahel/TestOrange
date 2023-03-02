//
//  HomeScreenViewController.swift
//  testOrange
//
//  Created by mohamed habib msahel on 2/3/2023.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
     
    
    //var
    private var placesViewModel : PlacesViewModel!
    var tabPlaces = [Place]()
    var selectedTag : String?
    var tabPlacesFiltred : [Place]?
    let locationManager = CLLocationManager()
    let services = Service()
    var point : Point?
    // widgets
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlacesToTableview()
        point = Point(lon: Double(UserDefaults.standard.string(forKey: "long")!)!, lat: Double(UserDefaults.standard.string(forKey: "lat")!)!)
        placeNumber.text="Places of interest \(tabPlaces.count)"
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let cv = cell?.contentView
        let nom = cv?.viewWithTag(1) as! UILabel
        let desc = cv?.viewWithTag(2) as! UILabel
        let distance = cv?.viewWithTag(3) as! UILabel
        let fav = cv?.viewWithTag(4) as! UIButton
        nom.text = tabPlaces[indexPath.row].name
        desc.text = tabPlaces[indexPath.row].kinds
        distance.text = String(format: "%.2f", self.tabPlaces[indexPath.row].dist!) + "m"
        placeNumber.text = "Places of interest (\(tabPlaces.count))"
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         performSegue(withIdentifier: "firstSegue", sender: indexPath)
     }
    // IBactions
    
    @IBAction func arienaBtn(_ sender: Any) {
        UserDefaults.standard.setValue("10.181532", forKey: "long")
        UserDefaults.standard.setValue("36.806496", forKey: "lat")
        loadPlacesToTableview()
    }
    @IBAction func sousseBtn(_ sender: Any) {
        UserDefaults.standard.setValue("10.634422", forKey: "long")
        UserDefaults.standard.setValue("35.821430", forKey: "lat")
        loadPlacesToTableview()
    }
    @IBAction func tunisiaBtn(_ sender: Any) {
        UserDefaults.standard.setValue("10.640630", forKey: "long")
        UserDefaults.standard.setValue("35.829300", forKey: "lat")
        loadPlacesToTableview()
    }
    @IBAction func favorites(_ sender: Any) {
    }
    @IBAction func myLocation(_ sender: Any) {
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
           currentLoc = locationManager.location
            UserDefaults.standard.setValue(currentLoc.coordinate.latitude, forKey: "lat")
            UserDefaults.standard.setValue(currentLoc.coordinate.longitude, forKey: "long")
            loadPlacesToTableview()
          
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue" {
            let index = sender as! IndexPath
            let destination = segue.destination as! DetailViewController
            UserDefaults.standard.setValue(tabPlaces[index.row].xid, forKey: "xid")
        }
     
    }
    func loadPlacesToTableview (){
        self.placesViewModel =  PlacesViewModel()
               self.placesViewModel.binPlacesViewModelToController = {
                   DispatchQueue.global(qos: .background).async {
                       //sleep(2)
                            DispatchQueue.main.sync {
                                self.tabPlaces = self.placesViewModel.result
                                self.tableView.reloadData()
                                  }
                          }
               }
        }
        
    }

