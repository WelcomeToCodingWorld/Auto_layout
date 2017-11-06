//
//  UIView+AutoLayout.swift
//  Auto_Layout
//
//  Created by zz on 27/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

extension UIView {
    public func al_layout()->AutoLayoutModel {
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
            
            if sv.autoLayoutModels == nil {
                sv.autoLayoutModels = [AutoLayoutModel]()
            }

            sv.autoLayoutModels?.append(model)
            printLog(sv.autoLayoutModels)
            return model
        }
    }
    
    //self.model
    var ownLayoutModel : AutoLayoutModel? {
        get {
            return (objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.ownLayoutModelKey) as? AutoLayoutModel)
        }
        
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.ownLayoutModelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //subviews' models
    var autoLayoutModels : [AutoLayoutModel]? {
        get {
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.autoLayoutModelsKey) as? [AutoLayoutModel]
        }
        
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.autoLayoutModelsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addModel(model:AutoLayoutModel) {
        autoLayoutModels?.append(model)
    }
    
    @objc func al_autoLayoutSubviews() {
        al_autoLayoutSubviews()
        al_layoutSubviewsHandle()
    }
    
    private func resize(with model:AutoLayoutModel){
        guard let view = model.needAutoResizeView else {
            return
        }
        if view.maxWidth != nil && (model.space_right != nil || model.equal_right != nil) {
            layoutAutoWidth(view: view, model: model)
            fixedWidth = view.width_al
        }
        layoutWidth(view: view, model: model)
        layoutHeight(view: view, model: model)
        layoutLeft(view: view, model: model)
        layoutRight(view: view, model: model)
        
        if view.autoHeightRatioValue != nil && view.width_al > 0 && (model.space_bottom != nil || model.equal_bottom != nil) {
            layoutAutoHeight(view: view, model: model)
            fixedHeight = view.height_al
        }
        
        layoutTop(view: view, model: model)
        layoutBottom(view: view, model: model)
        
        if view.maxWidth != nil {
            layoutAutoWidth(view: view, model: model)
        }
        
        if let maxWidth = model.maxWidth {
            width_al = min(maxWidth, width_al)
        }
        
        if let minWidth = model.minWidth {
            height_al = max(minWidth, height_al)
        }
        
        if autoHeightRatioValue != nil && width_al > 0 {
            layoutAutoHeight(view: view, model: model)
        }
        
        if let maxHeight = model.maxHeight {
            height_al = min(maxHeight, height_al)
        }
        
        if let minHeight = model.minHeight {
            height_al = max(minHeight, height_al)
        }
        
        if model.equal_wh != nil {
            width_al = height_al
        }
        
        if model.equal_hw != nil{
            height_al = width_al
        }
    }
    
    private func al_layoutSubviewsHandle() {
        // TODO: layout handle method
        guard let models = autoLayoutModels else {
            return
        }
        printLog(models)
        if models.count > 0 {
            for model in models {
                resize(with: model)
            }
        }
    }
}

