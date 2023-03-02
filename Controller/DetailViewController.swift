//
//  DetailViewController.swift
//  testOrange
//
//  Created by mohamed habib msahel on 2/3/2023.
//

import UIKit

class DetailViewController: UIViewController {
    var placeDetail : DetailPlace?
    private var detailViewModel : DetailViewModelController!

    @IBOutlet weak var kinds: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUiUpdate()

        // Do any additional setup after loading the view.
    }
    func callToViewModelForUiUpdate(){
        self.detailViewModel =  DetailViewModelController()
               self.detailViewModel.binPlacesViewModelToController = {
                   DispatchQueue.global(qos: .background).async { [self] in
                            DispatchQueue.main.sync {
                                self.placeDetail = self.detailViewModel.result
                                imageView.loadFrom(URLAddress: self.placeDetail?.preview.source ?? "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80")
                                nameLabel.text = self.placeDetail?.name ?? ""
                                address.text = (self.placeDetail?.address.county ?? "") + (self.placeDetail?.address.city ?? "")
                                kinds.text = self.placeDetail?.kinds ?? ""
                                  }
                          }
               }
        }

    @IBAction func wikiLink(_ sender: Any) {
        if let url = URL(string: self.placeDetail!.wikipedia) {
            UIApplication.shared.open(url)
        }
    }
    
}
extension UIImageView{
    func loadFrom(URLAddress:String){
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.main.async{[weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self?.image = loadedImage
                }
            }
            
        }
    }
}
