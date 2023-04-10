//
//  SchoolModelOn.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import Foundation

struct SchoolModel {
    var schools: Array<SchoolCard>?
    var sats: Array<SatCard>?
    var categories = [CategoryCard(id: 1, type: "Bronx"),
                    CategoryCard(id: 2, type: "Queens"),
                    CategoryCard(id: 3, type: "Brooklyn"),
                    CategoryCard(id: 4, type: "Manhattan")
                    
                    ]
    var search = ""
   
    struct CategoryCard: Identifiable{
        var id: Int
        var type:String
        var selected: Bool = false
    }
    

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
    
    mutating func chooseCategory(_ category: CategoryCard) {
        for index in categories.indices {
            if categories[index].id == category.id {
                categories[index].selected.toggle()
            } else {
                categories[index].selected = false
            }
        }
    }
    
    mutating  func onSearch(_ withSearch:String){
        search = withSearch
    }
    
    
}