// MARK: atuto widht,height
extension UIView {
    var extManager:ExtManager? {
        get {
            if objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.extManagerKey) as? ExtManager == nil {
                objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.extManagerKey, ExtManager(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.extManagerKey) as? ExtManager
        }
        set {
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.extManagerKey, ExtManager(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var rightViewsArray : [UIView]? {
        get {
            return extManager?.rightViews
        }
        set {
            extManager?.rightViews = newValue
        }
    }
    
    var bottomViewsArray:[UIView]? {
        get{
            if objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.bottomViewsArrayKey) as? [UIView] == nil {
                objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.bottomViewsArrayKey, [UIView](), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.bottomViewsArrayKey) as? [UIView]
        }
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.bottomViewsArrayKey, [UIView](), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var rightViewRightMargin:CGFloat? {
        get{
            return extManager?.rightViewRightMargin
        }
        
        set{
            extManager?.rightViewRightMargin = newValue
        }
    }
    
    var bottomViewBottomMargin:CGFloat? {
        get{
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.bottomViewBottomMarginKey) as? CGFloat
        }
        
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.bottomViewBottomMarginKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var autoHeight:CGFloat? {
        get{
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.autoHeightKey) as? CGFloat
        }
        
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.autoHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    
    func setupAutoHeight(with bottomView:UIView,bottomMaigin:CGFloat) {
        setupAutoHeight(with: [bottomView], bottomMargin: bottomMaigin)
    }
    
    func setupAutoWidth(with rightView:UIView,rightMargin:CGFloat) {
        rightViewsArray?.removeAll()
        rightViewsArray?.append(rightView)
        rightViewRightMargin = rightMargin
    }
    
    func setupAutoHeight(with bottomViewsArray:[UIView],bottomMargin:CGFloat) {
        self.bottomViewsArray?.removeAll()
        self.bottomViewsArray?.append(contentsOf: bottomViewsArray)
        bottomViewBottomMargin = bottomMargin
    }
    
    func clearAutoHeightSettings() {
        bottomViewsArray?.removeAll()
        bottomViewsArray = nil
    }
    
    func clearAutoWidthSettings() {
        rightViewsArray?.removeAll()
        rightViewsArray = nil
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
                if txt.count > 0 {
                    if let attributed = label.isAttributedText {
                        if !attributed {
                            var rect = (txt as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: label.height_al), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:label.font], context: nil)
                            if rect.size.width > width {
                                rect.size.width = width
                            }
                            label.width = rect.size.width + 0.1
                        }else {
                            sizeToFit()
                            if self.width_al > width {
                                label.width_al = width
                            }
                        }
                    }
                }else {
                    label.size = .zero
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
    
    func layoutAutoHeight(view:UIView,model:AutoLayoutModel) {
        if let autoRatioValue = view.autoHeightRatioValue {
            if autoRatioValue > 0 {
                view.height_al = view.width_al*autoRatioValue
            }else {
                guard let label = view as? UILabel else{
                    view.height_al = 0
                    return
                }
                if let txt = label.text {
                    if txt.count > 0 {
                        if let attributed = label.isAttributedText {
                            if !attributed {
                                let rect = (txt as NSString).boundingRect(with: CGSize(width: label.width_al, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : label.font], context: nil)
                                label.height_al = rect.size.height + 0.1
                            }else {
                                sizeToFit()
                            }
                        }
                    }else {
                        view.height_al = 0
                    }
                }
            }
        }
    }
    
    func layoutLeft(view:UIView,model:AutoLayoutModel) {
        if let left = model.space_left {//space left
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
                                model.space_left?.refView = view
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
                }else if view != model.needAutoResizeView{//it's sibling's model. as: view.sibling'left = view.left - offset
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
        if let right = model.space_right {
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
        if let top = model.space_top {
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
                                model.space_top?.refView = refView
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
        if let bottom = model.space_bottom {
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
    
    func updateLayout() {
        superview?.layoutSubviews()
    }
}

// MARK: runtime properties
extension UIView  {
    var al_equalWidthViews:[UIView]? {
        get{
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.equalWidthViewsKey) as? [UIView]
        }
        
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.equalWidthViewsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var fixedWidth : CGFloat? {
        get{
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.fixedWidthKey) as? CGFloat
        }
        
        set{
            if let width = newValue {
                self.width_al = width
                objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.fixedWidthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var fixedHeight : CGFloat? {
        get{
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.fixedHeightKey) as? CGFloat
        }
        
        set{
            if let height = newValue {
                self.height_al = height
            }
        }
    }
    
    var autoHeightRatioValue:CGFloat? {
        get{
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.autoHeightRatioValueKey) as? CGFloat
        }
        
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.autoHeightRatioValueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var maxWidth:CGFloat? {
        get{
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.maxWidthKey) as?  CGFloat
        }
        
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.maxWidthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: UILable Layout
extension UILabel {
    func singleLineAutoResize(with maxWidth:CGFloat) {
        self.maxWidth = maxWidth
    }
    
    func showMaxNumberOfLines(_ lineCount:UInt) {
        assert(ownLayoutModel != nil, "you should set this step after layout")
        if lineCount > 0 {
             al_layout().maxWidthIs(font.lineHeight*CGFloat(lineCount) + 0.1)
        }else {
             al_layout().maxHeightIs(CGFloat(MAXFLOAT))
        }
    }
    
    @objc func al_setText(_ text:String) {
        al_setText(text)
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
            return objc_getAssociatedObject(self, AutoLayoutRuntimeKeys.isAttributedTextKey) as? Bool
        }
        set{
            objc_setAssociatedObject(self, AutoLayoutRuntimeKeys.isAttributedTextKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: method swizzling
extension UIView:SelfAware {
    static func awake() {
        var originSelector:Selector
        var swizzledSelector:Selector
        if  let varType = self as? UILabel.Type {
            originSelector = #selector(setter: varType.text)
            swizzledSelector = #selector(varType.al_setText(_:))
            swizzleMethod(originalSelector: originSelector, swizzledSelector: swizzledSelector)
        }
        originSelector = #selector(layoutSubviews)
        swizzledSelector = #selector(al_autoLayoutSubviews)
        swizzleMethod(originalSelector: originSelector, swizzledSelector: swizzledSelector)
    }
}

