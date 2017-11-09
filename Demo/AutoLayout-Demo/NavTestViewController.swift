//
//  NavTestViewController.swift
//  Auto_Layout
//
//  Created by zz on 07/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

class NavTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(goNext))
    }
    
    @objc private func goNext() {
        let vc = NextViewController()
        vc.title = "Haha"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard self.navigationController?.topViewController === self else {return}
        
        self.transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
            self?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self?.navigationController?.navigationBar.shadowImage = UIImage()
            }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //to solve the right swipe and then give up,so it didn't pop. But it did called viewWillDisappear.
        //but it won't call the viewWillAppear. Cuz,it didn't remove from the view Hierachy yet.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        if let navBar = navigationController?.navigationBar {
//            navBar.setBackgroundImage(nil, for: .default)
//            navBar.shadowImage = nil
//        }else {
//            printLog("Why the navigationBar is set to nil.I don't know!")
//        }
        
        //note: This animation alongSideTransition
        self.transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
            printLog("Hello")
            self?.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self?.navigationController?.navigationBar.shadowImage = nil
            }, completion: nil)
    }
}

