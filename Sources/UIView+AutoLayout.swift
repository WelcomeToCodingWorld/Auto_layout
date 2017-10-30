//
//  UIView+AutoLayout.swift
//  Auto_Layout
//
//  Created by zz on 27/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

extension UIView {
    func al_layout()->AutoLayoutModel {
        #if DEBUG
            assert(self.superview != nil, "call this method after the view\(self) has been added to a superview")
        #endif
        
        if let model = ownLayoutModel {
            return model
        }else {
            let model = AutoLayoutModel()
            model.needAutoResizeView = self
            ownLayoutModel = model
            guard let sv = superview else{
                fatalError("cannot layout view:\(self) before been added to a superview")
            }
            sv.autoLaoutModels.append(model)
            return model
        }
    }
    
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
                self.autoLaoutModels = [AutoLayoutModel]()
            }
            return (objc_getAssociatedObject(self, "autoLaoutModels.key") as? [AutoLayoutModel])!
        }
        
        set{
            objc_setAssociatedObject(self, "autoLaoutModels.key", [AutoLayoutModel](), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func al_autoLayoutSubviews() {
        al_autoLayoutSubviews()
        al_layoutSubviewsHandle()
    }
    
    private func al_layoutSubviewsHandle() {
        // TODO: layout handle method
    }
}

// MARK: atuto widht,height
extension UIView {
    func setupAutoHeight(with bottomView:UIView,bottomMaigin:CGFloat) {
        setupAutoHeight(with: [bottomView], bottomMargin: bottomMaigin)
    }
    
    func setupAutoWidth(with rightView:UIView,rightMargin:CGFloat) {
        
    }
    
    func setupAutoHeight(with bottomViewsArray:[UIView],bottomMargin:CGFloat) {
        
    }
}

// MARK: AutoLayout handle
extension UIView {
    func layoutWidth(view:UIView,model:AutoLayoutModel) {
        if let width = model.width {
            view.width_al = width.value
            view.fixedWidth = view.width_al
        }else if let ratioWidth = model.ratio_width {
            view.width_al = (ratioWidth.refView?.width_al)!*ratioWidth.value
            view.fixedWidth = view.width_al
        }
    }
    
    func layoutAutoWidth(view:UIView,model:AutoLayoutModel) {
        guard view is UILabel else {
            return
        }
        if let label = (view as? UILabel) {
            let width = view.maxWidth ?? CGFloat(MAXFLOAT)
            label.numberOfLines = 1
            if let txt = label.text {
                if txt.characters.count > 0 {
                    if let attributed = label.isAttributedText {
                        if attributed {
//                            let rect
                            
                        }
                    }
                }
            }
            
            
            
        }
    }
    
    func layoutHeight(view:UIView,model:AutoLayoutModel) {
        if let height = model.height {
            view.height_al = height.value
            view.fixedHeight = view.height_al
        }else if let ratioHeight = model.ratio_height {
            view.height_al = (ratioHeight.refView?.height_al)!*ratioHeight.value
            view.fixedHeight = view.height_al
        }
    }
    
    func layoutLeft(view:UIView,model:AutoLayoutModel) {
        if let left = model.left {//space left
            guard  view == model.needAutoResizeView  else {//it's own model
                return
            }
            if left.refView?.superview == superview {//left relative to it's superview. as: view.superview'left + space = view.left
                if view.fixedWidth == nil {
                    view.width_al = view.right - left.value
                }
                view.left = left.value
            }else {//left releative to it's sibling view. as: view.siblingview'right + space = view.left
                if let leftViews = left.refViewArray {
                    if leftViews.count > 0 {
                        var lastRefRight:CGFloat = 0
                        for view in leftViews {
                            if view.right > lastRefRight {
                                model.left?.refView = view
                                lastRefRight = view.right
                            }
                        }
                    }
                }
                
                if view.fixedWidth == nil {
                    view.width_al = view.right - (left.refView?.right)! - left.value
                }
                view.left = (left.refView?.right)! + left.value
            }
        }else if let equalLeft = model.equal_left {//equal left
            if view.fixedWidth == nil {
                if view.superview == model.needAutoResizeView {//its superview's model. as: view.superview'left = view.left - offset
                    view.width_al = view.right - (0 + equalLeft.offset)
                }else {//it's sibling's model. as: view.sibling'left = view.left - offset
                    guard view != model.needAutoResizeView else {
                        return
                    }
                    view.width_al = view.right - ((equalLeft.refView?.right)! + equalLeft.offset)
                }
            }
            
            guard  view == model.needAutoResizeView  else {//it's own model
                return
            }

            if view.superview == equalLeft.refView {//relative to it's superview. as:0 = view.left - offset
                view.left = 0 + equalLeft.offset
            }else {//relative to it's sibling. as:view.sibling.right = view.left - offset
                view.left = (equalLeft.refView?.left)! + equalLeft.offset
            }
        }else if let equalCenterX = model.equal_centerX {//equal centerX
            guard view == model.needAutoResizeView else {//it's own model
                return
            }
            if view.superview == equalCenterX.refView {//relative to it's superview. as:view.superview.centerX = view.centerX - offset
                view.centerX = (equalCenterX.refView?.width)! * 0.5 + equalCenterX.offset
            }else {//relative to it's sibling. as:view.siblingview.centerX = view.centerX - offset
                view.centerX = (equalCenterX.refView?.centerX)! + equalCenterX.offset
            }
        }else if let centerX = model.centerX {
            view.centerX = centerX
        }
    }
    
    func layoutRight(view:UIView,model:AutoLayoutModel) {
        guard view == model.needAutoResizeView else {
            return
        }
        if let right = model.right {
            if view.superview == right.refView {//relative to it's superview. as:view.right + value = view.superview.width
                if view.fixedWidth == nil {
                    view.width_al = (right.refView?.width_al)! - view.left - right.value
                }
                view.right = (right.refView?.width_al)! - right.value
            }else {//relative to it's sibling. as:view.siblingview.left  = view.right + value
                if view.fixedWidth == nil {
                    view.width_al = (right.refView?.left)! + right.value
                }
                view.right = (right.refView?.left)! - right.value
            }
        }else if let equalRight = model.equal_right {
            if view.fixedWidth == nil {
                if view.superview == equalRight.refView {//relative to it's superview. as:view.right = view.superview.width + offset
                    view.width_al = (equalRight.refView?.width_al)! - view.left + equalRight.offset
                }else {//relative to it's sibling. as:view.right = view.siblingview.right + offset
                    view.width_al = (equalRight.refView?.right)! - view.left + equalRight.offset
                }
            }
            
            if view.superview == equalRight.refView {
                view.right = (equalRight.refView?.width_al)! + equalRight.offset
            }else {
                view.right = (equalRight.refView?.right)! + equalRight.offset
            }
        }
    }
    
    func layoutTop(view:UIView,model:AutoLayoutModel) {
        if let top = model.top {
            if view.superview == top.refView {//relative to it's superview.
                if view.fixedHeight == nil {
                    view.height_al = view.bottom - top.value
                }
                view.top = top.value
            }else {//relative to it's sibling. as:view.top = view.siblingview.bottom + space
                if let refTopViews = top.refViewArray {
                    if refTopViews.count > 0 {
                        var lastRefBottom:CGFloat = 0
                        for refView in refTopViews {
                            if refView.bottom > lastRefBottom {
                                model.top?.refView = refView
                                lastRefBottom = refView.bottom
                            }
                        }
                        
                    }
                }
                
                if view.fixedHeight == nil {
                    view.height_al = view.bottom - (top.refView?.bottom)! - top.value
                }
                view.top = (top.refView?.bottom)! + top.value
            }
        }else if let equalTop = model.equal_top  {
            if view.superview == equalTop.refView {//relative to it's superview
                if view.fixedHeight == nil {
                    view.height_al = view.bottom - equalTop.offset
                }
                view.top = equalTop.offset
            }else {//relative to it's sibling
                if view.fixedHeight == nil {
                    view.height_al = view.bottom - ((equalTop.refView?.top)! + equalTop.offset)
                }
                view.top = (equalTop.refView?.top)! + equalTop.offset
            }
        }else if let equalCenterY = model.equal_centerY {
            if view.superview == equalCenterY.refView {//relative to it's superview
                view.centerY = (equalCenterY.refView?.height)!*0.5 + equalCenterY.offset
            }else {
                view.centerY = (equalCenterY.refView?.centerY)! + equalCenterY.offset
            }
        }else if let centerY = model.centerY {
            view.centerY = centerY
        }
    }
    
    func layoutBottom(view:UIView,model:AutoLayoutModel) {
        if let bottom = model.bottom {
            if view.superview == bottom.refView {//relative to it's superview
                if view.fixedHeight == nil {
                    view.height_al = (bottom.refView?.height_al)! - (bottom.value + view.top)
                }
                view.bottom = (bottom.refView?.height_al)! - bottom.value
            }else {
                if view.fixedHeight == nil {//relative to it's sibling
                    view.height_al = (bottom.refView?.top)! - (bottom.value + view.top)
                }
                view.bottom = (bottom.refView?.top)! - bottom.value
            }
        }else if let equalBottom = model.equal_bottom {
            if view.superview == equalBottom.refView {//relative to it's superview
                if view.fixedHeight == nil {
                    view.height_al = (equalBottom.refView?.height_al)! - view.top + equalBottom.offset
                }
                view.bottom = (equalBottom.refView?.height_al)! + equalBottom.offset
            }else {
                if view.fixedHeight == nil {//relative to it's sibling
                    view.height_al = (equalBottom.refView?.bottom)! - view.top + equalBottom.offset
                }
                view.bottom = (equalBottom.refView?.bottom)! + equalBottom.offset
            }
        }
        
        if model.equal_wh != nil && view.fixedHeight == nil {
            layoutRight(view: view, model: model)
        }
    }
}

// MARK: runtime properties
extension UIView  {
    var al_equalWidthViews:[UIView]? {
        get{
            return objc_getAssociatedObject(self, "equalWidthViews.key") as? [UIView]
        }
        
        set{
            objc_setAssociatedObject(self, "equalWidthViews.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
}

extension UILabel {
    func singleLineAutoResize(with maxWidth:CGFloat) {
        self.maxWidth = maxWidth
    }
    
    func showMaxNumberOfLines(_ lineCount:UInt) {
        assert(ownLayoutModel != nil, "you should set this step after layout")
        if lineCount > 0 {
            al_layout().maxHeightIs(value: self.font.lineHeight*CGFloat(lineCount) + 0.1)
        }else {
            al_layout().maxHeightIs(value: CGFloat(MAXFLOAT))
        }
    }
    
    @objc func al_setText(text:String) {
        al_setText(text: text)
        if maxWidth != nil {
            sizeToFit()
        }else if autoHeightRatioValue != nil {
            self.size = .zero
        }
    }
    
}

// MARK: UILable Runtime keys
extension UILabel {
    var isAttributedText : Bool? {
        get{
            return objc_getAssociatedObject(self, "isAttributedText.key") as? Bool
        }
        set{
            objc_setAssociatedObject(self, "isAttributedText.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: UILabel method swizzling
extension SelfAware where Self:UILabel {
    static func awake() {
        let originMethod = class_getClassMethod(self, #selector(setter: text))
        let customMethod = class_getClassMethod(self, #selector(al_setText(text:)))
        method_exchangeImplementations(originMethod!, customMethod!)
    }
}


// MARK: method swizzling
extension SelfAware where Self:UIView{
    static func awake() {
        let originMethod = class_getInstanceMethod(self, #selector(layoutSubviews))
        let customMethod = class_getInstanceMethod(self, #selector(al_autoLayoutSubviews))
        method_exchangeImplementations(originMethod!, customMethod!)
    }
}


