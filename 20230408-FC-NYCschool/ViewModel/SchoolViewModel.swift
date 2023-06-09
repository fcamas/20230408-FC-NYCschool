//
//  SchoolViewModel.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import Foundation

class SchoolViewModel: ObservableObject {
    
    // MARK: Properties
    
    // Initialize the view model by fetching the school data
    init() {
        fetchSchoolData()
    }
    
    // Published properties to update the UI
    @Published var model = SchoolModel()
    @Published var disSchool: [SchoolModel.SchoolCard] = []
    @Published var disSat:SchoolModel.SatCard?
    
    // Arrays to hold main cards
    var mainCardContainerSchool = [SchoolModel.SchoolCard]()
    var mainCardContainerSat = [SchoolModel.SatCard]()
    
    // Computed properties to get data from the model
    var categories: [SchoolModel.CategoryCard] {
        return model.categories
    }
    
    var school: Array<SchoolModel.SchoolCard> {
        return model.schools ?? []
    }
    
    var sat: Array<SchoolModel.SatCard> {
        return model.sats ?? []
    }
    
    var search: String {
        return model.search
    }
    
    // KeyPath array for search
    let searchFields: [KeyPath<SchoolModel.SchoolCard, String>] = [\SchoolModel.SchoolCard.name!]
    
    // MARK: Methods
    
    // Choose a category
    func chooseCategory(_ category: SchoolModel.CategoryCard) {
        model.chooseCategory(category)
    }
    
    // Search for a string
    func onSearch(_ withSearch: String) {
        model.onSearch(withSearch)
    }
    
    func search(searchText: String) {
        if searchText.isEmpty {
            // If search text is empty, show all the main school cards
            disSchool = mainCardContainerSchool.sorted { $0.name ?? "" < $1.name ?? "" }
            disSchool = self.mainCardContainerSchool
            return
        }
        
        let searchTerms = searchText.lowercased().split(separator: " ")
        disSchool = mainCardContainerSchool.filter { card in
            for field in searchFields {
                let value = card[keyPath: field].lowercased()
                for term in searchTerms {
                    if !value.contains(term) {
                        return false
                    }
                }
            }
            return true
        }
        .sorted { $0.name ?? "" < $1.name ?? "" }
    }
    
    // Fetch the school data from the API
    func fetchSchoolData() {
        mainCardContainerSchool = []
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/uq7m-95z8.json") else {
            print("Failed to create URL")
            return
        }
        URLSession.shared.fetchData(for: url) { (result: Result<[School], Error>) in
            switch result {
            case .success(let schools):
                DispatchQueue.main.async {
                    let schoolCards = schools.map { SchoolModel.SchoolCard(
                        dbn: $0.dbn,
                        name: $0.school_name,
                        overview: $0.overview_paragraph,
                        latitude: $0.latitude,
                        longitude: $0.longitude,
                        totalStudents: $0.total_students,
                        location: $0.location,
                        phoneNumber: $0.phone_number,
                        schoolEmail: $0.school_email,
                        website: $0.website,
                        borough: $0.borough,
                        bin: $0.bin
                    )}
                    // Add the fetched school cards to the main card container
                    self.mainCardContainerSchool.append(contentsOf: schoolCards)
                    if self.disSchool.isEmpty {
                        // Show all the main school cards if no search is performed
                        self.disSchool = self.mainCardContainerSchool
                    }
                }
            case .failure(let error):
                print("Failed to fetch schools data: \(error)")
                // show an error message to the user
            }
        }
    }
    
  
    /// Fetches SAT data for a school with the given DBN.
    /// - Parameters:
    ///    - newCard: The DBN of the school for which to fetch SAT data.

    func fetchSatData(newCard: String?) {
        // Set disSat to nil to clear any previously fetched SAT data.
        disSat = nil
        
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {
            print("Invalid URL")
            return
        }
        
        // Fetch SAT data from the specified URL.
        URLSession.shared.fetchData(for: url) { (result: Result<[Sat], Error>) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    // Loop through the fetched SAT data and find the one with the matching DBN.
                    results.forEach { card in
                        if card.dbn == newCard {
                            // Create a new SAT card with the fetched data.
                            self.disSat = SchoolModel.SatCard(
                                dbn: card.dbn,
                                schoolName: card.school_name,
                                numOfSatTestTakers: card.num_of_sat_test_takers,
                                satCriticalReadingAvgScore: card.sat_critical_reading_avg_score,
                                satMathAvgScore: card.sat_math_avg_score,
                                satWritingAvgScore: card.sat_writing_avg_score
                            )
                        }
                    }
                }
            case .failure(let error):
                print("Failed to fetch SAT data: \(error)")
                // Show an error message to the user.
            }
        }
    }
}
