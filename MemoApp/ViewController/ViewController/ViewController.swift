//
//  ViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/21.
//  Copyright © 2019 com.litech. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    let deviceId = UIDevice.current.identifierForVendor!.uuidString

    
    // MARK: Properties
    
    private let model = UserDefaultsModel()
    private var dataSource: [Memo] = [Memo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    static func instance() -> ViewController {
        let vc = UIStoryboard(name: "ViewController", bundle: nil).instantiateInitialViewController() as! ViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMemos()
    }
    
    // MARK: IBAction
    
    @objc private func onTapAddButton() {
        let vc = AddViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func TapAddButton(_ sender: UIBarButtonItem) {
        onTapAddButton()
    }
    
    
    
}

// MARK: - Configure

extension ViewController {
    
//    private func configureUI() {
//        navigationItem.title = "メモ一覧"
//    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = TableViewCell.rowHeight
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
}

// MARK: - Model

extension ViewController {
    
    private func loadMemos() {
        guard let memos = model.loadMemos() else { return }
        self.dataSource = memos
    }
}

// MARK: - TableView dataSource, delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var memoArray = [Memo]()
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
        let memo = dataSource[indexPath.row]
        cell.setupCell(title: memo.title, content: memo.content)
        memoArray.append(memo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let memo = dataSource[indexPath.row]
        let vc = DetailViewController.instance(memo)
        navigationController?.pushViewController(vc, animated: true)
    }
    //セルの削除許可を設定
    func tableView(_ tableView: UITableView,canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //　スワイプで削除する関数
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let kStoredMemosKey: String = "kStoredMemosKey"
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            //画像削除
            let id = dataSource[indexPath.row].id
            UserDefaults.standard.removeObject(forKey: id)
            
            //メモ削除
            dataSource.remove(at: indexPath.row)
            guard let data = try? JSONEncoder().encode(dataSource) else { return }
            UserDefaults.standard.set(data, forKey: kStoredMemosKey)

            self.tableView.reloadData()
        }
    }

}

//import UIKit
//
//final class ViewController: UIViewController {
//
//    // MARK: IBOutlet
//
//    @IBOutlet weak var tableView: UITableView!
//
//    // MARK: Properties
//
//    private let model = UserDefaultsModel()
//    private var dataSource: [Memo] = [Memo]() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//
//    // MARK: Lifecycle
//
//    static func instance() -> ViewController {
//        let vc = UIStoryboard(name: "ViewController", bundle: nil).instantiateInitialViewController() as! ViewController
//        return vc
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//        configureTableView()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        loadMemos()
//    }
//
//    // MARK: IBAction
//
//    @objc
//    private func onTapAddButton(_ sender: UIBarButtonItem) {
//        let vc = AddViewController.instance()
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//// MARK: - Configure
//
//extension ViewController {
//
//    private func configureUI() {
//        navigationItem.title = "メモ一覧"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapAddButton(_:)))
//    }
//
//    private func configureTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
////        print("tableView.delegate = self") OK
//        tableView.tableFooterView = UIView()
////        print("tableView.FooterView = UIView()") OK
//        tableView.rowHeight = TableViewCell.rowHeight
////        print("tableView.rowHeight") OK
//        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
////        print("tableview.regidter(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseIdentifier)") OK
//    }
//}
//
//// MARK: - Model
//
//extension ViewController {
//
//    private func loadMemos() {
//        guard let memos = model.loadMemos() else { return }
//        self.dataSource = memos
////        print("loadMemos") OK
//    }
//}
//
//// MARK: - TableView dataSource, delegate
//
//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        print(dataSource.count) 011
//        return dataSource.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        tableView.register(TableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TableViewCell.self))
////        print("tableView.register(TableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TableViewCell.self))") OK
//        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
////        print("let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell") No
//        let memo = dataSource[indexPath.row]
//        cell.setupCell(title: memo.title, content: memo.content)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let memo = dataSource[indexPath.row]
//        let vc = DetailViewController.instance(memo)
//        navigationController?.pushViewController(vc, animated: true)
//        print("vc animated true")
////        let memo = dataSource[indexPath.row]
////        let vc = DetailViewController.instance(memo)
////        print("詳細のinstance読み込み完了")
////        // セルの選択を解除
////        tableView.deselectRow(at: indexPath, animated: true)
////        print("選択解除完了")
////        // 別の画面に遷移
////        performSegue(withIdentifier: "toDetail", sender: nil)
////        navigationController?.pushViewController(vc, animated: true)
//
//    }
//}
