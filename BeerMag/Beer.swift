//
//  Beer.swift
//  BeerMag
//
//  Created by Sonata Girl on 13.08.2022.
//

import Foundation

class Beer: Hashable {

    static func == (lhs: Beer, rhs: Beer) -> Bool {
        return lhs.cost == rhs.cost && lhs.name == rhs.name
    }
        
    func hash(into hasher: inout Hasher) {
          hasher.combine(cost)
          hasher.combine(name)
    }
    
    var cost: Int
    var name: String
    
    init(cost: Int, name: String) {
        self.cost = cost
        self.name = name
        
    }
    
}
