//
//  Constants.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 14/11/2020.
//  Copyright © 2020 Eric Ordonneau. All rights reserved.
//

import UIKit

enum AppStrings {
    static let quickLearn = NSLocalizedString("Quick Learn", comment: "quick learn title")
    static let games = NSLocalizedString("Games", comment: "games title")
    static let list = NSLocalizedString("List", comment: "list")
    static let revealName = NSLocalizedString("REVEAL NAME", comment: "reveal name")
    static let revealMolecule = NSLocalizedString("REVEAL MOLECULE", comment: "reveal molecule")
    static let showAll = NSLocalizedString("Show All", comment: "show all")
    static let hideName = NSLocalizedString("Hide Name", comment: "hide name")
    static let hideMolecule = NSLocalizedString("Hide Molecule", comment: "hide molecule")
    static let achievements = NSLocalizedString("Achievements", comment: "achievements")
    static let score = NSLocalizedString("Score", comment: "score")
    static let bestScore = NSLocalizedString("Best Score", comment: "best score")
    static let yes = NSLocalizedString("Yes", comment: "yes")
    static let no = NSLocalizedString("No", comment: "no")
}

enum Images {
    static let quickLearn = UIImage(named: "brain")!
    static let list = UIImage(named: "list")!
    static let games = UIImage(named: "puzzle")!
    static let achievements = UIImage(named: "achievements")!
}

enum Colors {
    static let purple = UIColor(red: 138/255, green: 136/255, blue: 255/255, alpha: 1)
    static let blueLearning = UIColor(red: 61/255, green: 164/255, blue: 255/255, alpha: 1)
    static let mainColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    
}
