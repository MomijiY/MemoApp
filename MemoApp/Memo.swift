//
//  Memo.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/30.
//  Copyright © 2019 com.litech. All rights reserved.
//

import Foundation

struct Memo: Codable {
    let id: String // UUID
    let title: String
    let content: String
}
