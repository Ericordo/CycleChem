//
//  QuickLearnViewModel.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 14/11/2020.
//  Copyright © 2020 Eric Ordonneau. All rights reserved.
//

import Foundation
import ReactiveSwift

class QuickLearnViewModel {
    
    let showName : MutableProperty<Bool> = MutableProperty(true)
    let showMolecule : MutableProperty<Bool> = MutableProperty(false)
    
    let learningType : MutableProperty<LearningType> = MutableProperty(.showAll)
    
    init() {
        
    }
    
}
