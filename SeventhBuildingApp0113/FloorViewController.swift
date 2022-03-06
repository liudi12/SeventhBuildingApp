//
//  FloorViewController.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/07/08.
//

import UIKit
import CoreMotion
import RealmSwift

class FloorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CatchProtocol{
        
    @IBOutlet weak var floorTableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var tappedRow = 0
    let url = "https://api.openweathermap.org/data/2.5/onecall"
    var weather: Weather?
    var pressure0 = 0.0
    var temp = 0.0
    var altimeter: CMAltimeter?
    var floor = 8
    let realm = try! Realm()
    let ids:[Int] = [1, 21, 31, 33, 41, 51, 61, 71, 72, 73, 92, 101, 112]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        floorTableView.register(UINib(nibName: "FloorTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        //海面気圧(P0)と気温取得
        guard var urlComponents = URLComponents(string: url) else {
            print("エラーの内容")
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "35.698898"),
            URLQueryItem(name: "lon", value: "139.696823"),
//            URLQueryItem(name: "lat", value: "35.724125"),自宅
//            URLQueryItem(name: "lon", value: "139.59436"),
            URLQueryItem(name: "lang", value: "ja"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: "6e142c3a03b3f88cab83efac3e682889")
        ]
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            if error != nil{
                print("情報の取得に失敗した：", error!)
                return
            }
            if let data = data {
                do {
                    self.weather = try JSONDecoder().decode(Weather.self, from: data)
                    print(self.weather!)
                } catch(let err) {
                    print("情報の取得に失敗しました：", err)
                }
                // データを取得
                DispatchQueue.main.async {
                    self.temp = self.weather?.current.temp ?? 0
                    self.pressure0 = self.weather?.current.pressure ?? 0
                }
            }
        }
        task.resume()
        
        //気圧取得
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter = CMAltimeter()
            altimeter!.startRelativeAltitudeUpdates(to: OperationQueue.current!) { (data, error) in
                if error == nil {
                    if data != nil {
                        let p = Double(truncating: data!.pressure)
                        let correction = 10.0
                        let pressure = p * correction
                        print("気圧：\(pressure)")
                        let height = ((pow((self.pressure0 / pressure), (1/5.257)) - 1) * (self.temp + 273.15)) / 0.0065
                        print("高さ：\(height)")
                        //階層表示
                        self.floor = (Int)(height - 34) / 3
//                        print("floor:\(self.floor)")
//                        self.floor = 8
                        if self.floor == 0 {
                            self.messageLabel.text = "今B1階にいます！"
                        } else if self.floor <= -1 {
                            self.messageLabel.text = "今B2階にいます！"
                        } else {
                            self.messageLabel.text = "今\(self.floor)階にいます！"
                        }
                    } else {
                        print("data is nil")
                    }
                } else {
                    print(error!)
                }
            }
        } else {
            print("高度が取得できません")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! FloorTableViewCell
        
        var floorNo = "0"
        if indexPath.row == 10 {
            floorNo = "B1"
        } else if indexPath.row == 11 {
            floorNo = "B2"
        } else if indexPath.row > 0 {
            floorNo = "\(10 - indexPath.row)"
        }
        
        if floorNo == "0" {
            cell.floorLabel.text = "10"
        } else {
            cell.floorLabel.text = "\(floorNo)"
        }
        
        cell.classButtons[0].tag = indexPath.row * 10 + 1
        cell.classButtons[1].tag = indexPath.row * 10 + 2
        cell.classButtons[2].tag = indexPath.row * 10 + 3
//        cell.classButtons[0].tag = indexPath.row
//        cell.classButtons[1].tag = indexPath.row
//        cell.classButtons[2].tag = indexPath.row
        cell.classNameLabels[0].text = findNameById(id: indexPath.row * 10 + 1)
        cell.classNameLabels[1].text = findNameById(id: indexPath.row * 10 + 2)
        cell.classNameLabels[2].text = findNameById(id: indexPath.row * 10 + 3)
        cell.classLabels[0].text = "7\(floorNo)1"
        cell.classLabels[1].text = "7\(floorNo)2"
        cell.classLabels[2].text = "7\(floorNo)3"
        
        if indexPath.row < 5 {
            if indexPath.row % 2 == 0 {
                cell.toiletMarks[0].image = UIImage(named: "female")
                cell.toiletMarks[1].image = nil
            } else {
                cell.toiletMarks[0].image = UIImage(named: "male")
                cell.toiletMarks[1].image = nil
            }
        } else {
            cell.toiletMarks[0].image = UIImage(named: "female")
            cell.toiletMarks[1].image = UIImage(named: "male")
        }
        
        cell.deledele = self
        return cell
    }
    
    // 2. デリゲートメソッド。宣言したときのエラーで fix 押したら作られる
    func catchData(row: Int) {
        tappedRow = row
        if ids.contains(row) {
            self.performSegue(withIdentifier: "toInfo", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toInfo") {
           let infoVC: InfoViewController = (segue.destination as? InfoViewController)!
            infoVC.tappedRow = tappedRow
            infoVC.floor = floor
       }
    }
    
    func findNameById(id: Int) -> String {
        if ids.contains(id) {
            let infoData = realm.objects(Info.self).filter("_id == \(id)")
            return infoData[0].name
        } else {
            return ""
        }
    }

}
