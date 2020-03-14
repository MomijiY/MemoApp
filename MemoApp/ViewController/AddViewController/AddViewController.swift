//
//  AddViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/21.
//  Copyright © 2019 com.litech. All rights reserved.
//

import UIKit
import SwiftyTesseract
var memoTitleArray = [String]()

class AddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        // MARK: IBOutlet
        
        @IBOutlet weak var titleTextField: UITextField!
    //    @IBOutlet weak var contentTextField: UITextField!
        @IBOutlet weak var contentTextView: UITextView!
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var navigationBar: UINavigationBar!
//        @IBOutlet weak var tableView: UITableView!
        // MARK: Properties
        
        private let model = UserDefaultsModel()
        let swiftyTesseract = SwiftyTesseract(language: RecognitionLanguage.japanese)
        
        // MARK: Lifecycle
        
        static func instance() -> AddViewController {
            let vc = UIStoryboard(name: "AddViewController", bundle: nil).instantiateInitialViewController() as! AddViewController
            return vc
        }
    

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
        
        @IBAction func tappedSwiftyTesseract(_ sender: Any) {
            guard let image = imageView.image else { return }
            
            swiftyTesseract.performOCR(on: image) { recognizedString in
                guard let text = recognizedString else { return }
                print("\(text)")
                self.contentTextView.text! = text
            }
        }
    
        @IBAction func launchCamera(_ sender: UIButton) {
                let camera = UIImagePickerController.SourceType.camera
                if UIImagePickerController.isSourceTypeAvailable(camera) {
                    let picker = UIImagePickerController()
                    picker.sourceType = camera
                    picker.delegate = self
                    self.present(picker, animated: true)
                }
                imageView.isHidden = false
                // imageButton.isHidden = true
            }
        //カメラロールから写真を選択する処理
        @IBAction func choosePicture() {
            // カメラロールが利用可能か？
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                // 写真を選ぶビュー
                let pickerView = UIImagePickerController()
                // 写真の選択元をカメラロールにする
                // 「.camera」にすればカメラを起動できる
                pickerView.sourceType = .photoLibrary
                // デリゲート
                pickerView.delegate = self
                // ビューに表示
                self.present(pickerView, animated: true)
            }
        }
    
    //
        //ユーザーが撮影し終わった時の処理
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
                    imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            //        fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                    let image = imageView.image
                    let pngImageData:Data = image!.pngData()!
                    let documentsURL:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL:URL = documentsURL.appendingPathComponent("image.png")
                    do{
                        try pngImageData.write(to: fileURL)
                    }catch{
                        print("書き込み失敗")
                    }
                    dismiss(animated: true, completion: nil)
    
                    //編集機能を表示させたい場合
                    //UIImagePickerControllerEditedImageはallowsEditingをYESにした場合に用いる。
                    //allowsEditingで指定した範囲を画像として取得する事ができる。
                    //UIImagePickerControllerOriginalImageはallowsEditingをYESにしていたとしても編集機能は表示されない。
    //                if info[UIImagePickerController.InfoKey.originalImage] != nil {
    //                    let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
    //                    //画像を設定する
                        imageView.image = image
        }
    
    
//        @IBAction func tappedSaveButton(sender: UIBarButtonItem) {
////            saveMemo()
//        }
        @objc private func onTapSaveButton() {
            saveMemo()
//            let vc = ViewController.instance()
//            navigationController?.pushViewController(vc, animated: true)
        }
    
        @IBAction func Save() {
            onTapSaveButton()
        }
    }

    // MARK: - Configure

    extension AddViewController {

//        private func configureUI() {
////            tableView.delegate = self
//            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onTapSaveButton(_:)))
//        }
//
    }


    // MARK: - Model

    extension AddViewController {
        
        private func saveMemo() {
            guard let title = titleTextField.text,
                let content = contentTextView.text else { return }
            
            // Save memo
            let memo = Memo(id: UUID().uuidString, title: title, content: content)
            if let storedMemos = model.loadMemos() {
                var newMemos = storedMemos
                newMemos.append(memo)
                model.saveMemos(newMemos)
            } else {
                model.saveMemos([memo])
            }
            
            // Save image
            if let image = imageView.image {
                model.saveImage(id: memo.id, image: image)
            }
            
            memoTitleArray = [title]
            let storyboard: UIStoryboard = UIStoryboard(name: "ViewController", bundle: nil)
            let next: UIViewController = storyboard.instantiateInitialViewController() as! UIViewController
            present(next, animated: true, completion: nil)
        }
    }

    // MARK: - TableView delegate

    // MARK: - TableView delegate
