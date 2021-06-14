//
//  BaseViewController.swift
//  Weather
//
//  Created by John Schils on 6/12/21.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var lbl_zipCode: UILabel!
    @IBOutlet weak var lbl_zipData: UILabel!
    @IBOutlet weak var txtField_zipCode: UITextField!
    
    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var btn_process: UIButton!
    
    
    var zipCodeDetails = [DataDetails]() {
        didSet {
            let locality = self.zipCodeDetails[0].locality ?? ""
            let lat = self.zipCodeDetails[0].latitude ?? 0.0
            let lng = self.zipCodeDetails[0].longitude ?? 0.0
            let zip = self.zipCodeDetails[0].postal_code ?? ""
            let region = self.zipCodeDetails[0].region ?? ""
            
            UserDefaults.standard.setValue(locality, forKey: "locality")
            UserDefaults.standard.set(lat, forKey: "lat")
            UserDefaults.standard.set(lng, forKey: "lng")
            UserDefaults.standard.setValue(zip, forKey: "zip")
            UserDefaults.standard.setValue(region, forKey: "region")
            
            DispatchQueue.main.async {
                self.lbl_zipData.text = """
                    \(locality), \(region) \(zip)
                    Lattitude:  \(lat)
                    Longitude:  \(lng)
                    """
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather App"
        
        txtField_zipCode.layer.cornerRadius = 10
        lbl_zipData.layer.cornerRadius = 10
        btn_process.layer.cornerRadius = 10
        btn_send.layer.cornerRadius = 10
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
    
    
    fileprivate func convertDate(_ currentDay: Double) -> String {
        let date = Date(timeIntervalSince1970: currentDay)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    @IBAction func btn_getWeather(_ sender: Any) {
        let lat = UserDefaults.standard.double(forKey: "lat")
        let lng = UserDefaults.standard.double(forKey: "lng")
        
        let weatherRequest = WeatherRequest(lat: "\(lat)", lng: "\(lng)")
        weatherRequest.getDailyWeather { (result) in
//            print(result)
            weatherRequest.getDailyWeather { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let dayWeather):
//                    let daysWeather = dayWeather
//                    print(daysWeather)
                    guard let currentDay = dayWeather.current.dt else {fatalError()}
                    guard let currentTemp = dayWeather.current.temp else {fatalError()}
                    guard let currentForecast = dayWeather.current.weather[0].main else {fatalError()}
                    
                    let date = Date(timeIntervalSince1970: currentDay)
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                    dateFormatter.timeZone = .current
                    let localDate = dateFormatter.string(from: date)
                    
                    print("""
                        Current time = \(localDate)
                        Current temp = \(currentTemp)
                        Current Forecast = \(currentForecast)
                        """)
                }
            }
        }
        
        
    }

}
