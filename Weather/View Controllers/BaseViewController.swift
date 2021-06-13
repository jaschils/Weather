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
    @IBOutlet weak var txtField_zipCode: UITextField!
    
    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var btn_process: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Base"
        
        
        
    }
    
    @IBAction func btn_process(_ sender: Any) {
        let zipCode = txtField_zipCode.text ?? ""
        if zipCode.count == 5 {
            UserDefaults.standard.setValue(zipCode, forKey: "zipCode")
            // TODO:  Call API to process zip code & return lat & lng
            let dataRequest = ZipToLatLngRequest()
            dataRequest.getLatLng  { (result) in
                print(result)
            }
            
//            dataRequest.getLatLng { [weak self] result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let dayWeather):
//                    let daysWeather = dayWeather
//                    print(daysWeather)
//                }
//            }
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
