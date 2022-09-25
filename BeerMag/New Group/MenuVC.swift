//
//  MenuVC.swift
//  BeerMag
//
//  Created by Sonata Girl on 15.09.2022.
//

import UIKit
    
protocol MenuVCDelegate: AnyObject {
    func changeColor(color: UIColor?)
}

class MenuVC: UIViewController {
    
    private var closeButton = CloseButton()
    private var colorButtons: [UIButton] = []
    weak var delegate: MenuVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let buttonCount = 30
        
        for i in 1...buttonCount {
            let button = newButton()
            self.view.addSubview(button)
        
            button.addTarget(self, action: #selector(buttonSideBarAction), for: .touchUpInside)
            
            var topConstrain : NSLayoutConstraint
            if i == 1 {
                topConstrain = button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
            } else {
                let prevButton = colorButtons[i-2]
                topConstrain = button.topAnchor.constraint(equalTo: prevButton.bottomAnchor, constant: 10)
            }
            NSLayoutConstraint.activate([
                topConstrain,
                button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
//                button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
                button.heightAnchor.constraint(equalToConstant: 15), // высота
                button.widthAnchor.constraint(equalToConstant: 100)
            ])
            colorButtons.append(button)
            
        }
        
        self.view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 20), // высота
            closeButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
      
    }
    
    func newButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = randomColor()

        return button
    }
                                                      
        func randomColor() -> UIColor{
            func random() -> CGFloat{ return.random(in:0...1) }
            return UIColor(red:   random(),
                          green: random(),
                          blue:  random(),
                          alpha: 1.0)
        }
                                                      
    @objc func closeButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) {
            // делаем чтобы вью контроллер уехал вправо
            
            self.view.frame.origin.x = -self.view.frame.width
        } completion: { (finished) in
            self.delegate?.changeColor(color: nil)
        }
    }

    @objc func buttonSideBarAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) {
            // делаем чтобы вью контроллер уехал вправо
            
            self.view.frame.origin.x = -self.view.frame.width
        } completion: { (finished) in
            
          self.delegate?.changeColor(color: sender.backgroundColor ?? self.randomColor())
        }
        
    }
    

}
