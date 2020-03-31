//
//  ViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/21.
//  Copyright © 2019 com.litech. All rights reserved.
//

import UIKit

var tagColorUI = UIColor()
let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height
final class ViewController: UIViewController, UISearchResultsUpdating {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var tagRed: UIButton!
    @IBOutlet weak var tagOrange: UIButton!
    @IBOutlet weak var tagYellow: UIButton!
    @IBOutlet weak var tagSkyblue: UIButton!
    @IBOutlet weak var tagBlue: UIButton!
    @IBOutlet weak var tagPurple: UIButton!
    @IBOutlet weak var taggreen: UIButton!
    @IBOutlet weak var tagBrown: UIButton!
    @IBOutlet weak var tagBlack: UIButton!
    @IBOutlet weak var tagWhite: UIButton!
    let deviceId = UIDevice.current.identifierForVendor!.uuidString

    var searchResults:[Memo] = [Memo]()
    var searchController = UISearchController()
    
    // MARK: Properties
    
    private let model = UserDefaultsModel()
    private var dataSource: [Memo] = [Memo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var memo: Memo!
    var changeColortag = Int()
    
    // MARK: Lifecycle
    
    static func instance() -> ViewController {
        let vc = UIStoryboard(name: "ViewController", bundle: nil).instantiateInitialViewController() as! ViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView.isHidden = true
        tableView.tableFooterView = UIView()
        configureUI()
        configureTableView()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false

        tableView.tableHeaderView = searchController.searchBar
        
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
    
    @objc private func onTapTutorialButton() {
        let vc = PageViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func TapAddButton(_ sender: UIBarButtonItem) {
        onTapAddButton()
    }
    
    @IBAction func TapTutorialButton(_ sender: UIBarButtonItem) {
        onTapTutorialButton()
    }
    
    @IBAction func onTapTagRed(_ sender: UIButton) {
        tagColorUI = UIColor.red
        groupView.isHidden = true
        changeColor(color: "red")
    }

    @IBAction func onTapTagOrange(_ sender: UIButton) {
        tagColorUI = UIColor.orange
        groupView.isHidden = true
        changeColor(color: "orange")
    }
    
    @IBAction func onTapTagYellow(_ sender: UIButton) {
        tagColorUI = UIColor.yellow
        groupView.isHidden = true
        changeColor(color: "yellow")
    }
    
    @IBAction func onTapTagSkyblue(_ sender: UIButton) {
        tagColorUI = UIColor.systemTeal
        groupView.isHidden = true
        changeColor(color: "systemTeal")
    }
    
    @IBAction func onTapTagBlue(_ sender: UIButton) {
        tagColorUI = UIColor.blue
        groupView.isHidden = true
        changeColor(color: "blue")
    }
    
    @IBAction func onTapTagGreen(_ sender: UIButton) {
        tagColorUI = UIColor.green
        groupView.isHidden = true
        changeColor(color: "green")
    }
    
    @IBAction func onTapTagPurple(_ sender: UIButton) {
        tagColorUI = UIColor.purple
        groupView.isHidden = true
        changeColor(color: "purple")
    }
    
    @IBAction func onTapTagBrown(_ sender: UIButton) {
        tagColorUI = UIColor.brown
        groupView.isHidden = true
        changeColor(color: "brown")
    }
    
    @IBAction func onTapTagBlack(_ sender: UIButton) {
        tagColorUI = UIColor.black
        groupView.isHidden = true
        changeColor(color: "black")
    }
    @IBAction func onTapTagWhite(_ sender: UIButton) {
        groupView.isHidden = true
        changeColor(color: "white")
    }
    @IBAction func onTapClose(_ sender: UIButton) {
        groupView.isHidden = true
    }
    
    func changeColor(color: String) {
        // Save memo
        let memo = Memo(id: self.memo.id, title: self.memo.title, content: self.memo.content, color: color)
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
            dataSource[changeColortag] = memo
            self.tableView.reloadData()
        } else {
            model.saveMemos([memo])
            self.tableView.reloadData()
        }
        
    }
    
}

// MARK: - Configure

extension ViewController {
    
    private func configureUI() {
        groupView.layer.cornerRadius = 10
        groupView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        groupView.layer.shadowColor = UIColor.black.cgColor
        groupView.layer.shadowOpacity = 0.6
        groupView.layer.shadowRadius = 4

        tagWhite.layer.cornerRadius = 10
        tagWhite.layer.borderWidth = 0.5
        tagWhite.layer.borderColor =  UIColor.black.cgColor
        tagRed.layer.cornerRadius = 10
        tagOrange.layer.cornerRadius = 10
        tagYellow.layer.cornerRadius = 10
        tagSkyblue.layer.cornerRadius = 10
        tagBlue.layer.cornerRadius = 10
        taggreen.layer.cornerRadius = 10
        tagPurple.layer.cornerRadius = 10
        tagBrown.layer.cornerRadius = 10
        tagBlack.layer.cornerRadius = 10
    }
    
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
//        if searchController.isActive {
//            return searchResults.count
//        }else {
//            return dataSource.count
//        }
        print("searchResults.count: \(searchResults.count)")
        if searchController.searchBar.text?.count != 0 {
            return searchResults.count
        }else {
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var memoArray = [Memo]()
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
        if searchResults.count != 0 {
            let memo = searchResults[indexPath.row]
            if searchController.isActive {
                cell.setupCell(title: memo.title, content: memo.content)
            } else {
                cell.setupCell(title: memo.title, content: memo.content)
            }
            
            cell.tagColor(color: memo.color)
            
            memoArray.append(memo)
        } else {
            let memo = dataSource[indexPath.row]
            if searchController.isActive {
                cell.setupCell(title: memo.title, content: memo.content)
                print(dataSource.count)
            } else {
                cell.setupCell(title: memo.title, content: memo.content)
            }
            
            cell.tagColor(color: memo.color)
            
            memoArray.append(memo)
        }
//        let memo = dataSource[indexPath.row]
//        if searchController.isActive {
//            cell.setupCell(title: memo.title, content: memo.content)
//            print(dataSource.count)
////            cell.textLabel!.text = "\(searchResults[indexPath.row])"
//        } else {
//            cell.setupCell(title: memo.title, content: memo.content)
//        }
//
//        cell.tagColor(color: memo.color)
//
//        memoArray.append(memo)
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
    
    // 文字が入力される度に呼ばれる
    func updateSearchResults(for searchController: UISearchController) {
        print("searchController.searchBar.text?: \(searchController.searchBar.text)")
        searchResults = [Memo]()
        //let kStoredMemosKey: String = "kStoredMemosKey"
        if searchController.searchBar.text?.count != 0 {
            for (i, memo) in dataSource.enumerated() {
                if memo.title.contains(searchController.searchBar.text!.lowercased()) {
                    print("searchController.searchBar.text?")
                    searchResults.append(dataSource[i])
                }
            }
//            self.searchResults = [kStoredMemosKey.filter{
//                       // 大文字と小文字を区別せずに検索
//                       $0.lowercased().contains(searchController.searchBar.text!.lowercased())
//                       }]
            self.tableView.reloadData()
        } else {
            self.tableView.reloadData()
        }
       
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
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "タグ") { (ctxAction, view, completionHandler) in
            self.groupView.isHidden = false
            completionHandler(true)
        }
        changeColortag = indexPath.row
        self.memo = dataSource[indexPath.row]
        return UISwipeActionsConfiguration(actions: [action])
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
