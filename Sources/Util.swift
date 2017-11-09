//
//  Util.swift
//  FileManagerDemo
//
//  Created by zz on 25/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import Foundation
import UIKit
func printLog<T>(_ message:T,file:String = #file,method:String = #function,line:Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}


func local(_ closure:()->()) {
    closure()
}

typealias Task = (_ cancel:Bool) -> Void

@discardableResult
func delay(_ time:TimeInterval,task:@escaping ()->()) -> Task? {
    var closure:(()->Void)? = task
    var result : Task?
    
    let t = DispatchTime.now() + time
    
    func dispatch_later(block:@escaping ()->()){
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    let delayedClosure:Task = {
        cancel in
        if let internalClosure = closure {
            if cancel == false {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        //task unfinished
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

func cancel(_ task:Task?)  {
    task?(true)
}

func printSubViews(of view:UIView,level:UInt){
    let subViews = view.subviews
    if subViews.isEmpty {
        return
    }
    
    for subview in subViews {
        var holder = ""
        for _ in 1..<level {
            holder += "\t"
        }
        #if DEBUG
        print(String.init(format: "\(holder)%d:\(subview.self)", level))
        #endif
        printSubViews(of: subview, level: level + 1)
    }
}

//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

public extension UIColor {
    static func colorFromRGB(rgbValue hexRgbValue:Int)-> UIColor {
        return UIColor.init(red: CGFloat(Float((hexRgbValue&0xFF0000) >> 16))/255.0, green: CGFloat((hexRgbValue&0xFF00) >> 8)/255.0, blue: CGFloat(hexRgbValue&0xFF)/255.0 , alpha: 1.0)
    }
}

