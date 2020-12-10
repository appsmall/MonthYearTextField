//
//  DesignableView.swift
//  MonthYearTextField_Example
//
//  Created by Rahul Chopra on 10/12/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignableView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateValue()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateValue()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            updateValue()
        }
    }
    
    func updateValue() {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}
