//
//  News.swift
//  Playo
//
//  Created by Sachin Jadhav on 14/07/22.
//

import Foundation


struct News : Codable {
    
    var articles : [all]
}

struct all : Codable  {
    var author : String?
    var title : String?
    var description : String?
    var urlToImage : String?
    var url : String?
}
