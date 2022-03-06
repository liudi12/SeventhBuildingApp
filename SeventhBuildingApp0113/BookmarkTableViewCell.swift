//
//  BookmarkTableViewCell.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/22.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func tappedUpdateButton(_ sender: UIButton) {
        jumpdele?.jumpEdit(index: sender.tag)
    }
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        jumpdele?.delete(index: sender.tag)
    }
    @IBAction func tappedInfoButton(_ sender: UIButton) {
        jumpdele?.jumpInfo(index: sender.tag)
    }
    
    var jumpdele: BookmarkProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol BookmarkProtocol {
    func jumpEdit(index: Int)
    func delete(index: Int)
    func jumpInfo(index: Int)
}
