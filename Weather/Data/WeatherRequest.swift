//
//  WeatherRequest.swift
//  Weather
//
//  Created by John Schils on 6/12/21.
//

import Foundation

enum WeatherError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct WeatherRequest {
    let resourceURL:URL
    let API_KEY = "e7f96f0d2ad8b2e0c7d14c5a61c499cc"
    
    init(lat:String, lng:String) {
        let resourceString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lng)&exclude=minutely,hourly,alerts&appid=\(API_KEY)&units=imperial"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getDailyWeather(completion: @escaping(Result<Week, WeatherError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(Week.self, from: jsonData)
                print("weatherResponse:\n\(weatherResponse)")
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
}
