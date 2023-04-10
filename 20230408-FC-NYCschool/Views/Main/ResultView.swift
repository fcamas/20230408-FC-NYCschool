//
//  ResultView.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var viewModel: SchoolViewModel
    
    var body: some View {
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { proxy in
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                        ForEach(viewModel.disSchool) { card in
                            NavigationLink(destination: ExtendedSchoolCardView(card: card, viewModel: viewModel)) {
                                
                                SchoolCell(schoolName: card.name!, schoolBorough: card.borough!)
                            }.aspectRatio(2/3, contentMode: .fit)
                            
                        }
                    }
                }
           
            }.padding(.all)
            
     
        }
    }
}


