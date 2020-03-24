//
//  AddGroupTableViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/22.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class AddGroupTableViewController: UITableViewController {
        // MARK: IBOutlet
        
        @IBOutlet weak var titleTextField: UITextField!
        @IBOutlet weak var contentTextView: UITextView!
        // MARK: Properties
        
        private let model = UserDefaultsModel()    

        @objc func commitButtonTapped() {
            self.view.endEditing(true)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // donebuttonの実装
            let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
            kbToolBar.barStyle = UIBarStyle.default // スタイルを設定
            kbToolBar.sizeToFit() // 画面幅に合わせてサイズを変更
            // スペーサー
            let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,target: self, action: nil)
            // 閉じるボタン
            let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
            kbToolBar.items = [spacer, commitButton]
            titleTextField.inputAccessoryView = kbToolBar
            contentTextView.inputAccessoryView = kbToolBar

//            //first image
//            imageView.image = UIImage(named: "No-Image.PNG")
//            configureUI()
        }
    @objc private func onTapSaveButton(_ sender: UIBarButtonItem) {
            saveMemo()
        }
    }

    // MARK: - Configure

//    extension AddGroupTableViewController {
//
//        private func configureUI() {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save
//                , target: self, action: #selector(onTapSaveButton(_:)))
////            navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0, green: 145, blue: 147, alpha: 1.0)
//        }
//
//    }

extension AddGroupTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 2:
            saveMemo()
        default:
            break
        }
    }
}

    // MARK: - Model

    extension AddGroupTableViewController {
        
        private func saveMemo() {
            guard let title = titleTextField.text,
                let content = contentTextView.text else { return }
            
            // Save memo
//            let memo = Memo(id: UUID().uuidString, title: title, content: content)
            let memo = MemoGroup(groupTitle: title, groupContent: content)
            if let storedMemos = model.loadGroupMemos() {
                var newMemos = storedMemos
                newMemos.append(memo)
                model.saveGroup(newMemos)
            } else {
                model.saveGroup([memo])
            }
            
            memoTitleArray = [title]
            let storyboard: UIStoryboard = UIStoryboard(name: "ViewController", bundle: nil)
            let next: UIViewController = storyboard.instantiateInitialViewController() as! UIViewController
            present(next, animated: true, completion: nil)
        }
    }

