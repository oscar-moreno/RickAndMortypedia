//
//  ParallaxViewModel.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation
import CoreMotion

class ParallaxVM: ObservableObject {
    @Published var pitch = Double()

    private var manager: CMMotionManager

    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1/60
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }

            if let motionData {
                self.pitch = motionData.attitude.pitch
            }
        }
    }
}
