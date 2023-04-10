//
//  ExtendedSchoolCardView.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import SwiftUI
import MapKit

struct ExtendedSchoolCardView: View {
    var card:SchoolModel.SchoolCard?
    var viewModel: SchoolViewModel
    
    var body: some View {
        VStack {
            DetailCardViews(card: card, viewModel: viewModel)
            
        }.foregroundColor(.black)
    }
    
}

struct DetailCardViews: View {
    var card: SchoolModel.SchoolCard?
    @ObservedObject var viewModel: SchoolViewModel
    @State private var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.786996, longitude: -122.440100),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var annotationItems: [MyAnnotationItem] = [
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 37.810000, longitude: -122.477450)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 37.786996, longitude: -122.419281))
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Map(coordinateRegion: $coordinateRegion,
                    annotationItems: annotationItems) { item in
                    MapMarker(coordinate: item.coordinate)
                }.ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                
                SchoolInformationView(schoolName: card?.name ?? "", location: card?.location, phoneNumber: card?.phoneNumber)
                    .foregroundColor(.blue)
                
                Divider()
                if let satData = viewModel.disSat {
                    SatDataView(satData: satData)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                Text(card?.overview ?? "")
                    .font(.title2)
                    .padding()
                
                Spacer()
            }.padding()
                .navigationBarTitle(card?.borough ?? "", displayMode: .automatic)
                .onAppear {
                    fetchSatData()
                    updateMap()
                }
        }
    }
    
    private func fetchSatData() {
        viewModel.fetchSatData(newCard: card?.id)
    }
    
    private func updateMap() {
        let coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: card?.latitudeDouble ?? 00,
                longitude: card?.longitudeDouble ?? 00),
            span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        )
        
        let annotationItems = [
            MyAnnotationItem(coordinate: CLLocationCoordinate2D(
                latitude: card?.latitudeDouble ?? 00,
                longitude: card?.longitudeDouble ?? 00))
        ]
        
        self.coordinateRegion = coordinateRegion
        self.annotationItems = annotationItems
    }
}



struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct SchoolInformationView: View {
    var schoolName: String
    var location: String?
    var phoneNumber: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(schoolName)
            
            
            if let location = location {
                HStack {
                    Image(systemName: "location.fill")
                    Text(location)
                }
            }
            
            if let phoneNumber = phoneNumber {
                HStack {
                    Image(systemName: "phone.fill")
                    Text(phoneNumber)
                }
            }
        }
        .padding(.bottom)
    }
}

struct SatDataView: View {
    var satData: SchoolModel.SatCard
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SAT Scores")
            
            
            HStack {
                Text("Reading:")
                Text(satData.satCriticalReadingAvgScore ?? "")
            }
            
            HStack {
                Text("Writing:")
                Text(satData.satWritingAvgScore ?? "")
            }
            HStack {
                Text("Math")
                Text(satData.satMathAvgScore ?? "")
            }
        }
    }
}
