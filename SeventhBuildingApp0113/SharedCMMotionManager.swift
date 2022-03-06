//
//  SharedCMMotionManager.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/08/22.
//

import CoreMotion

class SharedCMMotionManager {
    
    static let shared = SharedCMMotionManager().manager
    
    private let manager: CMMotionManager
    private init(){
        manager = CMMotionManager()
    }
}
