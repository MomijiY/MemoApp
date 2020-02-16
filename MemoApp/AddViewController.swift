////
////  AddViewController.swift
////  MemoApp
////
////  Created by 吉川椛 on 2019/11/21.
////  Copyright © 2019 com.litech. All rights reserved.
////

//追加画面
import UIKit
import SwiftyTesseract

var MemonoNakami = [String]()
var MemoImageNakami = [UIImage]()

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var imageButton: UIButton!

    let swiftyTesseract = SwiftyTesseract(language: RecognitionLanguage.japanese)
    let saveData: UserDefaults = UserDefaults.standard

    //カメラボタンがタップされた時の処理
    @IBAction func launchCamera(_ sender: UIButton) {
        let camera = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(camera) {
            let picker = UIImagePickerController()
            picker.sourceType = camera
            picker.delegate = self
            self.present(picker, animated: true)
        }
        imageView.isHidden = false
//        imageButton.isHidden = true
    }
    
        //アルバムから写真を選択
//        @IBAction func openAlbum() {
//            //カメラロールを使えるかの確認
//            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//
//                //カメラロールの画像を選択して画像を表示するまでの一連の流れ
//                let picker = UIImagePickerController()
//                picker.sourceType = .photoLibrary
//                picker.delegate = self
//
//                picker.allowsEditing = true
//
//
//                present(picker, animated: true, completion: nil)
//            }
//        }
//
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



    //ユーザーが撮影し終わった時の処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.dismiss(animated: true)

        UserDefaults.standard.set(image.jpegData(compressionQuality: 0.8), forKey: "MemoImage")
        saveData.synchronize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        donebuttonの実装
                let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
                kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
                kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
                // スペーサー
                let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
                // 閉じるボタン
                let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
                kbToolBar.items = [spacer, commitButton]
                memoTextView.inputAccessoryView = kbToolBar
        
                //first image
                imageView.image = UIImage(named: "No-Image.PNG")
        
    }

    @objc func commitButtonTapped() {
           self.view.endEditing(true)
       }


    @IBAction func save(_ sender: Any) {

        let inputText = memoTextView.text
        let ud = UserDefaults.standard
        
        var addImage: UIImage = imageView.image!
        
        ud.setUIImageToData(image: addImage, forKey: "MemoImage")
        
        if ud.array(forKey: "memoArray") != nil{

            var saveMemoArray = ud.array(forKey: "memoArray") as! [String]

            if inputText != ""{
                //配列に追加
                saveMemoArray.append(inputText!)
                ud.set(saveMemoArray, forKey: "memoArray")
            }else{
                showAlert(title: "何も入力されていません")

            }

        }else{
            var newMemoArray = [String]()

            if inputText != ""{

                newMemoArray.append(inputText!)
                ud.set(newMemoArray, forKey: "memoArray")
            }else{
                showAlert(title: "何も入力されていません")
            }
        }
        
        
        showAlert(title: "保存完了")
        ud.synchronize()
    }

    func showAlert(title:String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion:nil)
    }

    
        @IBAction func loadimageView() {
            print("読み込み開始")
            swiftyTesseract.performOCR(on: imageView.image!) { recognizedString in
                guard let text = recognizedString else { return }
                print("\(text)")
    
                self.memoTextView.text = text
    
            }
        }
}

//extension UserDefaults {
//    // 保存したいUIImage, 保存するUserDefaults, Keyを取得
//    func setUIImageToData(image: UIImage, forKey: String) {
//        // UIImageをData型へ変換
//        let nsdata = image.pngData()
//        // UserDefaultsへ保存
//        self.set(nsdata, forKey: "memoImageArray")
//    }
//    // 参照するUserDefaults, Keyを取得, UIImageを返す
//    func image(forKey: String) -> UIImage {
//        // UserDefaultsからKeyを基にData型を参照
//        let data = self.data(forKey: forKey)
//        // UIImage型へ変換
//        let returnImage = UIImage(data: data!)
//        // UIImageを返す
//        return returnImage!
//    }
//}
