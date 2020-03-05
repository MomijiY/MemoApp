//
//  Memo.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/01.
//  Copyright © 2020 com.litech. All rights reserved.
//

import Foundation

struct Memo: Codable {
    var id: String //UUID
    var title: String
    var content: String
}
