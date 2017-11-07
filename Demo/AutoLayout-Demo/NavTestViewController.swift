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
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true//default is true
            navigationController?.view?.backgroundColor = .clear
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
            navigationBar.isTranslucent = false
            navigationController?.view?.backgroundColor = nil
        }
    }
}

