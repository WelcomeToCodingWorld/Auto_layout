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
        view.backgroundColor = UIColor.orange
        navigationController?.navigationBar.barTintColor = UIColor.colorFromRGB(rgbValue:0x8B008B)
        navigationController?.navigationBar.tintColor = UIColor.magenta
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.green]
        let view1 = UILabel.label(text: "Godsgwegwegwewgw2e3gwedGodsgwegwegwewgw2e3gwedGodsgwegwegwewgw2e3gwedGodsgwegwegwewgw2e3gwedGodsgwegwegwewgw2e3gwedGodsgwegwegwewgw2e3gwedGodsgwegwegwewgw2e3gwed", textAttributes: [UIFont.systemFont(ofSize: 13)], alignment: .center,bgColor: UIColor.cyan)
        
        var attributedStr = NSMutableAttributedString.init(string: view1.text!)
        
        
//        view1.isAttributedText = true
        
        let view2 = UILabel.label(text: "Gash", textAttributes: [UIFont.systemFont(ofSize: 13)],bgColor: UIColor.purple)
        view.addSubview(view1)
        view.addSubview(view2)
        
        let view3 = UILabel.label(text: "testHeight", textAttributes: [UIFont .systemFont(ofSize: 15)], alignment: .center, bgColor: UIColor.black)
        view.addSubview(view3)
        //note: -30 is treated as 30
        view3.frame = CGRect(x: 10, y: 350, width: 100, height: -30)
        
        
        
        
        view1.al_layout().leftSpaceToView(view, 15).rightSpaceToView(view, 15).topSpaceToView(view, 100).autoHeightRatio(value: 0)
        view2.al_layout().leftEqualToView(view1).rightEqualToView(view1).topSpaceToView(view1, 20).heightIs(50)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

