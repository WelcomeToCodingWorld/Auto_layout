//
//  AutoLayoutModel.swift
//  Auto_Layout
//
//  Created by zz on 27/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

typealias Is = (CGFloat)->AutoLayoutModel
typealias EqualToView = (UIView)->AutoLayoutModel
typealias SpaceToView = (AnyObject,CGFloat)->AutoLayoutModel
typealias RatioToView = (UIView,CGFloat)->AutoLayoutModel
typealias WHEqual = ()->AutoLayoutModel
typealias SpaceToSuperView = (UIEdgeInsets)->AutoLayoutModel

public class AutoLayoutModel:NSObject {
    struct AutoLayoutModelItem {
        var value:CGFloat = 0
        var refView:UIView?
        var refViewArray:[UIView]?
        var offset:CGFloat = 0
    }
    
    weak var needAutoResizeView : UIView?
    
    
    var space_left:AutoLayoutModelItem?
    var space_right:AutoLayoutModelItem?
    var space_top:AutoLayoutModelItem?
    var space_bottom:AutoLayoutModelItem?
    
    var centerX:CGFloat?
    var centerY:CGFloat?
    
    var width : AutoLayoutModelItem?
    var height:AutoLayoutModelItem?
    
    var maxHeight:CGFloat?
    var maxWidth : CGFloat?
    var minHeight: CGFloat?
    var minWidth:CGFloat?
    
    var ratio_width:AutoLayoutModelItem?
    var ratio_height:AutoLayoutModelItem?
    var ratio_left:AutoLayoutModelItem?
    var ratio_right:AutoLayoutModelItem?
    var ratio_top:AutoLayoutModelItem?
    var ratio_bottom:AutoLayoutModelItem?
    
    var equal_left:AutoLayoutModelItem?
    var equal_right:AutoLayoutModelItem?
    var equal_top:AutoLayoutModelItem?
    var equal_bottom:AutoLayoutModelItem?
    var equal_centerX:AutoLayoutModelItem?
    var equal_centerY:AutoLayoutModelItem?
    
    var equal_wh:AutoLayoutModelItem?
    var equal_hw:AutoLayoutModelItem?
    
    var lastModelItem:AutoLayoutModelItem?
    
    subscript(index:String)->AutoLayoutModelItem? {
        get{
            switch index {
            case "space_left":return space_left
            case "space_right":return space_right
            case "space_top":return space_top
            case "space_bottom":return space_bottom
            
            case "equal_left":return equal_left
            case "equal_right":return equal_right
            case "equal_top":return equal_top
            case "equal_bottom":return equal_bottom
            case "equal_centerX":return equal_centerX
            case "equal_centerY":return equal_centerY
            default:
                return nil
            }
        }
        
        set{
            switch index {
            case "space_left": space_left = newValue
            case "space_right": space_right = newValue
            case "space_top": space_top = newValue
            case "space_bottom": space_bottom = newValue
                
            case "equal_left": equal_left = newValue
            case "equal_right": equal_right = newValue
            case "equal_top": equal_top = newValue
            case "equal_bottom": equal_bottom = newValue
            case "equal_centerX": equal_centerX = newValue
            case "equal_centerY": equal_centerY = newValue
            default:
                break
            }
        }
        
        
    }
    
    subscript(index:String) -> CGFloat? {
        get{
            switch index {
            case "maxHeight":return maxHeight
            case "maxWidth":return maxWidth
            case "minHeight":return minHeight
            case "minWidth":return minWidth
            default:
                return nil
            }
        }
        
        set{
            switch index {
            case "maxHeight": maxHeight = newValue
            case "maxWidth": maxWidth = newValue
            case "minHeight": minHeight = newValue
            case "minWidth": minWidth = newValue
            default:
                break
            }
        }
    }
    
    @discardableResult
    public func leftSpaceToView(_ view:AnyObject,_ value:CGFloat)->AutoLayoutModel{
        return self.spaceToView(for: "space_left")(view, value)
    }
    
    @discardableResult
    public func rightSpaceToView(_ view:AnyObject,_ value:CGFloat)->AutoLayoutModel {
        return spaceToView(for: "space_right")(view, value)
    }
    
    @discardableResult
    public func topSpaceToView(_ view:AnyObject,_ value:CGFloat)->AutoLayoutModel {
        return spaceToView(for: "space_top")(view, value)
    }
    
    @discardableResult
    public func bottomSpaceToViw(_ view:AnyObject,_ value:CGFloat)->AutoLayoutModel {
        return spaceToView(for: "space_bottom")(view, value)
    }
    
    @discardableResult
    public func xIs(_ value:CGFloat)->AutoLayoutModel {
        return equal(for: "x")(value)
    }
    
    @discardableResult
    public func yIs(_  value:CGFloat)->AutoLayoutModel {
        return equal(for: "y")(value)
    }
    
