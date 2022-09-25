//
//  ViewController.swift
//  BeerMag
//
//  Created by Sonata Girl on 13.08.2022.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func toggleMenu()
}

class ViewController: UIViewController, MenuVCDelegate {
    
    weak var delegate: ViewControllerDelegate?
    var blurView = UIVisualEffectView()
     
    private let menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.titleLabel?.backgroundColor = .orange

       return button
    }()
    
    let minusButton1  = UIButton()
    let minusButton2  = UIButton()
    let minusButton3  = UIButton()
  
//    let labelsArray : [UILabel]! = [UILabel()
    
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
        
        setupUI()
        
        let blurEffect = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.isHidden = true
        view.addSubview(blurView)
        
        self.view.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            menuButton.heightAnchor.constraint(equalToConstant: 40), // высота
            menuButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)

    }
    
   
    
    func setupUI() {
        Manager.shared.startNewDay(bar: bar)
        
        view.backgroundColor = #colorLiteral(red: 0.9984562993, green: 0.9787891507, blue: 0.9253073335, alpha: 1)
        

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
            updateNames(index: sender.tag, updateTitles: true)
        }
    }
    @IBAction func minus(sender: UIButton) {
        let changeName = Manager.shared.minus(bar: bar, index: sender.tag, order: &order)
        if changeName {
            updateNames(index: sender.tag, updateTitles: true)
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
        order = [Beer: Int]()
        updatingScreen(updateAll: false)
    }

    
    func updateNames(index: Int, updateTitles: Bool) {
        let orderText = "\(order[bar.beers[index]] ?? 0)"
        let textTitle = getNameBeer(bar: bar, index: index)
        if index == 0 {
            if updateTitles {
                changeName(label: titleBeer1Top, text: textTitle)
            }
            changeName(label: titleBeer1Count, text: orderText)
        } else if index == 1 {
            if updateTitles {
                changeName(label: titleBeer2Top, text: textTitle)
            }
            changeName(label: titleBeer2Count, text: orderText)
        } else {
            if updateTitles {
                changeName(label: titleBeer3Top, text: textTitle)
            }
            changeName(label: titleBeer3Count, text: orderText)
        }
    }
    
    func updatingScreen(updateAll: Bool = true) {
        for i in 0..<3 {
            order[bar.beers[i]] = 0
            updateNames(index: i, updateTitles: updateAll)
        }
    }
    
    func getNameBeer(bar: Bar, index:Int) -> String {
        return "\(bar.beers[index].name) \(bar.counts[index]), \(bar.beers[index].cost)$"
    }
    
    
    @objc func menuButtonAction(_ sender: UIButton) {
        delegate?.toggleMenu()
        self.blurView.isHidden = false
    }
    
    func changeColor(color: UIColor? = nil) {
        self.blurView.isHidden = true
        guard let newColor = color else {return}
        
        self.view.backgroundColor = newColor
    }
}

