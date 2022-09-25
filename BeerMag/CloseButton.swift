//
//  CloseButton.swift
//  TMS_DZ6
//
//  Created by Sonata Girl on 22.08.2022.
//

import UIKit

class CloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        titleLabel?.textColor = .white
        setTitle("X", for: .normal)
        backgroundColor = .black
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