//
//    extension AddViewController {
//
//        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            tableView.deselectRow(at: indexPath, animated: true)
//            switch indexPath.section {
//            case 2:
//                presentImagePicker()
//            case 4:
//                saveMemo()
//            default:
//                break
//            }
//        }
//    }
//
//    // MARK: - ImagePicker delegate
//
//    extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//        private func presentImagePicker() {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            present(imagePicker, animated: true, completion: nil)
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            defer {
//                picker.dismiss(animated: true, completion: nil)
//            }
//            guard let image = info[.originalImage] as? UIImage else { return }
//            imageView.image = image
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true, completion: nil)
//        }
//    }


//var MemonoNakami = [String]()
////var MemoImageNakami = [UIImage]()
//
//class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet weak var memoTextField: UITextField!
//    @IBOutlet weak var memoTextView: UITextView!
//    @IBOutlet weak var imageView: UIImageView!
//// @IBOutlet weak var imageButton: UIButton!
//
//    let swiftyTesseract = SwiftyTesseract(language: RecognitionLanguage.japanese)
//    let saveData: UserDefaults = UserDefaults.standard
//
//    private let model = UserDefaultsModel()
//
//
//    //カメラボタンがタップされた時の処理
//    @IBAction func launchCamera(_ sender: UIButton) {
//        let camera = UIImagePickerController.SourceType.camera
//        if UIImagePickerController.isSourceTypeAvailable(camera) {
//            let picker = UIImagePickerController()
//            picker.sourceType = camera
//            picker.delegate = self
//            self.present(picker, animated: true)
//        }
//        imageView.isHidden = false
//        // imageButton.isHidden = true
//    }
//
//    //カメラロールから写真を選択する処理
//    @IBAction func choosePicture() {
//        // カメラロールが利用可能か？
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            // 写真を選ぶビュー
//            let pickerView = UIImagePickerController()
//            // 写真の選択元をカメラロールにする
//            // 「.camera」にすればカメラを起動できる
//            pickerView.sourceType = .photoLibrary
//            // デリゲート
//            pickerView.delegate = self
//            // ビューに表示
//            self.present(pickerView, animated: true)
//        }
//    }
//
//
//
//    //ユーザーが撮影し終わった時の処理
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//                imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        //        fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//                let image = imageView.image
//                let pngImageData:Data = image!.pngData()!
//                let documentsURL:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//                let fileURL:URL = documentsURL.appendingPathComponent("image.png")
//                do{
//                    try pngImageData.write(to: fileURL)
//                }catch{
//                    print("書き込み失敗")
//                }
//                dismiss(animated: true, completion: nil)
//
//                //編集機能を表示させたい場合
//                //UIImagePickerControllerEditedImageはallowsEditingをYESにした場合に用いる。
//                //allowsEditingで指定した範囲を画像として取得する事ができる。
//                //UIImagePickerControllerOriginalImageはallowsEditingをYESにしていたとしても編集機能は表示されない。
////                if info[UIImagePickerController.InfoKey.originalImage] != nil {
////                    let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
////                    //画像を設定する
////                    imageView.image = image
////                }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // donebuttonの実装
//        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
//        kbToolBar.barStyle = UIBarStyle.default // スタイルを設定
//        kbToolBar.sizeToFit() // 画面幅に合わせてサイズを変更
//        // スペーサー
//        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//        // 閉じるボタン
//        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
//        kbToolBar.items = [spacer, commitButton]
//        memoTextView.inputAccessoryView = kbToolBar
//
//        //first image
//        imageView.image = UIImage(named: "No-Image.PNG")
//
//    }
//
//    @objc func commitButtonTapped() {
//        self.view.endEditing(true)
//    }
//
//    @IBAction func save(_ sender: Any) {
//
//        let inputText = memoTextView.text
//        let ud = UserDefaults.standard
//
//        let memo = Memo(id: UUID().uuidString, content: inputText!)
//
//        if let data = UserDefaults.standard.data(forKey: "MemoIMageKey"), let storedMemoArray = try? JSONDecoder().decode([Memo].self, from: data){
//            var newMemoArray = storedMemoArray
//
//            newMemoArray.append(memo)
//
//            //newMemoArrayの構造をコンソールにわかりやすく表示
//            dump(newMemoArray)
//
//            //Dataに戻して保存
//            if let newData = try? JSONEncoder().encode(newMemoArray.self) {
//                UserDefaults.standard.set(newData, forKey: "MemoIMageKey")
//            }
//        } else {
//            //初回の処理
//            var newMemoArray = [Memo]()
//
//            newMemoArray.append(memo)
//            dump(newMemoArray)
//
//            if let newData = try? JSONEncoder().encode(newMemoArray) {
//                UserDefaults.standard.set(newData, forKey: "MemoIMageKey")
//            }
//        }
//        showAlert(title: "初回保存しました。")
//
//
//    }
//
////
////    @IBAction func save(_ sender: Any) {
////
////        let inputText = memoTextView.text
////        let ud = UserDefaults.standard
////
////        // 新しいメモの構造体を生成
////        let memo = Memo(id: UUID().uuidString, content: inputText!)
////
////        // 一度Dataとして取り出し、そのあとにMemoの配列にデコード
////        if let data = UserDefaults.standard.data(forKey: "MemoImageKey"),
////             let storedMemoArray = try? JSONDecoder().decode([Memo].self, from: data) {
////            var newMemoArray = storedMemoArray
////            newMemoArray.append(memo)
////
////            // Dataに戻して保存
////            if let newData = try? JSONEncoder().encode(newMemoArray) {
////                UserDefaults.standard.set(newData, forKey:"MemoImageKey")
////            }
////        } else {
////            // 何も保存されていなかった時の処理
////            showAlert(title: "何も保存されていません。")
////            print(inputText)
////            print(imageView.image)
////        }
////
////        // ImagePickerから選択された画像を取り出し、Dataに変換
////        if let image = imageView.image,
////           let imageData = image.jpegData(compressionQuality: 0.8) {
////            // キーには上で生成したMemoのid(UUID)を使う
////            UserDefaults.standard.set(imageData, forKey: memo.id)
////        }
////
//////        if ud.array(forKey: "memoArray") != nil{
//////
//////            var saveMemoArray = ud.array(forKey: "memoArray") as! [String]
//////
//////            if inputText != ""{
//////                //配列に追加
//////                saveMemoArray.append(inputText!)
//////                ud.set(saveMemoArray, forKey: "memoArray")
//////            }else{
//////                showAlert(title: "何も入力されていません")
//////
//////            }
//////
//////        }else{
//////            var newMemoArray = [String]()
//////
//////            if inputText != ""{
//////
//////                newMemoArray.append(inputText!)
//////                ud.set(newMemoArray, forKey: "memoArray")
//////            }else{
//////                showAlert(title: "何も入力されていません")
//////            }
//////        }
////
////
////        showAlert(title: "保存完了")
////        ud.synchronize()
////    }
//
//    func showAlert(title:String){
//        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
//
//        self.present(alert, animated: true, completion:nil)
//    }
//
//
//    @IBAction func loadimageView() {
//        print("読み込み開始")
//        swiftyTesseract.performOCR(on: imageView.image!) { recognizedString in
//            guard let text = recognizedString else { return }
//            print("\(text)")
//
//            self.memoTextView.text = text
//
//        }
//    }
//}
//
//
//// MARK: - Model
//extension AddViewController {
//
//    private func saveMemo() {
//        guard let title = memoTextField.text,
//            let content = memoTextView.text else { return }
//
//        // Save memo
//        let memo = Memo(id: UUID().uuidString, title: title, content: content)
//        if let storedMemos = model.loadMemos() {
//            var newMemos = storedMemos
//            newMemos.append(memo)
//            model.saveMemos(newMemos)
//        } else {
//            model.saveMemos([memo])
//        }
//
//        // Save image
//        if let image = imageView.image {
//            model.saveImage(id: memo.id, image: image)
//        }
//
//        // Pop
//        navigationController?.popViewController(animated: true)
//    }
//}
