//
//  NewTableViewCell.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/30.
//  Copyright © 2019 com.litech. All rights reserved.
//

import UIKit



class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
//
//    @IBOutlet weak var label: UILabel!
//    @IBOutlet weak var tablecell: UITableViewCell!
    
    let uuid = NSUUID().uuidString

    override func awakeFromNib() {
        super.awakeFromNib()

        let imageData:NSData = UserDefaults.standard.object(forKey: "saveImage") as! NSData
        
        cellImage.image = UIImage(data: imageData as Data)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //ここを追加
    func fill(image: UIImageView, titleLb: String, date: String, siteName: String){
        cellImage.image   = imageView?.image
//    cellTitle.text    = titleLb
//    cellDate.text     = date
//    cellSiteName.text = siteName
    }
    
    // 追加
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image   = imageView?.image
        //画像を初期化
//        cellImage.image = nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
            //画像を初期化
            cellImage.image = nil
            return cell
    }

    
}
