//
//  BaseViewController.swift
//  Weather
//
//  Created by John Schils on 6/12/21.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_zipCode: UILabel!
    @IBOutlet weak var lbl_zipData: UILabel!
    @IBOutlet weak var txtField_zipCode: UITextField!
    
    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var btn_process: UIButton!
    
    
    var zipCodeDetails = [DataDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.lbl_zipData.text = """
                    \(self.zipCodeDetails[0].administrative_area ?? "")\n
                    \(self.zipCodeDetails[0].latitude ?? 0.0)\n
                    \(self.zipCodeDetails[0].longitude ?? 0.0)\n
                    \(self.zipCodeDetails[0].postal_code ?? "")\n
                    \(self.zipCodeDetails[0].region ?? "")\n
                    """
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Base"
        
        
    }
    
    @IBAction func btn_process(_ sender: Any) {
        let zipCode = txtField_zipCode.text ?? ""
        if zipCode.count == 5 {
            UserDefaults.standard.setValue(zipCode, forKey: "zipCode")
            let dataRequest = ZipToLatLngRequest()
            
            dataRequest.getLatLng { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let details):
                    //TODO: Process data into the app
                    self?.zipCodeDetails = details
                }
            }
        } else {
            // TODO: UIAlertMessage
            
        }
        
        
    }
    
    
    @IBAction func btn_send(_ sender: Any) {
        
        //        WeatherRequest().getDailyWeather(42.1368, -83)
        let weatherRequest = WeatherRequest(lat: "42.1368", lng: "-83.8293")
        weatherRequest.getDailyWeather { (result) in
            print(result)
        }
        
        weatherRequest.getDailyWeather { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let dayWeather):
                let daysWeather = dayWeather
                print(daysWeather)
            }
        }
    }

}
