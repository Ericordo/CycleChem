//
//  Score.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 05/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import Foundation
import UIKit

struct Score {
    var currentScore = 0
    var bestScore = Int()
    var maxScoreAchieved = false
    var flipCount = 0
    var maxScore = 20
    
//    func prepareRewardAlert() {
//    let rewardAlert = UIAlertController(title: "Congratulations!", message: "You unlocked a new Reward, check it out in the Achievements.", preferredStyle: .alert)
//    let dismiss = UIAlertAction(title: "Cool!", style: .default, handler: nil)
//    rewardAlert.addAction(dismiss)
//    }
    
    mutating func updateCurrentScore() {
        if currentScore < maxScore {
        currentScore += 1
        }
    }
    
//    mutating func updateBestScore(key: String) {
//        if currentScore >= bestScore {
//            bestScore = currentScore
//            defaults.set(bestScore, forKey: key)
//        }
//        if bestScore == maxScore {
//            maxScoreAchieved = true
//        }
//    }
    
//    mutating func updateBestScore(key: String) {
//      bestScore = defaults.integer(forKey: key)
//        if currentScore >= bestScore {
//            bestScore = currentScore
//            defaults.set(bestScore, forKey: key)
//        }
//        if bestScore == maxScore {
//            maxScoreAchieved = true
//        }
//    }
    
    mutating func updateBestScore(keyBestScore: String, keyMaxAchieved: String, keyFlipCount: String) {
        bestScore = defaults.integer(forKey: keyBestScore)
        if currentScore >= bestScore {
            bestScore = currentScore
            defaults.set(bestScore, forKey: keyBestScore)
        }
        maxScoreAchieved = defaults.bool(forKey: keyMaxAchieved)
        flipCount = defaults.integer(forKey: keyFlipCount)
        if flipCount < 1 {
        if bestScore == maxScore {
            maxScoreAchieved = true
//            flipCount += 1
            defaults.set(maxScoreAchieved, forKey: keyMaxAchieved)
            defaults.set(flipCount, forKey: keyFlipCount)
        }
        }
    }
    
    mutating func resetCurrentScore() {
        currentScore = 0
    }
    

    
    
    
    
}


