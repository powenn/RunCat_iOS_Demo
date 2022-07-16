//
//  AppDelegate.swift
//  Menubar RunCat
//
//  Created by Takuto Nakamura on 2019/08/06.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//
// Some modifications by powen on 2022/07/16

import Foundation
import SwiftUI

class Cat:ObservableObject {
    private init() {}
    static let shared = Cat()
    
    var frames = [Image]()
    var cnt: Int = 0
    var isRunning: Bool = false
    var interval: Double = 1.0
    let cpu = CPU()
    var cpuTimer: Timer? = nil
    var usage: (value: Double, description: String) = (0.0, "")
    
    @Published var CurrentFrame:Image = Image("")
    @Published var CurrentCPU_UsageTitle:String = ""
    
    @AppStorage("cat.preference.showusage") var showUsage = true
    @AppStorage("cat.preference.usecustomspeed") var useCustomSpeed = false
    @AppStorage("cat.preference.currentcustomspeed") var CurrentCustomSpeed = 0.0
    
    
    func afterAppear() {
        for i in (0 ..< 5) {
            frames.append(Image("cat_page\(i)"))
        }
        CurrentFrame = frames[cnt]
        cnt = (cnt + 1) % frames.count
        
        startRunning()
        animate()

    }
    
    func afterDisapper() {
        stopRunning()
    }
    
    
    func startRunning() {
        if self.useCustomSpeed == false {
            cpuTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (t) in
                self.usage = self.cpu.usageCPU()
                self.interval = 0.02 * (100 - max(0.0, min(99.0, self.usage.value))) / 6
                self.CurrentCPU_UsageTitle = self.showUsage ? self.usage.description : ""
            })
            
        } else {
            cpuTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (t) in
                self.usage = self.cpu.usageCPU()
                self.interval = 0.02 * (100 - max(0.0, min(99.0, self.CurrentCustomSpeed))) / 6
                self.CurrentCPU_UsageTitle = self.showUsage ? self.usage.description : ""
            })
        }
        cpuTimer?.fire()
        isRunning = true
//        animate()
    }
    
    
    func stopRunning() {
        isRunning = false
        cpuTimer?.invalidate()
    }
    
    func animate() {
        CurrentFrame = frames[cnt]
        cnt = (cnt + 1) % frames.count
        if !isRunning { return }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + interval) {
            self.animate()
        }
    }
    
    func Apply() {
        stopRunning()
        startRunning()
    }
}
