//
//  ListSection.swift
//  COMMI
//
//  Created by Katerina Ivanova on 14.11.2023.
//

import Foundation

enum ListSection: String {
    case filter//([FilterList])
    case recommended//([Movie])
    case shows//([Movie])
    
//    var item: String {
//        switch self {
//        case .filter(_): ""
//        case .recommended(_): "Recommended For You"
//        case .shows(_): "Tv Shows"
//        }
//    }
//    
//    var count: Int {
//        item.count
//    }
}


struct FilterList {
    var title: String
}
