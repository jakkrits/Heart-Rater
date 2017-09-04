//
//  ViewController.swift
//  HeartRater
//
//  Created by Jakkrits on 10/24/2558 BE.
//  Copyright © 2558 AppIllus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HeartRateDelegate {
    
    @IBOutlet weak var heartRateView: KDCircularProgress!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var sensorNameLabel: UILabel!
    @IBOutlet weak var batteryStatusLabel: UILabel!
    @IBOutlet weak var chainIconView: ChainIcon!
    @IBOutlet weak var watchIconView: WatchIcon!
    @IBOutlet weak var batteryIconView: BatteryIcon!
    @IBOutlet weak var fatburnLabel: UILabel!
    @IBOutlet weak var fireIconView: FireIcon!
    
    var pulseTime: NSTimer!
    var zeroBPMs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeartRate.sharedManager.delegate = self
        initializeUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        pulseTime.invalidate()
    }
    
    func initializeUI() {
        bpmLabel.text           = ""
        statusLabel.text        = ""
        sensorNameLabel.text    = ""
        batteryStatusLabel.text = ""
        fatburnLabel.text       = ""
    }
    
    func updateBPM(bpm: Int) {
        bpmLabel.text = "\(bpm)"
        print("BPM = \(bpm)")
        let interval: NSTimeInterval = 60 / Double(bpm)
        
        heartRateView.animateFromAngle(0, toAngle: 360, duration: interval, completion: nil)
        
        pulseTime = NSTimer(timeInterval: interval, target: self, selector: "checkForZeroBPM", userInfo: ["bpm": bpm], repeats: true)
        pulseTime.fire()
        
        animateBurnZone(bpm)
    }
    
    func updateManufacturerName(name: String) {
        print("Manufacturer = \(name)")
        sensorNameLabel.text = name
        watchIconView.addConnectingAnimationAnimation()
    }
    
    func updateBatteryLevelStatus(level: Int) {
        print("Battery Level = \(level)")
        batteryStatusLabel.text = "\(level)%"
        switch level {
        case 90...100:
            batteryIconView.addFullChargeAnimationAnimation()
        case 60...89:
            batteryIconView.addLessFullChargeAnimationAnimation()
        case 45...59:
            batteryIconView.addMidChargeAnimationAnimation()
        case 25...44:
            batteryIconView.addLessMidChargeAnimationAnimation()
        case 1...24:
            batteryIconView.addEmptyChargeAnimationAnimation()
        default:
            print("default battery view")
        }
    }
    
    func updateConnectivity(isConnected: Bool) {
        if isConnected == true {
            statusLabel.text = "Connected"
            fatburnLabel.text = "Fat Burn Zone"
            chainIconView.addConnectingAnimationAnimation()
        } else {
            statusLabel.text = "Disconnected"
            fatburnLabel.text = ""
            chainIconView.removeAllAnimations()
            //revise -> set from zero idle
        }
    }
    
    func checkForZeroBPM() {
        guard let userInfo = pulseTime.userInfo as? [String: AnyObject] else {
            print("Infomation from NSTimer is not available")
            return
        }
        let bpm = userInfo["bpm"] as! Int
        
        if bpm == 0 {
            zeroBPMs++
        } else {
            zeroBPMs = 0
        }
        
        if zeroBPMs >= 10 {
            showAlert()
            pulseTime.invalidate()
            zeroBPMs = 0
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Reading Error", message: "Could not read, plaese check your sensor or try again", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.chainIconView.addConnectingAnimationAnimationReverse(true, completionBlock: nil)
            self.batteryIconView.addReveseAnimateAnimation()
            self.watchIconView.addReveseAnimateAnimation()
            
            HeartRate.sharedManager.centralManager.scanForPeripheralsWithServices(HeartRate.sharedManager.services, options: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func animateBurnZone(bpm: Int) {
        switch bpm {
        case 100...135:
            fatburnLabel.text = "Burning!"
            fireIconView.addFireAnimateAnimation()
        default:
            fatburnLabel.text = "Fat Burn Zone"
            print("Not in the zone")
        }
    }
    
    @IBAction func screenTapped(sender: UITapGestureRecognizer) {
        if statusLabel.hidden == true {
            statusLabel.hidden = false
            fatburnLabel.hidden = false
            batteryStatusLabel.hidden = false
            sensorNameLabel.hidden = false
        } else {
            statusLabel.hidden = true
            fatburnLabel.hidden = true
            batteryStatusLabel.hidden = true
            sensorNameLabel.hidden = true
        }
    }
}

