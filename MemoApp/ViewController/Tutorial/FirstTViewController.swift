//
//  First-TViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/13.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class FirstTViewController: UIViewController {
    
    static func instance() -> FirstTViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! FirstTViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
