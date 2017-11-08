//
//  UIView+ChangeFrame.swift
//  Auto_Layout
//
//  Created by zz on 27/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

extension UIView {
    var left:CGFloat {
        get{
            return self.frame.origin.x
        }
        
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var right:CGFloat {
        get{
            return left + width
        }
        
        set{
            left = newValue - width
        }
    }
    
    var top:CGFloat {
        get{
            return self.frame.origin.y
        }
        
        set{
            self.frame.origin.y = newValue
        }
    }
    
    var bottom:CGFloat {
        get{
            return top + height
        }
        
        set{
            top = newValue - height
        }
    }
    
    var centerX:CGFloat {
        get{
            return left + width/2
        }
        
        set{
            self.center.x = newValue
        }
    }
    
    var centerY:CGFloat {
        get{
            return top + height/2
        }
        
        set{
            self.center.y = newValue
        }
    }
    
    var width:CGFloat {
        get{
            return self.bounds.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    
    var height:CGFloat {
        get{
            return self.bounds.size.height
        }
        set{
            self.frame.size.height = newValue
        }
    }
    
    var origin:CGPoint  {
        get{
            return self.frame.origin
        }
        
        set{
            self.frame.origin = origin
        }
    }
    
    var size:CGSize {
        get{
            return CGSize(width: width, height: height)
        }
        set{
            self.frame.size = newValue
        }
    }
    
    var width_al : CGFloat {
        get{
            return width
        }
        
        set{
            if self.ownLayoutModel?.equal_wh != nil {
                if newValue != height_al {
                    return
                }
            }
            
            width = newValue
            if self.ownLayoutModel?.equal_hw != nil {
                self.height_al = newValue
            }
        }
    }
    
    var height_al : CGFloat {
        get{
            return height
        }
        
        set{
            if self.ownLayoutModel?.equal_hw != nil {
                if newValue != width_al {
                    return
                }
            }
            height = newValue
            if self.ownLayoutModel?.equal_wh != nil {
                self.width_al = newValue
            }
        }
    }
    
}
