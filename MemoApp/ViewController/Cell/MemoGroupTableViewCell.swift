//
//  MemoGroupTableViewCell.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/22.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class MemoGroupTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var GroupTitleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    static let reuseIdentifier = "MemoGroupTableViewCell"
    static let rowHeight: CGFloat = 60
    // 正しいファイルを読み込むように引数nibNameに渡す文字列を変更.
    static var nib: UINib {
        return UINib(nibName: "MemoGroupTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(group: String, groupcontent: String) {
        GroupTitleLabel.text = group
        contentLabel.text = groupcontent
    }
    
}
