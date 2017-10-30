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
        let view1 = UIView()
        view1.backgroundColor = UIColor.cyan
        let view2 = UIView()
        view2.backgroundColor = UIColor.purple
        view.addSubview(view1)
        view.addSubview(view2)
        
        view1.al_layout().leftSpaceToView(view, 15).rightSpaceToView(view, 15).topSpaceToView(view, 100).heightIs(50)
        view2.al_layout().leftEqualToView(view1).rightEqualToView(view1).topSpaceToView(view1, 20).heightIs(50)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

