//
//  ZipToLatLng.swift
//  Weather
//
//  Created by John Schils on 6/12/21.
//

import Foundation

struct Data: Decodable {
    var data:DataDetails
}

struct DataDetails: Decodable {
    var latitude:Double
    var longitude:Double
    var postal_code:String
    var region:String
    var administrative_area:String
}
