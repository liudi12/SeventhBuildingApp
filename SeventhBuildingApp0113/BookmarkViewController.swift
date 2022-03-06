//
//  BookmarkViewController.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/21.
//

import UIKit
import RealmSwift

class BookmarkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BookmarkProtocol {

    @IBOutlet weak var bookmarkTableView: UITableView!
    
    let realm = try! Realm()
    var infoData: Results<Info>!
    var cellIndex = -1
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkTableView.register(UINib(nibName: "BookmarkTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        bookmarkTableView.estimatedRowHeight = 44.0
        bookmarkTableView.rowHeight = UITableView.automaticDimension
        infoData = realm.objects(Info.self).filter("isMarked == true")
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! BookmarkTableViewCell
        cell.infoButton.setTitle("\(indexPath.row + 1). \(infoData[indexPath.row].name)", for: .normal)
        cell.commentLabel.text = infoData[indexPath.row].comment
        cell.updateButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        cell.infoButton.tag = indexPath.row
        cell.jumpdele = self
        return cell
    }
    
    func jumpEdit(index: Int) {
        cellIndex = index
        self.performSegue(withIdentifier: "toEdit", sender: nil)
    }
    
    func delete(index: Int) {
        cellIndex = index
        do{
          try realm.write{
            infoData[cellIndex].isMarked = false
          }
        }catch {
          print("Error \(error)")
        }
        bookmarkTableView.reloadData()
    }
    
    func jumpInfo(index: Int) {
        cellIndex = index
        name = infoData[cellIndex].name
        let info = realm.objects(Info.self).filter("name == %@", name)
        cellIndex = info[0]._id
        self.performSegue(withIdentifier: "bookMarkToInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toEdit") {
           let editVC: EditViewController = (segue.destination as? EditViewController)!
            editVC.cellIndex = cellIndex
        } else if (segue.identifier == "bookMarkToInfo") {
            let infoVC: InfoViewController = (segue.destination as? InfoViewController)!
            infoVC.tappedRow = cellIndex
        }
        
    }
    
    //画面更新
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        bookmarkTableView.reloadData()
    }
}
