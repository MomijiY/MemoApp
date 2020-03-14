//
//  SecondTViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/14.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class ThirdTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishButtonTapped() {
        let vc = ViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
