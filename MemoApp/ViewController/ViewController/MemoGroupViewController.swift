//
//  MemoGroupViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/22.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

final class MemoListViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    private let model = UserDefaultsModel()
    private var dataSource: [MemoGroup] = [MemoGroup]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print([MemoGroup]())
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMemos()
    }
    
    @IBAction func tapTutorialButton(_ sender: UIBarButtonItem) {
        let vc = PageViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Configure
extension MemoListViewController {
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = MemoGroupTableViewCell.rowHeight
        tableView.register(MemoGroupTableViewCell.nib, forCellReuseIdentifier: MemoGroupTableViewCell.reuseIdentifier)
    }
}

// MARK: - Model
extension MemoListViewController {
    
    private func loadMemos() {
        guard let memos = model.loadGroupMemos() else { return }
        self.dataSource = memos
    }
}

// MARK: - TableView dataSource, delegate
extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoGroupTableViewCell.reuseIdentifier, for: indexPath) as! MemoGroupTableViewCell
        let memo = dataSource[indexPath.row]
        cell.setupCell(group: memo.groupTitle, groupcontent: memo.groupContent)
        return cell
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            self.performSegue(withIdentifier: "toMemo", sender: nil)
        }
        //セルの削除許可を設定
        func tableView(_ tableView: UITableView,canEditRowAt indexPath: IndexPath) -> Bool{
            return true
        }
        
        //　スワイプで削除する関数
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let groupStoredMemosKey: String = "groupStoredMemosKey"
            if editingStyle == UITableViewCell.EditingStyle.delete {
                
                //メモ削除
                dataSource.remove(at: indexPath.row)
                guard let data = try? JSONEncoder().encode(dataSource) else { return }
                UserDefaults.standard.set(data, forKey: groupStoredMemosKey)

                self.tableView.reloadData()
            }
        }

}
