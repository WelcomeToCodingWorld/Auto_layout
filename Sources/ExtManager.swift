//
//  ExtManager.swift
//  Auto_Layout
//
//  Created by zz on 30/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

struct ExtManager {
    var rightViews : [UIView]?
    var rightViewRightMargin:CGFloat?
    var frameCached:Bool = false
    var readjustFrameBeforeStoreCache:Bool = false
    var closeAutoLayout:Bool = false
    
    var flowItems = [UIView]()
    var verticalMargin:CGFloat = 0
    var horizontalMargin:CGFloat = 0
    var itemsPerRow:UInt = 0
    
    var flowItemWidth:CGFloat = 0
    var showAsAutoMariginViews:Bool = false
    var horizontalEdgeInset:CGFloat = 0
    var verticalEdgeInset:CGFloat = 0
}
