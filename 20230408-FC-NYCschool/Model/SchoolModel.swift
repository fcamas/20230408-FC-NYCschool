//
//  SchoolModelOn.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import Foundation

// The SchoolModel struct represents the overall model for the application
struct SchoolModel {
    
    // schools stores an array of SchoolCard structs
    var schools: Array<SchoolCard>?
    
    // sats stores an array of SatCard structs
    var sats: Array<SatCard>?
    
    // categories stores an array of CategoryCard structs, representing the borough categories for schools
    var categories = [CategoryCard(id: 1, type: "Bronx"),
                      CategoryCard(id: 2, type: "Queens"),
                      CategoryCard(id: 3, type: "Brooklyn"),
                      CategoryCard(id: 4, type: "Manhattan")]
    
    // search stores the search string entered by the user
    var search = ""
    
    // The CategoryCard struct represents a single borough category
    struct CategoryCard: Identifiable{
        var id: Int
        var type:String
        var selected: Bool = false
    }
    
    // The SchoolCard struct represents a single school
    struct SchoolCard: Decodable,Identifiable{
        var id:String? {
            return dbn
        }
        var dbn: String?
        var name: String?
        var overview: String?
        var latitude: String?
        var longitude: String?
        var totalStudents: String?
        var location: String?
        var phoneNumber: String?
        var schoolEmail: String?
        var website: String?
        var borough: String?
        var bin:String?
        var selected: Bool = false
        
        var longitudeDouble: Double? {
            return Double(longitude ?? "00")
        }
        var latitudeDouble: Double? {
            return Double(latitude ?? "00")
        }
    }
    
    // The SatCard struct represents SAT data for a single school
    struct SatCard: Decodable,Identifiable {
        var id:String? {
            return dbn
        }
        var dbn: String?
        var schoolName: String?
        var numOfSatTestTakers: String?
        var satCriticalReadingAvgScore: String?
        var satMathAvgScore: String?
        var satWritingAvgScore: String?
    }
    
    // chooseCategory updates the selected state of a single category based on user interaction
    mutating func chooseCategory(_ category: CategoryCard) {
        for index in categories.indices {
            if categories[index].id == category.id {
                categories[index].selected.toggle()
            } else {
                categories[index].selected = false
            }
        }
    }
    
    // onSearch updates the search string based on user input
    mutating  func onSearch(_ withSearch:String){
        search = withSearch
    }
}

