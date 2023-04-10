//
//  CategoryView.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import SwiftUI

struct CategoryView: View {
   
    @ObservedObject var viewModel:SchoolViewModel
    @State var selected: Bool = false
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(spacing: 8) {
                        ForEach(viewModel.categories) { category in
                            VStack {
                                Image("categ-\(category.id)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .cornerRadius(15)
                                    .background(.white)
                                    .id(category.id)
                                
                                Text(category.type)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.black)
                                    .padding(.vertical, 4)
                                    .frame(maxWidth: .infinity)
                                    .background(category.selected ? Color.red : Color.white)
                            }
                            .frame(width: 80, height: 100, alignment: .center)
                            .cornerRadius(5)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.chooseCategory(category)
                                    
                                    
                                    if !category.selected{
                                        viewModel.search(searchText: "\(category.type) \(viewModel.search)")
                                    } else {
                                        viewModel.search(searchText: "\(viewModel.search)" )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
