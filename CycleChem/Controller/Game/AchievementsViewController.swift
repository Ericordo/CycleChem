//
//  AchievementsViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 29/04/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController {
    

    @IBOutlet weak var gameOneReward20: UIImageView!
    @IBOutlet weak var gameOneReward30: UIImageView!
    @IBOutlet weak var gameOneReward40: UIImageView!
    @IBOutlet weak var gameOneReward50: UIImageView!
    @IBOutlet weak var gameTwoReward20: UIImageView!
    @IBOutlet weak var gameTwoReward30: UIImageView!
    @IBOutlet weak var gameTwoReward40: UIImageView!
    @IBOutlet weak var gameTwoReward50: UIImageView!
    @IBOutlet weak var gameThreeReward20: UIImageView!
    @IBOutlet weak var gameThreeReward30: UIImageView!
    @IBOutlet weak var gameThreeReward40: UIImageView!
    @IBOutlet weak var gameThreeReward50: UIImageView!
    @IBOutlet weak var gameFourReward20: UIImageView!
    @IBOutlet weak var gameFourReward30: UIImageView!
    @IBOutlet weak var gameFourReward40: UIImageView!
    @IBOutlet weak var gameFourReward50: UIImageView!
    @IBOutlet weak var gameFiveReward20: UIImageView!
    @IBOutlet weak var gameFiveReward30: UIImageView!
    @IBOutlet weak var gameFiveReward40: UIImageView!
    @IBOutlet weak var gameFiveReward50: UIImageView!
    @IBOutlet weak var gameSixReward20: UIImageView!
    @IBOutlet weak var gameSixReward30: UIImageView!
    @IBOutlet weak var gameSixReward40: UIImageView!
    @IBOutlet weak var gameSixReward50: UIImageView!
    
    
    @IBOutlet var achievementViewsArray: [UIView]!
    
    let keys = Keys()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateRewards()
        updateRewards20()
        updateRewards30()
        updateRewards40()
        updateRewards50()
        self.navigationItem.title = "Achievements"

        
        achievementViewsArray.forEach { (view) in
            view.layer.cornerRadius = 10
        }
        


    }
    
    
    

//    func updateRewards() {
//        let fullImageArray = [gameOneReward20, gameOneReward30, gameOneReward40, gameOneReward50, gameTwoReward20, gameTwoReward30, gameTwoReward40, gameTwoReward50, gameThreeReward20, gameThreeReward30, gameThreeReward40, gameThreeReward50, gameFourReward20, gameFourReward30, gameFourReward40, gameFourReward50, gameFiveReward20, gameFiveReward30, gameFiveReward40, gameFiveReward50, gameSixReward20, gameSixReward30, gameSixReward40, gameSixReward50]
//        let fullKeyArray = [keys.gameOneBestScoreFor20, keys.gameOneBestScoreFor30, keys.gameOneBestScoreFor40, keys.gameOneBestScoreFor50, keys.gameTwoBestScoreFor20, keys.gameTwoBestScoreFor30, keys.gameTwoBestScoreFor40, keys.gameTwoBestScoreFor50, keys.gameThreeBestScoreFor20, keys.gameThreeBestScoreFor30, keys.gameThreeBestScoreFor40, keys.gameThreeBestScoreFor50, keys.gameFourBestScoreFor20, keys.gameFourBestScoreFor30, keys.gameFourBestScoreFor40, keys.gameFourBestScoreFor50, keys.gameFiveBestScoreFor20, keys.gameFiveBestScoreFor30, keys.gameFiveBestScoreFor40, keys.gameFiveBestScoreFor50, keys.gameSixBestScoreFor20, keys.gameSixBestScoreFor30, keys.gameSixBestScoreFor40, keys.gameSixBestScoreFor50]
//        let bestScoresArray = [20, 30, 40, 50]
//        for i in 0...fullImageArray.count-1 {
//            for score in bestScoresArray {
//                if defaults.integer(forKey: fullKeyArray[i]) == score {
//                    switch score {
//                    case 20:
//                        fullImageArray[i]?.image = UIImage(named: "reward20")
//                    case 30:
//                        fullImageArray[i]?.image = UIImage(named: "reward30")
//                    case 40:
//                        fullImageArray[i]?.image = UIImage(named: "reward40")
//                    case 50:
//                        fullImageArray[i]?.image = UIImage(named: "reward50")
//                    default:
//                        break
//                    }
//                }
//            }
//        }
//    }
    
    
    func updateRewards20() {
        let imageArray20 = [gameOneReward20, gameTwoReward20, gameThreeReward20, gameFourReward20, gameFiveReward20, gameSixReward20]
        let keyArray20 = [keys.gameOneBestScoreFor20, keys.gameTwoBestScoreFor20, keys.gameThreeBestScoreFor20, keys.gameFourBestScoreFor20, keys.gameFiveBestScoreFor20, keys.gameSixBestScoreFor20]
        for i in 0...imageArray20.count-1 {
            if defaults.integer(forKey: keyArray20[i]) == 20 {
                imageArray20[i]?.image = UIImage(named: "reward20")
            }
        }
    }
    
    func updateRewards30() {
        let imageArray30 = [gameOneReward30, gameTwoReward30, gameThreeReward30, gameFourReward30, gameFiveReward30, gameSixReward30]
        let keyArray30 = [keys.gameOneBestScoreFor30, keys.gameTwoBestScoreFor30, keys.gameThreeBestScoreFor30, keys.gameFourBestScoreFor30, keys.gameFiveBestScoreFor30, keys.gameSixBestScoreFor30]
        for i in 0...imageArray30.count-1 {
            if defaults.integer(forKey: keyArray30[i]) == 30 {
                imageArray30[i]?.image = UIImage(named: "reward30")
            }
        }
    }
    
    func updateRewards40() {
        let imageArray40 = [gameOneReward40, gameTwoReward40, gameThreeReward40, gameFourReward40, gameFiveReward40, gameSixReward40]
        let keyArray40 = [keys.gameOneBestScoreFor40, keys.gameTwoBestScoreFor40, keys.gameThreeBestScoreFor40, keys.gameFourBestScoreFor40, keys.gameFiveBestScoreFor40, keys.gameSixBestScoreFor40]
        for i in 0...imageArray40.count-1 {
            if defaults.integer(forKey: keyArray40[i]) == 40 {
                imageArray40[i]?.image = UIImage(named: "reward40")
            }
        }
    }
    
    func updateRewards50() {
        let imageArray50 = [gameOneReward50, gameTwoReward50, gameThreeReward50, gameFourReward50, gameFiveReward50, gameSixReward50]
        let keyArray50 = [keys.gameOneBestScoreFor50, keys.gameTwoBestScoreFor50, keys.gameThreeBestScoreFor50, keys.gameFourBestScoreFor50, keys.gameFiveBestScoreFor50, keys.gameSixBestScoreFor50]
        for i in 0...imageArray50.count-1 {
            if defaults.integer(forKey: keyArray50[i]) == 50 {
                imageArray50[i]?.image = UIImage(named: "reward50")
            }
        }
    }
    
    
    
}
