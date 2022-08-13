//
//  ViewController.swift
//  BeerMag
//
//  Created by Sonata Girl on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {

    let minusButton1  = UIButton()
    let minusButton2  = UIButton()
    let minusButton3  = UIButton()
  
    let plusButton1 = UIButton()
    let plusButton2 = UIButton()
    let plusButton3 = UIButton()
    
    let titleBeer1Top = UILabel()
    let titleBeer2Top = UILabel()
    let titleBeer3Top = UILabel()
    
    let titleBeer1Count = UILabel()
    let titleBeer2Count = UILabel()
    let titleBeer3Count = UILabel()
    
    let mainLabel = UILabel()
    let countLabel = UILabel()
    let sellButton = UIButton()
    let startButton = UIButton()
    let endButton = UIButton()
    
    var bar = Bar()
    var order = [Beer: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Manager.shared.startNewDay(bar: bar)
        
        view.backgroundColor = #colorLiteral(red: 0.9984562993, green: 0.9787891507, blue: 0.9253073335, alpha: 1)
        
//        var labelYStep = 50
//        var countYStep = 90
//
//        let labels = [titleBeer1Top, titleBeer2Top, titleBeer3Top]
//        let countlabels = [titleBeer1Count, titleBeer2Count, titleBeer3Count]
//        let minusButtons = [minusButton1, minusButton2, minusButton3]
//        let plusButtons = [plusButton1, plusButton2, plusButton3]
//
//        for (index, element) in bar.beers.enumerated() {
//            setLabel(label: labels[index], text: element.name, x: 100, y: labelYStep, w: 200, textCenter: true)
//            setLabel(label: countlabels[index], text: "0", x: 190, y: countYStep)
//            setButton(button: minusButtons[index], titleName: "-", x: 125, y: countYStep)
//            setButton(button: plusButtons[index], titleName: "+", x: 230, y: countYStep)
//
//            labelYStep += 80
//            countYStep += 80
//
//        }
        let fontlabelsButtons = UIFont.systemFont(ofSize: 30)
        setLabel(label: titleBeer1Top, text: getNameBeer(bar: bar, index: 0), x: 50, y: 50, w: 300, font: fontlabelsButtons, textCenter: true, textColor: .systemRed)
        setLabel(label: titleBeer1Count, text: "0", x: 170, y: 90, w: 70, textCenter: true)
        setButton(button: plusButton1, titleName: "+", x: 235, y: 90)
        setButton(button: minusButton1, titleName: "-", x: 120, y: 90)
        
        setLabel(label: titleBeer2Top, text: getNameBeer(bar: bar, index: 1), x: 50, y: 130, w: 300, font: fontlabelsButtons, textCenter: true, textColor: .systemRed)
        setLabel(label: titleBeer2Count, text: "0", x: 170, y: 170, w: 70, textCenter: true)
        setButton(button: plusButton2, titleName: "+", x: 235, y: 170)
        setButton(button: minusButton2, titleName: "-", x: 120, y: 170)
        
        setLabel(label: titleBeer3Top, text: getNameBeer(bar: bar, index: 2), x: 50, y: 210, w: 300, font: fontlabelsButtons, textCenter: true, textColor: .systemRed)
        setLabel(label: titleBeer3Count, text: "0", x: 170, y: 250, w: 70, textCenter: true)
        setButton(button: plusButton3, titleName: "+", x: 235, y: 250)
        setButton(button: minusButton3, titleName: "-", x: 120, y: 250)
        
        setLabel(label: mainLabel, text: "Label", x: 50, y: 500, w: 300, h: 150, font: UIFont.systemFont(ofSize: 25))
        
        setButton(button: sellButton, titleName: "Sell", x: 50, y: 640, w: 300,backColor: true)
        setButton(button: startButton, titleName: "Start day", x: 50, y: 700, w: 300,backColor: true)
        setButton(button: endButton, titleName: "End day", x: 50, y: 760, w: 300,backColor: true)
        
        minusButton1.tag = 0
        minusButton1.addTarget(self, action: #selector(minus), for: .touchUpInside)
        minusButton2.tag = 1
        minusButton2.addTarget(self, action: #selector(minus), for: .touchUpInside)
        minusButton3.tag = 2
        minusButton3.addTarget(self, action: #selector(minus), for: .touchUpInside)
        
        plusButton1.tag = 0
        plusButton1.addTarget(self, action: #selector(plus), for: .touchUpInside)
        plusButton2.tag = 1
        plusButton2.addTarget(self, action: #selector(plus), for: .touchUpInside)
        plusButton3.tag = 2
        plusButton3.addTarget(self, action: #selector(plus), for: .touchUpInside)
      
        startButton.addTarget(self, action: #selector(startDay), for: .touchUpInside)
        endButton.addTarget(self, action: #selector(endDay), for: .touchUpInside)
      
        sellButton.addTarget(self, action: #selector(sell), for: .touchUpInside)
    }

    
    func setButton(button: UIButton, titleName: String, x: Int, y: Int, w: Int = 50 , h: Int = 50, font: UIFont = UIFont.systemFont(ofSize: 35), center: Bool = false, backColor: Bool = false) {
        button.setTitle(titleName, for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        button.frame = CGRect(x: x, y: y, width: w, height: h)
        button.titleLabel?.font = font
        button.setTitleColor(.gray, for: .highlighted)
        if backColor {
            button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        if center {
            button.center = view.center
        }
        
        self.view.addSubview(button)
    }
    
    func changeName(label: UILabel, text: String) {
        label.text = text
    }

    func setLabel(label: UILabel, text: String, x: Int, y: Int, w: Int = 60 , h: Int = 50, font: UIFont = UIFont.systemFont(ofSize: 40), center: Bool = false, textCenter: Bool = false, textColor: UIColor = .black) {
        
        label.text = text
        label.textColor = textColor
        label.frame = CGRect(x: x, y: y, width: w, height: h)
        label.font = font
        label.numberOfLines = 0
        if center {
            label.center = view.center
        }
        if textCenter {
            label.textAlignment = .center
        }

        self.view.addSubview(label)
    }

    
    @IBAction func plus(sender: UIButton) {
        let changeName = Manager.shared.plus(bar: bar, index: sender.tag, order: &order)
        if changeName {
                changeNames(indexBeer: sender.tag)
        }
    }
    @IBAction func minus(sender: UIButton) {
        let changeName = Manager.shared.minus(bar: bar, index: sender.tag, order: &order)
//        let remainder = bar.countBeer(beer: bar.beers[sender.tag])
//        let orderCount = order[bar.beers[sender.tag]] ?? 0
//
//        if orderCount > 0 {
//             order[bar.beers[sender.tag]] = orderCount - 1
//            bar.counts[sender.tag] = remainder + 1
        if changeName {
            changeNames(indexBeer: sender.tag)
        }
    }
    
    func changeNames(indexBeer: Int) {
        let textTitle = getNameBeer(bar: bar, index: indexBeer)
        let newOrderCount = "\(order[bar.beers[indexBeer]] ?? 0)"
        
        if indexBeer == 0 {
            changeName(label: titleBeer1Top, text: textTitle)
            changeName(label: titleBeer1Count, text: newOrderCount)
        } else if indexBeer == 1 {
            changeName(label: titleBeer2Top, text: textTitle)
            changeName(label: titleBeer2Count, text: newOrderCount)
        } else {
            changeName(label: titleBeer3Top, text: textTitle)
            changeName(label: titleBeer3Count, text: newOrderCount)
        }
    }
    
    @IBAction func startDay(sender: UIButton) {
        Manager.shared.startNewDay(bar: bar)
        updatingScreen()
    }
    
    @IBAction func endDay(sender: UIButton) {
        mainLabel.text = "Total : \(bar.dailyTotal)"
        Manager.shared.startNewDay(bar: bar)
        updatingScreen()
    }
    
    @IBAction func sell(sender: UIButton) {
        mainLabel.text = Manager.shared.reduceCountBeer(bar: bar, beersSells: order)
        updatingScreen(updateAll: false)
    }
    
    func updatingScreen(updateAll: Bool = true) {
        for i in 0..<3 {
            let textTitle = getNameBeer(bar: bar, index: i)
            let orderCount = "\(0)"
            order[bar.beers[i]] = 0
            
            if i == 0 {
                if updateAll {
                    changeName(label: titleBeer1Top, text: textTitle)
                }
                changeName(label: titleBeer1Count, text: orderCount)
            } else if i == 1 {
                if updateAll {
                    changeName(label: titleBeer2Top, text: textTitle)
                }
                changeName(label: titleBeer2Count, text: orderCount)
            } else {
                if updateAll {
                    changeName(label: titleBeer3Top, text: textTitle)
                }
                changeName(label: titleBeer3Count, text: orderCount)
            }
        }
    }
    
    func getNameBeer(bar: Bar, index:Int) -> String {
        return "\(bar.beers[index].name) \(bar.counts[index]), \(bar.beers[index].cost)$"
    }
}

