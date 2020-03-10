//
//  UserDefaultsModel.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/01.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

struct UserDefaultsModel {
    
    // MARK: UserDefaults Key
    
    private let kStoredMemosKey: String = "kStoredMemosKey"
    private var memo: Memo!
    
    // MARK: Memo
    
    func saveMemos(_ memo: [Memo]) {
        guard let data = try? JSONEncoder().encode(memo) else { return }
        UserDefaults.standard.set(data, forKey: kStoredMemosKey)
    }
    
    func loadMemos() -> [Memo]? {
        guard let data = UserDefaults.standard.data(forKey: kStoredMemosKey),
            let storedMemos = try? JSONDecoder().decode([Memo].self, from: data) else { return nil }
        return storedMemos
    }
    
    func deleteMemos() {
//        guard let data = UserDefaults.standard.data(forKey: kStoredMemosKey),
//            let storedMemos = try? JSONDecoder().decode([Memo].self, from: data) else { return nil }
//        var memoArray = [data]
//        return storedMemos
            var memoArray = [Memo]()
            memoArray.removeAll()
            
            var memoTitleArray = memo.title
            var memoContentArray = memo.content
            
        memoTitleArray.removeAll()
            //        if ud.array(forKey: "memoArray") != nil{
            //            var saveMemoArray = ud.array(forKey: "memoArray") as![String]
            //            saveMemoArray.remove(at: selectedRow)
            //            ud.set(saveMemoArray, forKey: "memoArray" )
            //            ud.synchronize()
            //            //画面遷移
            //            self.navigationController?.popViewController(animated: true)
            //        }
    }
    // MARK: Image
    
    func saveImage(id: String, image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        UserDefaults.standard.set(imageData, forKey: id)
    }
    
    func loadImage(id: String) -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: id) else { return nil }
        return UIImage(data: data)
    }
}
