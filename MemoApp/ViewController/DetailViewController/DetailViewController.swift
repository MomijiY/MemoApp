//
//  DetailViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/21.
//  Copyright © 2019 com.litech. All rights reserved.
//


import UIKit
import SwiftyTesseract
import ImageViewer

final class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GalleryItemsDataSource {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titletextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var selectPictureButton: UIButton!
    @IBOutlet weak var swiftyTesseButton: UIButton!
//    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // MARK: Properties
    
    private let model = UserDefaultsModel()
    private var memo: Memo!
    let swiftyTesseract = SwiftyTesseract(language: RecognitionLanguage.japanese)
    var galleryItem: GalleryItem!
    
    // MARK: Lifecycle

    static func instance(_ memo: Memo) -> DetailViewController {
        let vc = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateInitialViewController() as! DetailViewController
        vc.memo = memo
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
        titletextField.inputAccessoryView = kbToolBar
        contentTextView.inputAccessoryView = kbToolBar
        configureUI()
        
        let image = model.loadImage(id: memo.id)
        galleryItem = GalleryItem.image{ $0(image) }
        
        // 画像をタップしたら拡大
        imageView.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
        imageView.addGestureRecognizer(recognizer)
        
    }
    
    @objc func onTap(_ sender: UIImageView) {
        let galleryViewController = GalleryViewController(startIndex: 0, itemsDataSource: self, configuration: [.deleteButtonMode(.none), .seeAllCloseButtonMode(.none), .thumbnailsButtonMode(.none)])
        self.present(galleryViewController, animated: true, completion: nil)
    }

    // MARK: GalleryItemsDataSource
    func itemCount() -> Int {
        return 1
    }

    func provideGalleryItem(_ index: Int) -> GalleryItem {
        return galleryItem
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
                        galleryItem = GalleryItem.image{ $0(image) }
        }
    
    
//        @IBAction func tappedSaveButton(sender: UIBarButtonItem) {
//            saveMemo()
//        }
//        シェアボタン
        @IBAction func showActivityView(_ sender: UIBarButtonItem) {
            let activitycontroller = UIActivityViewController(activityItems: [titletextField, contentTextView,imageView], applicationActivities: nil)
    
            self.present(activitycontroller, animated: true, completion: nil)
        }
    
//    @IBAction func SaveButton(_  sender: UIButton) {
//        saveMemo()
//    }
    
    @objc private func onTapSaveButton(_ sender: UIBarButtonItem) {
        saveMemo()
    }
    
    func showAlert(title:String){
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
            alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
    
            self.present(alert, animated: true, completion:nil)
        }
    
}

// MARK: - Configure

extension DetailViewController {

    private func configureUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onTapSaveButton(_:)))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0/255, green: 145/255, blue: 147/255, alpha: 1.0)
        takePictureButton.layer.cornerRadius = 10
        selectPictureButton.layer.cornerRadius = 10
        swiftyTesseButton.layer.cornerRadius = 10
        swiftyTesseButton.backgroundColor = UIColor(red: 0/255, green: 145/255, blue: 147/255, alpha: 1.0)
        // - Label
        titletextField.text = memo.title
        contentTextView.text = memo.content
        // - ImageView
        if let image = model.loadImage(id: memo.id) {
            imageView.image = image
        }
    }

}
extension DetailViewController {
    
    private func saveMemo() {
        guard let title = titletextField.text,
            let content = contentTextView.text else { return }
        
        // Save memo
//        let memo = Memo(id: self.memo.id, title: title, content: content)
        let memo = Memo(id: self.memo.id, title: title, content: content, color: self.memo.color)
        if let storedMemos = model.loadMemos() {
            var newMemos = storedMemos
            
            //追記　同じIDのメモがある場合データを差し替える処理
            for (i, m) in newMemos.enumerated() {
                if m.id == memo.id {
                    newMemos[i] = memo
                }
            }
            
            //newMemos.append(memo)
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
    
//        //削除ボタン
//        func deleteMemo() {
//
//            }
}

//
//import UIKit
//
//
//class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet weak var memoTextView: UITextView!
//    @IBOutlet weak var imageView: UIImageView!
//
//    var selectedRow: Int!
//    var selectedMemo : String!
////    var selectedImageRow: UIImage!
//    var selectedImageMemo: UIImage!
//
//    let saveData: UserDefaults = UserDefaults.standard
//    let ud = UserDefaults.standard
//
//    func readimage() -> UIImage?  {
//            let documentsURL:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let fileURL:URL = documentsURL.appendingPathComponent("image.png")
//            return UIImage(contentsOfFile: fileURL.path)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        memoTextView.text = selectedMemo
//
//        imageView.image = ud.object(forKey: "MemoImageKey") as? UIImage
//
//        if let image:UIImage = readimage(){
//                imageView.image = image
//        }
//
////        MemoImageNakami = [ud.image(forKey: "MemoImage")]
////        imageView.image = selectedImageMemo
//
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
////        var addImage: UIImage = imageView.image!
////
////        addImage = ud.image(forKey: "MemoImage")
////
////        imageView.image = addImage
//
////        let imageData:NSData = UserDefaults.standard.object(forKey: "memoImageArray") as! NSData
////        imageView.image = UIImage(data: imageData as Data)
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
//
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
//
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
////    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
////        let activitycontroller = UIActivityViewController(activityItems: [memoTextView], applicationActivities: nil)
////
////        self.present(activitycontroller, animated: true, completion: nil)
////    }
//
//    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
//        let controller = UIActivityViewController(activityItems: [imageView.image!, memoTextView.text!], applicationActivities: nil)
//        self.present(controller, animated: true, completion: nil)
//
//    }
//
//}
//
////extension UserDefaults {
////
////    // 保存したいUIImage, 保存するUserDefaults, Keyを取得
////    func setUIImageToData(image: UIImage, forKey: String) {
////        // UIImageをData型へ変換
////        let nsdata = image.pngData()
////        // UserDefaultsへ保存
////        self.set(nsdata, forKey: "MemoImage")
////    }
////
////    // 参照するUserDefaults, Keyを取得, UIImageを返す
////    func image(forKey: String) -> UIImage {
////        // UserDefaultsからKeyを基にData型を参照
////        var data = self.data(forKey: "MemoImage")
////        // UIImage型へ変換
////        let returnImage = UIImage(data: data!)
////        // UIImageを返す
////        return returnImage!
////    }
////
////}
