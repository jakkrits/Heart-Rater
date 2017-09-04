//
//  HeartRate.swift
//  PolarH7 Heart-Rater
//
//  Created by Jakkrits on 10/23/2558 BE.
//  Copyright © 2558 AppIllus. All rights reserved.
//

import UIKit
import CoreBluetooth

struct ServiceUUID {
    //Services
    static let DeviceInfoService = "180A"
    static let HeartRateService = "180D"
    static let BatteryService = "180F"
}

struct CharacteristicUUID {
    static let HeartRateMeasurement = "2A37"
    static let ManufacturerName = "2A29"
    static let BatteryLevel = "2A19"
}

protocol HeartRateDelegate {
    func updateBPM(bpm: Int)
    func updateManufacturerName(name: String)
    func updateBatteryLevelStatus(level: Int)
    func updateConnectivity(isConnected: Bool)
}

class HeartRate: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    enum BluetoothError: ErrorType {
        case Fail
        case ErrorNumber(number: Int)
    }
    
    static let sharedManager = HeartRate()
    private var _centralManager: CBCentralManager!
    private var polarH7Peripheral: CBPeripheral?
    
    private var _BPM: UInt16                 = 0
    private var _manufacturerName: String?   = ""
    private var _connected                   = false {
        didSet {
            delegate?.updateConnectivity(_connected)
        }
    }
    
    
    private var _batteryLevel: Int?          = 100
    var delegate: HeartRateDelegate?
    
    var centralManager: CBCentralManager {
        return _centralManager
    }
    
    var bpm: Int {
        return Int(_BPM)
    }
    
    var manufacturerName: String {
        if _manufacturerName == nil {
            return "Not Found"
        } else {
            return _manufacturerName!
        }
    }
    
    var connected: Bool {
        return _connected
    }
    
    var batteryLevel: Int {
        return _batteryLevel!
    }
    
    let services = [CBUUID(string: ServiceUUID.HeartRateService), CBUUID(string: ServiceUUID.DeviceInfoService)]
    
    override init() {
        super.init()
        self._centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    //MARK: - Getting Info from the device
    private func getBPMData(characteristic: CBCharacteristic, error: NSError?) {
        guard let data = characteristic.value else {
            print("cannot equate data from characteristc")
            return
        }
        let reportData: UnsafePointer<UInt8> = UnsafePointer<UInt8>(data.bytes)
        
        if (reportData[0] & 0x01) == 0 {
            _BPM = UInt16(reportData[1])
        } else {
            _BPM = CFSwapInt16LittleToHost(UInt16(reportData[1]))
        }
        delegate?.updateBPM(bpm)
    }
    
    private func getManufacturerName(characteristic: CBCharacteristic) {
        _manufacturerName = NSString(data: characteristic.value!, encoding: NSUTF8StringEncoding) as? String
        delegate?.updateManufacturerName(manufacturerName)
    }
    
    private func getBatteryLevel(characteristic: CBCharacteristic) {
        guard let data = characteristic.value else {
            print("cannot equate data from characteristc")
            return
        }
        let reportData: UnsafePointer<UInt8> = UnsafePointer<UInt8>(data.bytes)
        _batteryLevel = Int(reportData[0])
        delegate?.updateBatteryLevelStatus(batteryLevel)
    }
    
    //MARK: - CBCentralManager Delegates
    //Try to connect if bluetooth is on and ready
    @objc func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
            
        case .PoweredOff:
            print("Bluetooth is turned off")
            let alert = DBAlertController(title: "Bluetooth is off", message: "Turn on bluetooth to continue", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            alert.show(animated: true, completion: nil)
            
        case .PoweredOn:
            _centralManager.scanForPeripheralsWithServices(services, options: nil)
            print("Bluetooth is ready")
            
        case .Unauthorized:
            print("Bluetooth is unauthorized")
            
        case .Unknown:
            print("Bluetooth state is unknown")
            
        case .Unsupported:
            print("hardware is not supported")
            
        case .Resetting:
            print("bluetooth is resetting")
        }
    }
    
    //if found, stop scanning and connect to peripheral
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        if let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            print("found \(localName)")
            self._centralManager.stopScan()
            self.polarH7Peripheral = peripheral
            peripheral.delegate = self
            self._centralManager.connectPeripheral(peripheral, options: nil)
        }
    }
    
    //upon connected, set ivars
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.delegate = self
        //reset
        peripheral.discoverServices(nil)
        _connected = true
    }
    
    //CBPeripheral Delegates
    //Logging out services from H7
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print(__FUNCTION__)
        guard let services = peripheral.services else {
            print("no services found")
            return
        }
        
        for service in services {
            print(service.UUID)
            //reset
            peripheral.discoverCharacteristics(nil, forService: service)
        }
    }
    
    //Called for each characteristics found
    //Request heart rate notification
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        
        
        //Getting Device Info
        if service.UUID == CBUUID(string: ServiceUUID.DeviceInfoService) {
            for characteristic in service.characteristics! {
                if characteristic.UUID == CBUUID(string: CharacteristicUUID.ManufacturerName) {
                    self.polarH7Peripheral!.readValueForCharacteristic(characteristic)
                    print("Found Manufacturer's Name Characteristic")
                }
            }
        }
        
        //Getting Heart rate
        if service.UUID == CBUUID(string: ServiceUUID.HeartRateService) {
            for characteristic in service.characteristics! {
                if characteristic.UUID == CBUUID(string: CharacteristicUUID.HeartRateMeasurement) {
                    //Heart rate notification
                    self.polarH7Peripheral!.setNotifyValue(true, forCharacteristic: characteristic)
                    print("Found heart rate measurement characteristic")
                }
            }
        }
        
        //Getting Battery Status
        if service.UUID == CBUUID(string: ServiceUUID.BatteryService) {
            for characteristic in service.characteristics! {
                if characteristic.UUID == CBUUID(string: CharacteristicUUID.BatteryLevel) {
                    self.polarH7Peripheral!.readValueForCharacteristic(characteristic)
                    print("Found Battery Level Status")
                }
            }
        }
        
    }
    
    //Updating values read from peripheral
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        
        if characteristic.UUID == CBUUID(string: CharacteristicUUID.HeartRateMeasurement) {
            self.getBPMData(characteristic, error: error)
        }
        
        if characteristic.UUID == CBUUID(string: CharacteristicUUID.ManufacturerName) {
            self.getManufacturerName(characteristic)
        }
        
        if characteristic.UUID == CBUUID(string: CharacteristicUUID.BatteryLevel) {
            self.getBatteryLevel(characteristic)
        }
    }
    
    
}





























