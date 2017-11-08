//
//  UIButton+ZYExtension.swift
//  UniteRouteTechnician
//
//  Created by zz on 29/09/2017.
//  Copyright © 2017 Lesta. All rights reserved.
//

import UIKit
extension UIButton {
    class func button(title: String,textAttributes:[Any]?) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        if let attributes = textAttributes{
            for attribute in attributes {
                switch attribute {
                case is UIFont:
                    btn.titleLabel?.font = attribute as? UIFont
                case is UIColor:
                    btn.setTitleColor(attribute as? UIColor, for: .normal)
                default:
                    break
                }
            }
        }
        return btn
    }
    
}
