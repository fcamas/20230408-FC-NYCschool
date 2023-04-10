//
//  ContentView.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = SchoolViewModel()
    
    @State var hero = false
    @State var search = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            SlideSearchBar(viewModel: viewModel)
                            CategoryView(viewModel: viewModel).padding(.all)
                            ResultView(viewModel: viewModel)
                            
                        }
                        
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    }
                }
            }
         
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


