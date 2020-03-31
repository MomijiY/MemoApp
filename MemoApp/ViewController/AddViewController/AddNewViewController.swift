//
//  AddNewViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/25.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!

    let model = UserDefaultsModel()
    var memo: Memo!
    var lineIndex = 1
    static func instance() -> AddNewViewController {
        let vc = UIStoryboard(name: "AddViewController", bundle: nil).instantiateInitialViewController() as! AddNewViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
