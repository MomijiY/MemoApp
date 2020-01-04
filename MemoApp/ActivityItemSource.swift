//
//  ActivityItemSource.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/30.
//  Copyright © 2019 com.litech. All rights reserved.
//

import UIKit

class ActivityItemSource: NSObject,UIActivityItemSource {

    var messsage: String!
    var image: UIImage!
     
    init(messsage: String, image: UIImage) {
        self.messsage = messsage
        self.image = image
    }
     
    // デフォルトのアイテム
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return messsage
    }
     
    // アプリ選択時に呼ばれる
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
         
        switch activityType {
        case .postToFacebook:
            return image
        case .postToTwitter:
            return "Twitter"
        default:
            return messsage
        }
    }
    
}
