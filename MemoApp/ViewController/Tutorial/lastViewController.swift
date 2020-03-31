//
//  lastViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/18.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class lastViewController: UIViewController {
    
    @IBOutlet weak var beginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        beginButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tappedLetsbegin(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ViewController", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController() as! UIViewController
        present(next, animated: true, completion: nil)
    }

}
