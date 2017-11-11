//
//  AutoLayoutRuntimeKeys.swift
//  Auto_Layout
//
//  Created by zz on 06/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import Foundation

struct AutoLayoutRuntimeKeys{
    static let ownLayoutModelKey = UnsafeRawPointer("OwnLayoutModel.Key")
    static let autoLayoutModelsKey = UnsafeRawPointer("AutoLayoutModels.Key")
    static let extManagerKey = UnsafeRawPointer("ExtManager.Key")
    static let bottomViewsArrayKey = UnsafeRawPointer("BottomViewsArray.Key")
    static let bottomViewBottomMarginKey = UnsafeRawPointer("BottomViewBottomMargin.Key")
    static let autoHeightKey = UnsafeRawPointer("AutoHeight.Key")
    static let equalWidthViewsKey = UnsafeRawPointer("EqualWidthViews.Key")
    static let fixedWidthKey = UnsafeRawPointer.init(bitPattern: "FixedWidth.Key".hashValue)!
    static let fixedHeightKey = UnsafeRawPointer.init(bitPattern: "FixedHeight.Key".hashValue)!
    static let autoHeightRatioValueKey = UnsafeRawPointer("AutoHeightRatioValue.Key")
    static let maxWidthKey = UnsafeRawPointer("MaxWidth.Key")
    static let isAttributedTextKey = UnsafeRawPointer.init(bitPattern: "IsAttributedText.Key".hashValue)!
    static let maxNumberOfLinesKey = UnsafeRawPointer.init(bitPattern: "MaxNumberOfLines.Key".hashValue)!
}


