//
//  ViewController.swift
//  AutoLayout-Demo
//
//  Created by zz on 30/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit
import Auto_Layout

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.colorFromRGB(rgbValue:0x8B008B)
        navigationController?.navigationBar.tintColor = UIColor.magenta
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.green]
        let view1 = UILabel.label(text: "AttributedStringsizeToFitsizeToFitsizeToFitsizeToFitsizeToFitsizeToFitsizeToFitsizeToFit---AutoHeightAutoHeightAutoHeightAutoHeightAutoHeightAutoHeightAutoHeight", textAttributes: [UIFont.systemFont(ofSize: 13)], alignment: .center,bgColor: UIColor.lightGray)
        view.addSubview(view1)
        let paraStyle = NSMutableParagraphStyle()
        printLog(paraStyle.lineSpacing)
        paraStyle.lineSpacing = 8


        let attributedStr = NSMutableAttributedString.init(string: view1.text!)
        attributedStr.addAttributes([NSAttributedStringKey.paragraphStyle:paraStyle], range: NSMakeRange(0, (view1.text?.count)! - 1))
        view1.attributedText = attributedStr
        view1.isAttributedText = true
        
        let view2 = UILabel.label(text: "Gash", textAttributes: [UIFont.systemFont(ofSize: 13)],bgColor: UIColor.lightGray)
//        view.addSubview(view1)
        view.addSubview(view2)
        
        let view3 = UILabel.label(text: "negativeHeightAreTreatedAsIt'sAbsuluteValueAutomatically", textAttributes: [UIFont .systemFont(ofSize: 15)], alignment: .center, bgColor: UIColor.lightGray)
        view.addSubview(view3)
        
        //note: -30 is treated as 30
        view3.frame = CGRect(x: 10, y: 350, width: 100, height: -30)
        
        let view4 = UILabel.label(text: "setTextBeforeLayoutSettingDrawInBoundingRect---SingleLine", textAttributes: [UIFont .systemFont(ofSize: 16)],bgColor:UIColor.lightGray)
        view.addSubview(view4)        
        
        let view5 = UILabel.label(text: "stringSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFitSizeToFit", textAttributes: [UIFont.systemFont(ofSize: 12)],bgColor:UIColor.lightGray)
        view.addSubview(view5)
        view5.frame = CGRect(x: 15, y: 450, width: 150, height: 0)
        view5.numberOfLines = 1
        let attributedTxt = NSMutableAttributedString.init(string: view5.text!)
        attributedTxt.addAttributes([NSAttributedStringKey.paragraphStyle:paraStyle], range: NSMakeRange(0, (view5.text?.count)! - 1))
        view5.attributedText = attributedTxt
        view5.sizeToFit()
        printLog(view5.frame.size.height)
        
        view1.al_layout().leftSpaceToView(view, 15).rightSpaceToView(view, 15).topSpaceToView(view, 100).autoHeightRatio(value: 0)
        view2.al_layout().leftEqualToView(view1).rightEqualToView(view1).topSpaceToView(view1, 20).heightIs(50)
        view4.al_layout().leftEqualToView(view3).topSpaceToView(view3, 24).heightIs(40)
        view4.singleLineAutoResize(with: 320)
        view4.text = "setTextAfterLayoutSettingFinishedDrawInBoundingRect---SingleLine"
//        view1.showMaxNumberOfLines(2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if let navigation = navigationController {
//            printSubViews(of:navigation.navigationBar,level:1)
//        }
//        printLog(navigationController?.navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

