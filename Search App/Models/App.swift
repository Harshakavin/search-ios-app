//
//  App.swift
//  Search App
//
//  Created by SE on 10/3/18.
//  Copyright © 2018 IT15049582_IT15060822. All rights reserved.
//

import Foundation
import UIKit
class App {
    var trackName: String
    var sellerName: String
    var artworkUrl512: String
    var appImage: UIImage?
    var wrapperType: String
    var primaryGenreName: String
    var formattedPrice: String
    
    init(trackName: String, sellerName: String,artworkUrl512: String, wrapperType: String, primaryGenreName: String, formattedPrice: String){
        self.trackName = trackName
        self.sellerName = sellerName
        self.artworkUrl512 = artworkUrl512
        self.wrapperType = wrapperType
        self.primaryGenreName = primaryGenreName
        self.formattedPrice = formattedPrice
    }
    
}
