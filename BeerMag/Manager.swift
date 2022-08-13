//
//  Manager.swift
//  BeerMag
//
//  Created by Sonata Girl on 13.08.2022.
//

import Foundation

class Manager {
    
    static let shared = Manager()
    
    private init(){}
    
    func plus(bar:Bar, index: Int, order : inout [Beer: Int]) -> Bool {
        let remainder = bar.countBeer(beer: bar.beers[index])
        
        if remainder > 0 {
            let orderCount = order[bar.beers[index]] ?? 0
            order[bar.beers[index]] = orderCount + 1
            bar.counts[index] = remainder - 1
            return true
        }
        
        return false
    }
    
    func minus(bar:Bar, index: Int, order : inout [Beer: Int]) -> Bool {
        let remainder = bar.countBeer(beer: bar.beers[index])
        let orderCount = order[bar.beers[index]] ?? 0
       
        if orderCount > 0 {
            order[bar.beers[index]] = orderCount - 1
            bar.counts[index] = remainder + 1
            
            return true
        }
       
        return false
    }
    
    func startNewDay(bar: Bar) {
        bar.dailyTotal = 0
        for beer in bar.beers {
            let indexBeer = bar.beers.firstIndex(of: beer) ?? 0
            bar.counts[indexBeer] = 100
        }
    }
        
    func reduceCountBeer(bar: Bar, beersSells: [Beer: Int]) -> String {
        var textSelling = ""
        var sumCost = 0
        for beer in beersSells.keys {

            let sellCount = beersSells[beer]!

            sumCost += sellCount * beer.cost
            bar.dailyTotal += sumCost
           
            let text = "\(sellCount) * \(beer.cost)$ - \(beer.name)"
            if sellCount > 0 {
                textSelling += textSelling == "" ? text + "\n" : text + "\n"
            }
        }
        textSelling += "Total : \(sumCost)$"
        return textSelling
    }
}
