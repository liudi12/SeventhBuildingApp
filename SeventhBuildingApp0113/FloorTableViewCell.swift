//
//  FloorTableViewCell.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/21.
//

import UIKit

class FloorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet var toiletMarks: [UIImageView]!
    @IBOutlet var classButtons: [UIButton]!
    @IBOutlet var classLabels: [UILabel]!
    @IBOutlet var classNameLabels: [UILabel]!
    @IBAction func tappedClassButton(_ sender: UIButton) {
        // 3. 発動する。引数が必要であれば渡す
        deledele?.catchData(row: sender.tag)
    }
    // 2. 1を deledele という名前の変数にする
    var deledele: CatchProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let x = contentView.frame.origin.x + contentView.frame.size.width - 100
        let y = contentView.frame.origin.y + contentView.frame.size.height - 80
        let imageView = UIImageView.init(frame: CGRect(x: x, y: y, width: 58, height: 80))
        imageView.image = UIImage(named: "ima")
        self.contentView.addSubview(imageView)
        imageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state
        super.setSelected(selected, animated: animated)
        
    }
}

protocol CatchProtocol {
    func catchData(row: Int)
}
