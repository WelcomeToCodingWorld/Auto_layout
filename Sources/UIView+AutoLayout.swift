//
//  UIView+AutoLayout.swift
//  Auto_Layout
//
//  Created by zz on 27/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

extension UIView {
    var ownLayoutModel : AutoLayoutModel? {
        get {
           return (objc_getAssociatedObject(self, "ownLayoutModel.key") as? AutoLayoutModel)
        }
        
        set{
            objc_setAssociatedObject(self, "ownLayoutModel.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var autoLaoutModels : [AutoLayoutModel] {
        get {
            if  (objc_getAssociatedObject(self, "autoLaoutModels.key") as? [AutoLayoutModel]) == nil {
                objc_setAssociatedObject(self, "autoLaoutModels.key", [AutoLayoutModel](), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return (objc_getAssociatedObject(self, "autoLaoutModels.key") as? [AutoLayoutModel])!
        }
    }
    
    var fixedWidth : CGFloat? {
        get{
            return objc_getAssociatedObject(self, "fixedWidth.key") as? CGFloat
        }
        
        set{
            if let width = newValue {
                self.width_al = width
                objc_setAssociatedObject(self, "fixedWidth.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var fixedHeight : CGFloat? {
        get{
            return objc_getAssociatedObject(self, "fixedHeight.key") as? CGFloat
        }
        
        set{
            if let height = newValue {
                self.height_al = height
            }
        }
    }
    
    var autoHeightRatioValue:CGFloat? {
        get{
            return objc_getAssociatedObject(self, "autoHeightRatioValue.key") as? CGFloat
        }
        
        set{
            objc_setAssociatedObject(self, "autoHeightRatioValue.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var maxWidth:CGFloat? {
        get{
            return objc_getAssociatedObject(self, "maxWidth.key") as?  CGFloat
        }
        
        set{
            objc_setAssociatedObject(self, "maxWidth.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func layout()->AutoLayoutModel {
        #if DEBUG
        assert(self.superview != nil, "call this method after the view\(self) has been added to a superview")
        #endif
        
        if let model = ownLayoutModel {
            return model
        }else {
            let model = AutoLayoutModel()
            model.needAutoResizeView = self
            ownLayoutModel = model
            return model
        }
    }
    
    
    func setupAutoHeight(with bottomView:UIView,bottomMaigin:CGFloat) {
        setupAutoHeight(with: [bottomView], bottomMargin: bottomMaigin)
    }
    
    func setupAutoWidth(with rightView:UIView,rightMargin:CGFloat) {
        
    }
    
    func setupAutoHeight(with bottomViewsArray:[UIView],bottomMargin:CGFloat) {
        
    }
    
    @objc func autoLayoutSubviews() {
        
    }
}




extension UIView:SelfAware {
    static func awake() {
        let originMethod = class_getInstanceMethod(self, #selector(layoutSubviews))
        let customMethod = class_getInstanceMethod(self, #selector(autoLayoutSubviews))
        method_exchangeImplementations(originMethod!, customMethod!)
    }
}


