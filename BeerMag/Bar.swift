//
//  daylyBar.swift
//  BeerMag
//
//  Created by Sonata Girl on 13.08.2022.
//

import Foundation

class Bar {
    
    var beers = [Beer]()
    var counts = [Int]()
    
    var dailyTotal: Int = 0
    
    init() {
        let beer1 = Beer(cost: 5, name: "Heineken")
        let beer2 = Beer(cost: 3, name: "Bud")
        let beer3 = Beer(cost: 4, name: "Ochakovo")
        
        beers.append(beer1)
        beers.append(beer2)
        beers.append(beer3)
        
        counts.append(100)
        counts.append(100)
        counts.append(100)
    
    }
    
    func countBeer(beer : Beer) -> Int {
        return counts[beers.firstIndex(of: beer) ?? 0]
    }
}
