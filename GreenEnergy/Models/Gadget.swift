//
//  Gadget.swift
//  GreenEnergy
//
//  Created by  mac on 21.03.2021.
//

import UIKit

class Gadget {
     var image: UIImage
     var defaultCount : Int
     var defaultUsageTime : Int
     var defaultUsageTimeAsDouble : Double?
     var defaultUsagePower : Int
    var defaultUsagePowerAsInt : Int?
    var isInstantEnergyUsage : Bool = false
    init(image: UIImage,defaultCount: Int, defaultUsageTime: Int, defaultUsagePower:Int) {
        self.image = image
        self.defaultCount = defaultCount
        self.defaultUsageTime = defaultUsageTime
        self.defaultUsagePower = defaultUsagePower
    }
}

var tv = Gadget(image: UIImage.init(named: "tv")!, defaultCount: 1, defaultUsageTime: 14, defaultUsagePower: 9)
var lamp = Gadget(image:  UIImage.init(named: "lamp")!, defaultCount: 10, defaultUsageTime: 13, defaultUsagePower: 5)
var fridge = Gadget(image:  UIImage.init(named: "fridge")!, defaultCount: 1, defaultUsageTime: 14, defaultUsagePower: 12)
var  teapot = Gadget(image:  UIImage.init(named: "teapot")!, defaultCount: 1, defaultUsageTime: 1, defaultUsagePower: 199)
var  microwave = Gadget(image:  UIImage.init(named: "microwave")!, defaultCount: 1, defaultUsageTime: 1, defaultUsagePower: 149)
var  boiler = Gadget(image:  UIImage.init(named: "boiler")!, defaultCount: 1, defaultUsageTime: 14, defaultUsagePower: 19)
var  pump = Gadget(image:  UIImage.init(named: "pump")!, defaultCount: 1, defaultUsageTime: 14, defaultUsagePower: 1)
var  computer = Gadget(image:  UIImage.init(named: "computer")!, defaultCount: 1, defaultUsageTime: 12, defaultUsagePower: 34)
var  plate = Gadget(image:  UIImage.init(named: "plate")!, defaultCount: 1, defaultUsageTime: 11, defaultUsagePower: 199)
var  coffee = Gadget(image:  UIImage.init(named: "coffee")!, defaultCount: 1, defaultUsageTime: 1, defaultUsagePower: 99)
var  washmachine = Gadget(image:  UIImage.init(named: "washmachine")!, defaultCount: 1, defaultUsageTime: 10, defaultUsagePower: 159)
var  iron = Gadget(image:  UIImage.init(named: "iron")!, defaultCount: 1, defaultUsageTime: 9, defaultUsagePower: 149)
var  vacuumcleaner = Gadget(image:  UIImage.init(named: "vacuumcleaner")!, defaultCount: 1, defaultUsageTime: 4, defaultUsagePower: 159)
var  aircondition = Gadget(image:  UIImage.init(named: "aircondition")!, defaultCount: 1, defaultUsageTime: 11, defaultUsagePower: 168)
var other = Gadget(image: UIImage.init(named: "other")!, defaultCount: 0, defaultUsageTime: 0, defaultUsagePower: 0)

let gadgetArray: [Gadget] = [
   tv, lamp, fridge,teapot, microwave, boiler, pump, computer, plate,coffee, washmachine, iron, vacuumcleaner, aircondition, other
]

