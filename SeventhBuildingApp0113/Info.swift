//
//  Info.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/22.
//

import Foundation
import RealmSwift

class Info: Object {
    @objc dynamic var _id = 0
    @objc dynamic var RN = "" //ルームナンバー
    @objc dynamic var isChecked = false
    @objc dynamic var isMarked = false
    @objc dynamic var name = ""
    @objc dynamic var name_eng = ""
    @objc dynamic var intro = ""
    @objc dynamic var comment = ""
    
    override class func primaryKey() -> String? {
        return "_id"
    }
}
