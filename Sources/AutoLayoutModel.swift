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

class AutoLayoutModel:NSObject {
    struct AutoLayoutModelItem {
        var value:CGFloat = 0
        var refView:UIView?
        var refViewArray:[UIView]?
        var offset:CGFloat = 0
    }
    
    var needAutoResizeView : UIView?
    
    var width : AutoLayoutModelItem?
    var height:AutoLayoutModelItem?
    var left:AutoLayoutModelItem?
    var right:AutoLayoutModelItem?
    var top:AutoLayoutModelItem?
    var bottom:AutoLayoutModelItem?
    var centerX:CGFloat = 0
    var centerY:CGFloat = 0
    
    var maxHeight:AutoLayoutModelItem?
    var maxWidth : AutoLayoutModelItem?
    var minHeight: AutoLayoutModelItem?
    var minWidth:AutoLayoutModelItem?
    
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
    
    @discardableResult
    func leftSpaceToView(view:AnyObject,value:CGFloat)->AutoLayoutModel{
        return self.spaceToView(for: "left")(view, value)
    }
    
    @discardableResult
    func rightSpaceToView(view:AnyObject,value:CGFloat)->AutoLayoutModel {
        return spaceToView(for: "right")(view, value)
    }
    
    @discardableResult
    func topSpaceToViw(view:AnyObject,value:CGFloat)->AutoLayoutModel {
        return spaceToView(for: "top")(view, value)
    }
    
    @discardableResult
    func bottomSpaceToViw(view:AnyObject,value:CGFloat)->AutoLayoutModel {
        return spaceToView(for: "bottom")(view, value)
    }
    
    @discardableResult
    func xIs(value:CGFloat)->AutoLayoutModel {
        return equal(for: "x")(value)
    }
    
    @discardableResult
    func yIs(value:CGFloat)->AutoLayoutModel {
        return equal(for: "y")(value)
    }
    
    @discardableResult
    func centerXIs(value:CGFloat)->AutoLayoutModel {
        return equal(for: "centerX")(value)
    }
    
    @discardableResult
    func centerYIs(value:CGFloat)->AutoLayoutModel {
        return equal(for: "centerY")(value)
    }
    
    @discardableResult
    func heightIs(value:CGFloat)->AutoLayoutModel {
        var item = AutoLayoutModelItem()
        item.value = value
        self.height = item
        return self
    }
    
    @discardableResult
    func widthIs(value:CGFloat)->AutoLayoutModel {
        var item = AutoLayoutModelItem()
        item.value = value
        self.width = item
        return self
    }
    
    @discardableResult
    func maxHeightIs(value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "maxHeight")(value)
    }
    
    @discardableResult
    func maxWidthIs(value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "maxWidth")(value)
    }
    
    @discardableResult
    func minHeightIs(value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "minHeight")(value)
    }
    
    @discardableResult
    func minWidthIs(value:CGFloat)->AutoLayoutModel {
        return limitWH(for: "minWidth")(value)
    }
    
    @discardableResult
    func leftEqualToView(view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_left")(view)
    }
    
    @discardableResult
    func rightEqualToView(view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_right")(view)
    }
    
    @discardableResult
    func topEqualToView(view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_top")(view)
    }
    
    @discardableResult
    func bottomEqualToView(view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_bottom")(view)
    }
    
    @discardableResult
    func centerXEqualToView(view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_centerX")(view)
    }
    
    @discardableResult
    func centerYEqualToView(view:UIView)->AutoLayoutModel {
        return equalToView(for: "equal_centerY")(view)
    }
    
    @discardableResult
    func widthRatioToView(view:UIView,value:CGFloat)->AutoLayoutModel {
        self.ratio_width = AutoLayoutModelItem()
        self.ratio_width?.refView = view
        self.ratio_width?.value = value
        return self
    }
    
    @discardableResult
    func heightRatioToView(view:UIView,value:CGFloat)->AutoLayoutModel {
        self.ratio_height = AutoLayoutModelItem()
        self.ratio_height?.refView = view
        self.ratio_height?.value = value
        return self
    }
    
    @discardableResult
    func widthEqualToHeight()->AutoLayoutModel {
        let item = AutoLayoutModelItem()
        self.equal_wh = item
        self.lastModelItem = item
        // TODO:explicitly change the height of the needAutoResizeView
        
        return self
    }
    
    @discardableResult
    func heightEqualToWidth()->AutoLayoutModel {
        let item = AutoLayoutModelItem()
        self.equal_hw = item
        self.lastModelItem = item
        // TODO:explicitly change the width of the needAutoResizeView
        
        return self
    }
    
    @discardableResult
    func autoHeightRatio(value:CGFloat)->AutoLayoutModel {
        // TODO:explicitly change the autoHeightRatioValue of the needAutoResizeView
        
        return self
    }
    
    @discardableResult
    func spaceToSuperView(insets:UIEdgeInsets)->AutoLayoutModel {
        // TODO:layout the autoHeightRatioValue of the needAutoResizeView if it's superview is exist
        return self
    }
    
    @discardableResult
    func offset(offset:CGFloat)->AutoLayoutModel {
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
            self?.setValue(item, forKey: key)
            return self!
        }
    }
    
    private func equalToView(for key:String)->EqualToView{
        return {[weak self] (view:UIView) in
            var item = AutoLayoutModelItem()
            item.refView = view
            self?.setValue(item, forKey: key)
            self?.lastModelItem = item
            // TODO: handle tableView
            
            return self!
        }
    }
    
    
    private func limitWH(for key:String)->Is {
        return {[weak self] (value:CGFloat) in
            self?.setValue(value, forKey: key)
            return self!
        }
    }
    
    
    private func equal(for key:String)->Is {
        return {[weak self] (value:CGFloat) in
            if key == "x" {// TODO: change the x of  the needAutoResizeView's frame
                
            }else if key == "y" {
                
            }else if key == "centerX" {
                self?.centerX = value
            }else if key == "centerY" {
                self?.centerY = value
            }
            return self!
        }
    }
}
