//
//  ZipToLatLngRequest.swift
//  Weather
//
//  Created by John Schils on 6/12/21.
//

import Foundation

struct ZipToLatLngRequest {
    let resourceURL:URL
    let API_KEY = "749761a54392ba7e116a4575d655edfd"
    let zipCode = UserDefaults.standard.string(forKey: "zipCode") ?? ""
    
    init() {
        let resourceString = "http://api.positionstack.com/v1/forward?access_key=\(API_KEY)&query=\(zipCode)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getLatLng(completion: @escaping(Result<Data, DataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let dataResponse = try decoder.decode(Data.self, from: jsonData)
                print("dataResponse:\n\(dataResponse)")
                completion(.success(dataResponse))
            } catch {
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
}

enum DataError:Error {
    case noDataAvailable
    case canNotProcessData
}
