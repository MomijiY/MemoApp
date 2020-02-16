//
//  DetailViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/21.
//  Copyright © 2019 com.litech. All rights reserved.
//

//import UIKit
//
//
//class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
//
//    @IBOutlet weak var memoTextView: UITextView!
//    @IBOutlet weak var imageView: UIImageView!
//
//    var selectedRow:Int!
//    var selectedMemo : String!
//    let defaults = UserDefaults.standard
//    var saveArray: Array! = [NSData]()
//    var image: UIImage!
//
//
////    let uuid = NSUUID().uuidString
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        memoTextView.text = selectedMemo
//        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
//        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
//        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
//        // スペーサー
//        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//        // 閉じるボタン
//        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
//        kbToolBar.items = [spacer, commitButton]
//        memoTextView.inputAccessoryView = kbToolBar
//
//        let imageData:NSData = UserDefaults.standard.object(forKey: "ImageKey") as! NSData
//        imageView.image = UIImage(data: imageData as Data)
//    }
//
//
//
//
//    @objc func commitButtonTapped() {
//        self.view.endEditing(true)
//    }
//
//    //画面遷移する時にタップするボタン（保存）
//    @IBAction func save(_ sender: Any) {
//
//        let inputText = memoTextView.text
//        let ud = UserDefaults.standard
//        if ud.array(forKey: "memoArray") != nil{
//            //saveMemoArrayに取得
//            var saveMemoArray = ud.array(forKey: "memoArray") as! [String]
//                //テキストに何か書かれているか？
//            if inputText != ""{
//                //配列に追加
//                saveMemoArray[selectedRow] = inputText!
//                ud.set(saveMemoArray, forKey: "memoArray")
//                //画面遷移
//                self.navigationController?.popViewController(animated: true)
//            }else{
//                showAlert(title: "何も入力されていません")
//
//            }
//
//        }else{
//            //最初、何も書かれていない場合
//            var newMemoArray = [String]()
//            //nilを強制アンラップはエラーが出るから
//            if inputText != ""{
//                //inputtextはoptional型だから強制アンラップ
//                newMemoArray.append(inputText!)
//                ud.set(newMemoArray, forKey: "memoArray")
//            }else{
//                showAlert(title: "何も入力されていません")
//            }
//        }
//        showAlert(title: "保存完了")
//        ud.synchronize()
//    }
//
//
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
//    //削除ボタン
//    @IBAction func deleteMemo(_ sender: Any) {
////        deleteShowAlert()
//        print("消去成功！！")
//        let ud = UserDefaults.standard
//        if ud.array(forKey: "memoArray") != nil{
//            var saveMemoArray = ud.array(forKey: "memoArray") as![String]
//            saveMemoArray.remove(at: selectedRow)
//            ud.set(saveMemoArray, forKey: "memoArray" )
//            ud.synchronize()
//            //画面遷移
//            self.navigationController?.popViewController(animated: true)
//        }
//        print("消去成功２！！")
//    }
//
//
//
//    func sendSaveImage() {
//        //NSData型にキャスト
//        let data = image.pngData() as NSData?
//        if let imageData = data {
//            saveArray.append(imageData)
//
//            defaults.set(saveArray, forKey: "saveImage")
//            defaults.synchronize()
//        }
//    }
//
//
//
//    func deleteShowAlert() {
//        let alert = UIAlertController(title: "確認",
//                                      message: "画像を削除してもいいですか？",
//                                      preferredStyle: .alert)
//        let okButton = UIAlertAction(title: "OK",
//                                     style: .default,
//                                     handler:{(action: UIAlertAction) -> Void in
//        })
//        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
//
//        // アラートにボタン追加
//        alert.addAction(okButton)
//        alert.addAction(cancelButton)
//
//        // アラート表示
//        present(alert, animated: true, completion: nil)
//        print("アラート表示成功！！")
//    }
//
//
//    //シェアボタン
//    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
//        //シェアする画像の選択
//        let shareImage = imageView.image!
//        //一緒にのせるコメント
//        let shareText = memoTextView.text!
//        //シェアする画像とコメントの準備
//        let activityItems: [Any] = [shareText,shareImage]
//
//        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//
//        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
//
//        activityViewController.excludedActivityTypes = excludedActivityTypes
//
//        present(activityViewController, animated: true, completion: nil)
//    }
//}
//
//

