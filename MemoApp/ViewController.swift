////
////  ViewController.swift
////  MemoApp
////
////  Created by 吉川椛 on 2019/11/21.
////  Copyright © 2019 com.litech. All rights reserved.
////
//
//import UIKit
//
//
//class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
//
//    @IBOutlet weak var memoTableView: UITableView!
////    @IBOutlet weak var cellLabel: UILabel!
//
//    var image: UIImage!
//    var saveArray: Array = [NSData]()
//    var memoArray = [String]()
//
//    let ud = UserDefaults.standard
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableView.reloadData()
//        return memoArray.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! TableViewCell
////        cell.textLabel?.textAlignment = .right
////        cell.textLabel?.text = memoArray[indexPath.row]
////        cellLabel.text = memoArray[indexPath.row]
//        cell.cellLabel.text = memoArray[indexPath.row]
//        //data型にキャストしてUIImageとして取り出す
//        cell.cellImage.image = UIImage(data: saveArray[indexPath.row] as Data)
//        cell.cellImage.frame = CGRect(x: 0, y: 1, width: cell.bounds.size.height - 2, height: cell.bounds.size.height - 2)
//        cell.cellImage.contentMode = .scaleAspectFill
//        cell.cellImage.clipsToBounds = true
//
//        tableView.reloadData()
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "toDetail", sender: nil)
//        //押したら押した状態を解除
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        memoTableView.delegate = self
//        memoTableView.dataSource = self
//
//        memoTableView.reloadData()
//    }
//
//
//    //追加
//    func sendSaveImage() {
//        //NSData型にキャスト
//        let data = image.pngData() as NSData?
//        if let imageData = data {
//            saveArray.append(imageData)
//
//            ud.set(saveArray, forKey: "saveImage")
//            ud.synchronize()
//        }
//    }
//
//    //追加
//    func defaultsArray() {
//        //UserDefaultsの中身が空でないことを確認
//        if ud.object(forKey: "saveImage") != nil {
//            let objects = ud.object(forKey: "saveImage") as? NSArray
//            //配列としてUserDefaultsに保存した時の値と処理後の値が変わってしまうのでremoveAll()
//            saveArray.removeAll()
//            for data in objects! {
//                saveArray.append(data as! NSData)
//            }
//        }
//        memoTableView.reloadData()
//    }
//
////    func deleteShowAlert() {
////        let alert = UIAlertController(title: "確認",
////                                      message: "画像を削除してもいいですか？",
////                                      preferredStyle: .alert)
////        let okButton = UIAlertAction(title: "OK",
////                                     style: .default,
////                                     handler:{(action: UIAlertAction) -> Void in
////        })
////        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
////
////        // アラートにボタン追加
////        alert.addAction(okButton)
////        alert.addAction(cancelButton)
////
////        // アラート表示
////        present(alert, animated: true, completion: nil)
////    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        loadMemo()
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //destinationのクラッシュ防ぐ
//        if segue.identifier == "toDetail"{
//            //detailViewControllerを取得
//            //as! DetailViewControllerでダウンキャストしている
//            let detailViewController = segue.destination as! DetailViewController
//            //遷移前に選ばれているCellが取得できる
//            let selectedIndexPath = memoTableView.indexPathForSelectedRow!
//            detailViewController.selectedMemo = memoArray[selectedIndexPath.row]
//            detailViewController.selectedRow = selectedIndexPath.row
//        }
//    }
//    func loadMemo(){
//        if ud.array(forKey: "memoArray") != nil{
//            //取得 またas!でアンラップしているのでnilじゃない時のみ
//            memoArray = ud.array(forKey: "memoArray") as![String]
//            //reloadしてくれる
//            memoTableView.reloadData()
//        }
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        //アラート表示
////        deleteShowAlert()
//
//
//        if editingStyle == .delete {
//
//            //resultArray内のindexPathのrow番目をremove（消去）する
//            memoArray.remove(at: indexPath.row)
//
//            //再びアプリ内に消去した配列を保存
//            ud.set(memoArray, forKey: "memoArray")
//
//
//            //tableViewを更新
//            memoTableView.reloadData()
//        }
//    }
//}

//ホーム画面
import UIKit



class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var memoTableView: UITableView!

//    var memoArray = [String]()

    let ud = UserDefaults.standard
    
    let saveData: UserDefaults = UserDefaults.standard
    
    var deleteNakami = [String]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemonoNakami.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        cell.textLabel?.text = MemonoNakami[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        //押したら押した状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        //追加画面で入力した内容を取得する
        if UserDefaults.standard.object(forKey: "TodoList") != nil {
            MemonoNakami = UserDefaults.standard.object(forKey: "TodoList") as! [String]
        }
//        memoTableView.delegate = self
//        memoTableView.dataSource = self
        memoTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadMemo()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //destinationのクラッシュ防ぐ
        if segue.identifier == "toDetail"{
            //detailViewControllerを取得
            //as! DetailViewControllerでダウンキャストしている
            let detailViewController = segue.destination as! DetailViewController
            //遷移前に選ばれているCellが取得できる
            let selectedIndexPath = memoTableView.indexPathForSelectedRow!
            detailViewController.selectedMemo = MemonoNakami[selectedIndexPath.row]
            detailViewController.selectedRow = selectedIndexPath.row
        }
    }
    func loadMemo(){
        if ud.array(forKey: "memoArray") != nil{
            //取得 またas!でアンラップしているのでnilじゃない時のみ
            MemonoNakami = ud.array(forKey: "memoArray") as![String]
            //reloadしてくれる
            memoTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
//            saveData.set(deleteNakami, forKey: "deleteMemo")
            //resultArray内のindexPathのrow番目をremove（消去）する
            MemonoNakami.remove(at: indexPath.row)

            //再びアプリ内に消去した配列を保存
            ud.set(MemonoNakami, forKey: "memoArray")

            //tableViewを更新
            tableView.reloadData()
        }
    }
}
