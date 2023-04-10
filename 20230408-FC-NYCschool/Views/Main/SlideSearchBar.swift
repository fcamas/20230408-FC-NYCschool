//
//  SlideSearchBar.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import SwiftUI

struct SlideSearchBar: View {
    @State private var isSearching = false
    @State var search:String = ""
    
    let autosearchDelay = MainViewSizes().searchDelay
    var viewModel:SchoolViewModel
    
    var body: some View {
        ZStack {
            if isSearching {
                HStack {
                    HStack{
                    Image(systemName: "magnifyingglass")
                        .frame(height: 44)
                        .background(.white)
                        TextField("Search", text: $search)
                            .onChange(of: search) { _ in
                                autoSearch(interval: autosearchDelay) {
                                     var withext = ""
                                    for cat in viewModel.categories {
                                        if cat.selected {
                                            withext = cat.type
                                        }
                                    }
                                    viewModel.onSearch(search)
                                    viewModel.search(searchText: search + " " + withext)
                                }
                            }.frame(height: 44)
                            .background(.white)
                }.frame(height: 44)
                    .background(.white)
                    .cornerRadius(10)
                
                    Button(action: {
                        isSearching = false
                    }) {
                        HStack(spacing: 20) {
                            Button(action: {
                                isSearching = false
                            }) {
                                Image(systemName: "chevron.left")
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
                .transition(.slide)
            } else {
                HStack {
                    Text("School NYC")
                        .font(.headline)
                        .padding(.leading)
                    Spacer()
                    HStack(spacing: 20) {
                        Button(action: {
                            isSearching = true
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                        
                    }
                    .padding(.trailing)
                }
                .frame(height: 44)
                .transition(.slide)
            }
        }
    }
    
    func autoSearch(interval: TimeInterval, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: action)
    }
}
