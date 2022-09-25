//
//  ContainerVC.swift
//  BeerMag
//
//  Created by Sonata Girl on 15.09.2022.
//

import UIKit

class ContainerVC: UIViewController, ViewControllerDelegate {
    
    private var controller: UIViewController!
    private var menuViewController: UIViewController!
    private var isMove = false
    private var blurView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMainVC()
    }

    
    private func configureMainVC() {
        let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        mainController.delegate = self
        controller = mainController
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    private func configureMenuVC() {
        if menuViewController == nil {
            menuViewController = MenuVC()

            if let controllerVC = menuViewController as? MenuVC {
                controllerVC.delegate = controller as? ViewController
            }
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            print("add menuVC")
        }
    }
    
    func showMenuViewController(shouldMove: Bool) {
//        if shouldMove {
            // показываем меню
            self.menuViewController.view.frame.origin.x = -self.menuViewController.view.frame.width
            self.view.bringSubviewToFront(menuViewController.view)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                // делаем чтобы вью контроллер уехал вправо
                
                self.menuViewController.view.frame.origin.x += self.menuViewController.view.frame.width/2
            } completion: { (finished) in
                
            }

//        } else {
//            //  убираем меню
//            UIView.animate(withDuration: 0.5,
//                           delay: 0,
//                           usingSpringWithDamping: 0.8,
//                           initialSpringVelocity: 0,
//                           options: .curveEaseInOut) {
//
//                self.menuViewController.view.frame.origin.x = -self.menuViewController.view.frame.width
//            } completion: { (finished) in
//                self.view.sendSubviewToBack(self.menuViewController.view)
//            }
//        }
    }
    
//    func
    
    
    // MARK: ViewControllerDelegate
    
    func toggleMenu() {
        configureMenuVC()
        isMove = !isMove
        showMenuViewController(shouldMove: isMove)
    }

}
