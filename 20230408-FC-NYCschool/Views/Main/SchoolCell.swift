//
//  SchoolCell.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import SwiftUI

struct SchoolCell: View {
    var schoolName: String = "HS of Science and Math"
    var schoolBorough: String = "Bronx"
    
    var body: some View {
        GeometryReader{ geometric in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 25)
                shape
                    .strokeBorder(lineWidth: 3)
                if schoolBorough == "BROOKLYN "{
                    shape.fill().foregroundColor(Color(hex: "f7efff"))
                    
                }else if schoolBorough  == "MANHATTAN"{
                    shape.fill().foregroundColor(Color(hex: "e3ccff"))
                }else if schoolBorough  == "BRONX    "{
                    shape.fill().foregroundColor(Color(hex: "c797ff"))
                } else if schoolBorough  == "QUEENS   "{
                    shape.fill().foregroundColor(Color(hex: "ac65ff"))
                }else {
                    shape
                        .fill()
                }
                
                VStack{
                    Text(schoolName)
                        .font(font(geometric.size))
                        .padding()
                    
                    Text(schoolBorough)
                        .font(font(geometric.size))
                        .padding()
                }.foregroundColor(.black)
                
            }
            .foregroundColor(.white)
        }
    }
    
    func font(_ size: CGSize)->Font{
        Font.system(size: min(size.width, size.height)*0.1)
    }
}

struct SchoolCell_Previews: PreviewProvider {
    static var previews: some View {
        SchoolCell()
    }
}
