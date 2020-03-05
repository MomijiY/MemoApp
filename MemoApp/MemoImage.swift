//
//  MemoImage.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/02/28.
//  Copyright © 2020 com.litech. All rights reserved.
//

import Foundation


struct Memo: Codable {
    let id: String //UUID().uuidStringを保存して画像の読み込みの時に使用
    let content: String //メモの内容
}