//import UIKit
//
//
//class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet weak var memoTextView: UITextView!
//    @IBOutlet weak var imageView: UIImageView!
//
//    var selectedRow:Int!
//    var selectedMemo : String!
//
//    let saveData: UserDefaults = UserDefaults.standard
//
////    //カメラボタンがタップされた時の処理
////    @IBAction func launchCamera(_ sender: UIBarButtonItem) {
////        let camera = UIImagePickerController.SourceType.camera
////        if UIImagePickerController.isSourceTypeAvailable(camera) {
////            let picker = UIImagePickerController()
////            picker.sourceType = camera
////            picker.delegate = self
////            self.present(picker, animated: true)
////        }
////    }
//
//    //ユーザーが撮影し終わった時の処理
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        self.imageView.image = image
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        self.dismiss(animated: true)
//        UserDefaults.standard.set(image, forKey: "saveImage")
//        saveData.synchronize()
//    }
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        memoTextView.text = selectedMemo
//        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
//        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
//        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
//        // スペーサー
//        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//        // 閉じるボタン
//        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
//        kbToolBar.items = [spacer, commitButton]
//        memoTextView.inputAccessoryView = kbToolBar
//
//        let imageData:NSData = UserDefaults.standard.object(forKey: "saveImage") as! NSData
//        imageView.image = UIImage(data: imageData as Data)
////        imageView = saveData.object(forKey: "MemoImage") as! UIImageView
//    }
//
//    @objc func commitButtonTapped() {
//        self.view.endEditing(true)
//    }
//
//    //画面遷移する時にタップするボタン（保存）
//    @IBAction func save(_ sender: Any) {
//
//        let inputText = memoTextView.text
//        let ud = UserDefaults.standard
//        if ud.array(forKey: "memoArray") != nil{
//            //saveMemoArrayに取得
//            var saveMemoArray = ud.array(forKey: "memoArray") as! [String]
//                //テキストに何か書かれているか？
//            if inputText != ""{
//                //配列に追加
//                saveMemoArray[selectedRow] = inputText!
//                ud.set(saveMemoArray, forKey: "memoArray")
//            }else{
//                showAlert(title: "何も入力されていません")
//
//            }
//
//        }else{
//            //最初、何も書かれていない場合
//            var newMemoArray = [String]()
//            //nilを強制アンラップはエラーが出るから
//            if inputText != ""{
//                //inputtextはoptional型だから強制アンラップ
//                newMemoArray.append(inputText!)
//                ud.set(newMemoArray, forKey: "memoArray")
//            }else{
//                showAlert(title: "何も入力されていません")
//            }
//        }
//        showAlert(title: "保存完了")
//        ud.synchronize()
//    }
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
//    //削除ボタン
//    @IBAction func deleteMemo(_ sender: Any) {
//        let ud = UserDefaults.standard
//        if ud.array(forKey: "memoArray") != nil{
//            var saveMemoArray = ud.array(forKey: "memoArray") as![String]
//            saveMemoArray.remove(at: selectedRow)
//            ud.set(saveMemoArray, forKey: "memoArray" )
//            ud.synchronize()
//            //画面遷移
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
//
//    //シェアボタン
//    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
//        let activitycontroller = UIActivityViewController(activityItems: [memoTextView], applicationActivities: nil)
//
//        self.present(activitycontroller, animated: true, completion: nil)
//    }
//
//}






















import UIKit


class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!

    var selectedRow: Int!
    var selectedMemo : String!
//    var selectedImageRow: UIImage!
    var selectedImageMemo: UIImage!

    let saveData: UserDefaults = UserDefaults.standard
    let ud = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.text = selectedMemo
        imageView.image = selectedImageMemo
        
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
        kbToolBar.items = [spacer, commitButton]
        memoTextView.inputAccessoryView = kbToolBar
        
//        var addImage: UIImage = imageView.image!
//
//        addImage = ud.image(forKey: "MemoImage")
//
//        imageView.image = addImage

//        let imageData:NSData = UserDefaults.standard.object(forKey: "memoImageArray") as! NSData
//        imageView.image = UIImage(data: imageData as Data)
//        imageView = saveData.object(forKey: "MemoImage") as! UIImageView
    }

    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }

    //画面遷移する時にタップするボタン（保存）
    @IBAction func save(_ sender: Any) {

        let inputText = memoTextView.text
        let ud = UserDefaults.standard
        if ud.array(forKey: "memoArray") != nil{
            //saveMemoArrayに取得
            var saveMemoArray = ud.array(forKey: "memoArray") as! [String]
            
                //テキストに何か書かれているか？
            if inputText != ""{
                //配列に追加
                saveMemoArray[selectedRow] = inputText!
                ud.set(saveMemoArray, forKey: "memoArray")
            }else{
                showAlert(title: "何も入力されていません")

            }

        }else{
            //最初、何も書かれていない場合
            var newMemoArray = [String]()
            //nilを強制アンラップはエラーが出るから
            if inputText != ""{
                //inputtextはoptional型だから強制アンラップ
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
    //削除ボタン
    @IBAction func deleteMemo(_ sender: Any) {
        let ud = UserDefaults.standard
        if ud.array(forKey: "memoArray") != nil{
            var saveMemoArray = ud.array(forKey: "memoArray") as![String]
            saveMemoArray.remove(at: selectedRow)
            ud.set(saveMemoArray, forKey: "memoArray" )
            ud.synchronize()
            //画面遷移
            self.navigationController?.popViewController(animated: true)
        }
    }

    //シェアボタン
//    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
//        let activitycontroller = UIActivityViewController(activityItems: [memoTextView], applicationActivities: nil)
//
//        self.present(activitycontroller, animated: true, completion: nil)
//    }
    
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        let controller = UIActivityViewController(activityItems: [imageView.image!, memoTextView.text!], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)

    }
    
}

extension UserDefaults {
    
    // 保存したいUIImage, 保存するUserDefaults, Keyを取得
    func setUIImageToData(image: UIImage, forKey: String) {
        // UIImageをData型へ変換
        let nsdata = image.pngData()
        // UserDefaultsへ保存
        self.set(nsdata, forKey: "MemoImage")
    }

    // 参照するUserDefaults, Keyを取得, UIImageを返す
    func image(forKey: String) -> UIImage {
        // UserDefaultsからKeyを基にData型を参照
        let data = self.data(forKey: "MemoImage")
        // UIImage型へ変換
        let returnImage = UIImage(data: data!)
        // UIImageを返す
        return returnImage!
    }
    
}
