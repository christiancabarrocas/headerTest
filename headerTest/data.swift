//
//  data.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 21/11/14.
//  Copyright (c) 2014 ccs. All rights reserved.
//

import Foundation
import UIKit


struct NewsItem {
    
    let category: NewsCategory
    let summary: String
    
    enum NewsCategory {
        case World
        case Americas
        case Europe
        case MiddleEast
        case Africa
        case Asia
        
        func toString () -> String {
            switch self {
                case .World:
                    return "World"
                case .Americas:
                    return "Americas"
                case .Europe:
                    return "Europe"
                case .MiddleEast:
                    return "Middle East"
                case .Africa:
                    return "Africa"
                case .Asia:
                    return "Asia"
            }
        }
        
        func toColor () -> UIColor {
            switch self {
            case .World:
                return UIColor(red: 0.106, green: 0.680, blue: 0.125, alpha: 1)
            case .Americas:
                return UIColor(red: 0.115, green: 0.640, blue: 0.950, alpha: 1)
            case .Europe:
                return UIColor(red: 0.325, green: 0.460, blue: 0.950, alpha: 1)
            case .MiddleEast:
                return UIColor(red: 0.500, green: 0.290, blue: 0.950, alpha: 1)
            case .Africa:
                return UIColor(red: 0.950, green: 0.275, blue: 0.285, alpha: 1)
            case .Asia:
                return UIColor(red: 0.625, green: 0.775, blue: 0.150, alpha: 1)
            }
        }
    }
}