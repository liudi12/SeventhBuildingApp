//
//  InfoViewController.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/21.
//

import UIKit
import RealmSwift

class InfoViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameEngLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var heartImage: UIImageView! {
        didSet {
            heartImage.image = UIImage(named: "heart1")
        }
    }
   
    var tappedRow: Int = 0
    var isMarked = false
    let realm = try! Realm()
    var infoData: Results<Info>!
    var isChecked = false
    var floor = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        infoData = realm.objects(Info.self).filter("_id == \(tappedRow)")
        nameLabel.text = infoData[0].name
        nameEngLabel.text = infoData[0].name_eng
        introLabel.text = infoData[0].intro
        isChecked = infoData[0].isChecked
        isMarked = infoData[0].isMarked
        let tappedFloor = 10 - (Int)(infoData[0]._id / 10)
        if isChecked || floor != tappedFloor {
            checkInButton.isUserInteractionEnabled = false;
            checkInButton.alpha = 0.3;
        }
        if isMarked {
            heartImage.image = UIImage(named: "heart2")
        }
    }
    
    //戻るボタン
    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //ハートバタン
    @IBAction func tappedHeartButton(_ sender: UIButton) {
        if isMarked {
            heartImage.image = UIImage(named: "heart1")
            isMarked = false
        } else {
            heartImage.image = UIImage(named: "heart2")
            isMarked = true
        }
    }
    
    //ブックマーク保存
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMarked {
            do{
              try realm.write{
                infoData[0].isMarked = true
              }
            }catch {
              print("Error \(error)")
            }
        } else {
            do{
              try realm.write{
                infoData[0].isMarked = false
              }
            }catch {
              print("Error \(error)")
            }
        }
    }
    
    //チェクイン(最初の一回だけ）
    @IBAction func tappedCheckInButton(_ sender: UIButton) {
        do{
          try realm.write{
            infoData[0].isChecked = true
          }
        }catch {
          print("Error \(error)")
        }
        checkInButton.isUserInteractionEnabled = false;
        checkInButton.alpha = 0.3;
    }
}
