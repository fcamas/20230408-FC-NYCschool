//
//  Constant.swift
//  20230408-FC-NYCschool
//
//  Created by FredyCamas on 4/8/23.
//

import SwiftUI

struct DessertCardSizes{
    var height = UIScreen.main.bounds.height*0.25
    var width = UIScreen.main.bounds.width*9
    var corneRadius:CGFloat = 20
    var shadow:CGFloat = 10
    var leading: CGFloat = 20
}

struct MainViewSizes{
    
    var searchDelay = 0.5
    
    var rectangleStrokeLineWidth:CGFloat = 1
    var rectangleFrame:CGFloat = 50
    var rectangleConerRadius:CGFloat = 20
    
    var cardFrame:CGFloat = 300
}

struct ExpandedViewSizes{
    
    var minY:CGFloat = 300
    var shadowRadius:CGFloat = 10
    var cornerRadius:CGFloat = 10
    var headerFrame:CGFloat = 250
}
