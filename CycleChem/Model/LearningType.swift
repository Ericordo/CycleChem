//
//  LearningType.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 15/11/2020.
//  Copyright © 2020 Eric Ordonneau. All rights reserved.
//

import Foundation

enum LearningType {
    case showAll
    case hideName
    case hideMolecule
    
    var description : String {
        switch self {
        case .showAll:
            return AppStrings.showAll
        case .hideName:
            return AppStrings.hideName
        case .hideMolecule:
            return AppStrings.hideMolecule
        }
    }
    
    var revealButtonTitle : String {
        switch self {
        case .showAll:
            return ""
        case .hideName:
            return AppStrings.revealName
        case .hideMolecule:
            return AppStrings.revealMolecule
        }
    }
    
    var hideRevealButton : Bool {
        switch self {
        case .showAll:
            return true
        case .hideName, .hideMolecule:
            return false
        }
    }
    
    var hideName : Bool {
        switch self {
        case .showAll, .hideMolecule:
            return false
        case .hideName:
            return true
        }
    }
    
    var hideMolecule : Bool {
        switch self {
        case .showAll, .hideName:
            return false
        case .hideMolecule:
            return true
        }
    }
}


