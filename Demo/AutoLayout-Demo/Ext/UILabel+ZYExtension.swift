//
//  UILabel+ZYExtension.swift
//  UniteRouteTechnician
//
//  Created by zz on 28/09/2017.
//  Copyright © 2017 Lesta. All rights reserved.
//
import UIKit
extension UILabel {
    class func label(text:String?, textAttributes:[AnyObject],alignment:NSTextAlignment? = nil,bgColor:UIColor? = nil) -> UILabel{
        let label = UILabel.init()
        if let title = text {
            label.text = title
        }
        
        if let alignment = alignment {
            label.textAlignment = alignment
        }
        
        if let bgColor = bgColor {
            label.backgroundColor = bgColor
        }

        for object in textAttributes {
            if let color = object as? UIColor {
                label.textColor = color
            }else if let font = object as? UIFont {
                label.font = font
            }
        }
        return label
    }
}
