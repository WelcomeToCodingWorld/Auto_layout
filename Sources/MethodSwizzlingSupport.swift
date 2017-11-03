//
//  Util.swift
//  Auto_Layout
//
//  Created by zz on 27/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

protocol SelfAware: class {
    static func awake()
    static func swizzleMethod(originalSelector:Selector,swizzledSelector:Selector)
}

extension SelfAware where Self: UIView {
    static func swizzleMethod(originalSelector:Selector,swizzledSelector:Selector) {
        var anyClass : AnyClass
        
        if self is UILabel.Type {
            anyClass = UILabel.self
        }else {
            anyClass = UIView.self
        }
        let originalMethod = class_getInstanceMethod(anyClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(anyClass, swizzledSelector)

        var didAddMethod = false
        if let swizzledMethod = swizzledMethod {
            didAddMethod = class_addMethod(anyClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        }

        if didAddMethod {
            if let originMethod = originalMethod {
                class_replaceMethod(anyClass, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod))
            }
        }else {
            if let originMethod = originalMethod,let swizzledMethod = swizzledMethod {
                method_exchangeImplementations(originMethod, swizzledMethod)
            }else {
                printLog("self:\(self)--Method:[\(originalMethod as Optional),\(swizzledMethod as Optional)]")
            }
        }
    }
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let safeTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(safeTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate(capacity: typeCount)
    }
    
}


extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}


