//
//  TableViewCell.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/04.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: IBOutlet

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var tagColor: UILabel!
    // MARK: Static properties

    static let reuseIdentifier = "TableViewCell"
    static let rowHeight: CGFloat = 60
    // 正しいファイルを読み込むように引数nibNameに渡す文字列を変更.
    static var nib: UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }

    // MARK: Overrides

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Setup

    func setupCell(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
    func tagColor(color: UIColor) {
        if tagColorUI == UIColor.red {
            tagColor.backgroundColor = UIColor.red
        }
        else if tagColorUI == UIColor.orange {
            tagColor.backgroundColor = UIColor.orange
        }
        else if tagColorUI == UIColor.yellow {
            tagColor.backgroundColor = UIColor.yellow
        }
        else if tagColorUI == UIColor.systemTeal {
            tagColor.backgroundColor = UIColor.systemTeal
        }
        else if tagColorUI == UIColor.blue {
            tagColor.backgroundColor = UIColor.blue
        }
        else if tagColorUI == UIColor.green {
            tagColor.backgroundColor = UIColor.green
        }
        else if tagColorUI == UIColor.purple {
            tagColor.backgroundColor = UIColor.purple
        }
        else if tagColorUI == UIColor.brown {
            tagColor.backgroundColor = UIColor.brown
        }
        else if tagColorUI == UIColor.black {
            tagColor.backgroundColor = UIColor.black
        }
    }
}
