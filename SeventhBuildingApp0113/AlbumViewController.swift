//
//  AlbumViewController.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/21.
//

import UIKit
import RealmSwift

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet var stampImageViews: [UIImageView]!
    
    
    let realm = try! Realm()
    let ids:[Int] = [1, 21, 31, 33, 41, 51, 61, 71, 72, 73, 92, 101, 112]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for id in 0..<stampImageViews.count {
            let stamp = stampImageViews[id]
            stamp.isHidden = true
        }

        let infoData = realm.objects(Info.self).filter("isChecked == true")
        let count = infoData.count
        for id in 0..<count {
            let _id = infoData[id]._id
            if let stampId = ids.firstIndex(of: _id) {
                self.stampImageViews[stampId].isHidden = false
            }
        }
        completionLabel.text = "完成度：\(count) / 13"
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
