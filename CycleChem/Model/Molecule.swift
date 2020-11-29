//
//  Molecule.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 29/01/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import Foundation
import UIKit

class Molecule {
    let name: String
    let ringSize: Int
    let ringCount: Int
    let hasOxygen: Bool
    let oxygenCount: Int
    let hasNitrogen: Bool
    let nitrogenCount: Int
    let hasSulfur: Bool
    let sulfurCount: Int
    let isSaturated: Bool
    let image : UIImage
    
    init(name : String, ringSize : Int, ringCount : Int, hasOxygen : Bool, oxygenCount : Int, hasNitrogen : Bool, nitrogenCount : Int, hasSulfur : Bool, sulfurCount : Int, isSaturated : Bool, image: UIImage) {
        self.name = name
        self.ringSize = ringSize
        self.ringCount = ringCount
        self.hasOxygen = hasOxygen
        self.oxygenCount = oxygenCount
        self.hasNitrogen = hasNitrogen
        self.nitrogenCount = nitrogenCount
        self.hasSulfur = hasSulfur
        self.sulfurCount = sulfurCount
        self.isSaturated = isSaturated
        self.image = image
        }
}



