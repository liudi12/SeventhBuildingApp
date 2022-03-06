//
//  LoginViewController.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/07/08.
//

import UIKit
import CoreLocation

class LoginViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var codeTextField: UITextField!
//    @IBOutlet weak var buttonLogin: UIButton!

    var locationManager : CLLocationManager?
    var longitude : Double!
    var latitude : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        codeTextField.placeholder="コード"
        codeTextField.clearButtonMode = .always
        
        //位置情報(前台only)
        locationManager = CLLocationManager()
        locationManager!.delegate = self
//        locationManager!.allowsBackgroundLocationUpdates = true
//        self.locationManager!.pausesLocationUpdatesAutomatically = false
        //ユーザーの使用許可を確認
        locationManager?.requestWhenInUseAuthorization()
        
        //デバイスの位置情報が有効の場合
        if CLLocationManager.locationServicesEnabled() {
            //測位精度（最高に設定）
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.distanceFilter = 10 // 位置情報取得間隔
            locationManager!.activityType = .fitness
            //位置情報の取得開始
            locationManager!.startUpdatingLocation()
        }
    }
    
    @IBAction func tappedButtonLogin(_ sender: UIButton) {
        //今の位置を確認
//        let lon = 139.6966354013261
//        let lat = 35.69900477308712
//        let distanceX = lon - longitude
//        let distanceY = lat - latitude
//        let distance = sqrt(distanceX * distanceX + distanceY *  distanceY)
//        if distance >= 0.001 { //0.00001度＝１m
//            let locationAlert = UIAlertController(title: "7号館内で利用してください", message: nil, preferredStyle: .alert)
//            self.present(locationAlert, animated: true, completion: nil)
//            //2秒後消える
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { self.presentedViewController?.dismiss(animated: false, completion: nil)}
//            return
//        }
        
        if codeTextField.text! == "open2021" {
            self.performSegue(withIdentifier: "toFloor", sender: nil)
        } else {
            let codeMisAlert = UIAlertController(title: "正しいコードを入力してください", message: nil, preferredStyle: .alert)
            self.present(codeMisAlert, animated: true, completion: nil)
            //2秒後消える
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { self.presentedViewController?.dismiss(animated: false, completion: nil)}
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        longitude = location.longitude
        latitude = location.latitude
        print("緯度: ", latitude ?? 0, "経度: ", longitude ?? 0)
    }

}
