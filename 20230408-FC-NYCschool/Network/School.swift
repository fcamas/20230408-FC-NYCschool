//
//  School.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import Foundation

// model for fetching data from api

struct School: Decodable,Identifiable{
    var id:String? {
        return dbn
    }
    var dbn: String?
    var school_name: String?
    var overview_paragraph: String?
    var latitude: String?
    var longitude: String?
    var total_students: String?
    var location: String?
    var phone_number: String?
    var school_email: String?
    var website: String?
    var borough: String?
    var bin:String?
    
    var longitudeDouble: Double? {
        return Double(longitude ?? "00")
    }
    var latitudeDouble: Double? {
        return Double(latitude ?? "00")
    }
}
