//
//  ShowGroupViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/22.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

var groupMemoArray = [String]()

final class ShowGroupViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    var checkArray:[IndexPath] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Properties
    
    private let model = UserDefaultsModel()
    let checkColor = UIColor.blue
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
}

// MARK: - Configure
extension ShowGroupViewController {
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = MemoGroupTableViewCell.rowHeight
        tableView.register(MemoGroupTableViewCell.nib, forCellReuseIdentifier: MemoGroupTableViewCell.reuseIdentifier)
    }
}

// MARK: - Model
extension ShowGroupViewController {
    
    private func loadMemos() {
        guard let memos = model.loadGroupMemos() else { return }
        self.dataSource = memos
    }
}

// MARK: - TableView dataSource, delegate
extension ShowGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoGroupTableViewCell.reuseIdentifier, for: indexPath) as! MemoGroupTableViewCell
        let memo = dataSource[indexPath.row]
        groupMemoArray = [memo.groupTitle]
        cell.setupCell(group: memo.groupTitle, groupcontent: memo.groupContent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toAdd", sender: nil)
    }
}