    @discardableResult
    public func centerXIs(_ value:CGFloat)->AutoLayoutModel {
        return equal(for: "centerX")(value)
    }
    
    @discardableResult
    public func centerYIs(_ value:CGFloat)->AutoLayoutModel {
        return equal(for: "centerY")(value)
    }
    
    @discardableResult
    public func heightIs(_ value:CGFloat)->AutoLayoutModel {
        var item = AutoLayoutModelItem()
        item.value = value
        self.height = item
        return self
    }
    
    @discardableResult
    public func widthIs(_ value:CGFloat)->AutoLayoutModel {
        var item = AutoLayoutModelItem()
        item.value = value
        self.width = item
        return self
    }
    
    @discardableResult
    public func maxHeightIs(_ value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "maxHeight")(value)
    }
    
    @discardableResult
    public func maxWidthIs(_ value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "maxWidth")(value)
    }
    
    @discardableResult
    public func minHeightIs(_ value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "minHeight")(value)
    }
    
    @discardableResult
    public func minWidthIs(_ value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "minWidth")(value)
    }
    
    @discardableResult
    public func leftEqualToView(_ view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_left")(view)
    }
    
    @discardableResult
    public func rightEqualToView(_ view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_right")(view)
    }
    
    @discardableResult
    public func topEqualToView(_ view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_top")(view)
    }
    
    @discardableResult
    public func bottomEqualToView(_ view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_bottom")(view)
    }
    
    @discardableResult
    public func centerXEqualToView(_ view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_centerX")(view)
    }
    
    @discardableResult
    public func centerYEqualToView(_ view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_centerY")(view)
    }
    
    @discardableResult
    public func widthRatioToView(_ view:UIView,_ value:CGFloat)->AutoLayoutModel {
        self.ratio_width = AutoLayoutModelItem()
        self.ratio_width?.refView = view
        self.ratio_width?.value = value
        return self
    }
    
    @discardableResult
    public func heightRatioToView(_ view:UIView,_ value:CGFloat)->AutoLayoutModel {
        self.ratio_height = AutoLayoutModelItem()
        self.ratio_height?.refView = view
        self.ratio_height?.value = value
        return self
    }
    
    @discardableResult
    public func widthEqualToHeight()->AutoLayoutModel {
        let item = AutoLayoutModelItem()
        self.equal_wh = item
        self.lastModelItem = item
        needAutoResizeView?.height_al = (needAutoResizeView?.height_al)!
        return self
    }
    
    @discardableResult
    public func heightEqualToWidth()->AutoLayoutModel {
        let item = AutoLayoutModelItem()
        self.equal_hw = item
        self.lastModelItem = item
        needAutoResizeView?.width_al = (needAutoResizeView?.width_al)!
        return self
    }
    
    @discardableResult
    public func autoHeightRatio(value:CGFloat)->AutoLayoutModel {
        needAutoResizeView?.autoHeightRatioValue = value
        return self
    }
    
    @discardableResult
    public func spaceToSuperView(insets:UIEdgeInsets)->AutoLayoutModel {
        if let superView = needAutoResizeView?.superview {
            needAutoResizeView?.al_layout().leftSpaceToView(superView, insets.left).rightSpaceToView(superView, insets.right).topSpaceToView(superView, insets.top).bottomSpaceToViw(superView, insets.bottom)
        }
        return self
    }
    
    @discardableResult
    public func offset(offset:CGFloat)->AutoLayoutModel {
        self.lastModelItem?.offset = offset
        return self
    }
}

extension AutoLayoutModel {
    private func spaceToView(for key:String)->SpaceToView {
        return {[weak self] (view:AnyObject,value:CGFloat) in
            var item = AutoLayoutModelItem()
            item.value = value
            if view is UIView {
                item.refView = view as? UIView
            }else if view is [UIView] {
                item.refViewArray = view as? [UIView]
            }
            self?[key] = item
            return self!
        }
    }
    
    private func equalToView(for key:String)->EqualToView{
        return {[weak self] (view:UIView) in
            var item = AutoLayoutModelItem()
            item.refView = view
            self?[key] = item
            self?.lastModelItem = item
            // TODO: handle tableView
            
            return self!
        }
    }
    
    
    private func limitWH(for key:String)->Is {
        return {[weak self] (value:CGFloat) in
            self?[key] = value
            return self!
        }
    }
    
    
    private func equal(for key:String)->Is {
        return {[weak self] (value:CGFloat) in
            if key == "x" {
                self?.needAutoResizeView?.left = value
            }else if key == "y" {
                self?.needAutoResizeView?.top = value
            }else if key == "centerX" {
                self?.centerX = value
            }else if key == "centerY" {
                self?.centerY = value
            }
            return self!
        }
    }
}
