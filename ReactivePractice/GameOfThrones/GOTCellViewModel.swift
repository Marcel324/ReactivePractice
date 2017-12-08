//
//  GOTCellViewModel.swift
//  ReactivePractice
//
//  Created by Marcel Chaucer on 12/6/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

struct GOTCellViewModel {

    private let house: House!
    
    var houseName: String {
        return self.house.name
    }
    
    var houseRegion: String {
        return self.house.region
    }
    
    init(house: House) {
        self.house = house
    }
    
    
}
