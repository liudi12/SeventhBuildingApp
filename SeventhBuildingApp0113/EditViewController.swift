//
//  EditViewController.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/22.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cleatButton: UIButton!
    
    var cellIndex = -1
    let realm = try! Realm()
    var infoData: Results<Info>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        infoData = realm.objects(Info.self).filter("isMarked == true")
        nameLabel.text = "\(cellIndex + 1). \(infoData[cellIndex].name)"
        commentTextView.text = infoData[cellIndex].comment
    }

    @IBAction func tappedSaveButton(_ sender: UIButton) {
        do{
          try realm.write{
            infoData[cellIndex].comment = commentTextView.text!
          }
        }catch {
          print("Error \(error)")
        }
        let codeMisAlert = UIAlertController(title: "保存完了", message: nil, preferredStyle: .alert)
        self.present(codeMisAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { self.presentedViewController?.dismiss(animated: false, completion: nil)}
    }
    
    @IBAction func tappedClearButton(_ sender: UIButton) {
        commentTextView.text = ""
    }
    
    @IBAction func tappedBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
