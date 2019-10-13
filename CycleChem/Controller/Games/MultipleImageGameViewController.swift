//
//  MultipleImageGameViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 21/02/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class MultipleImageGameViewController: UIViewController {
    
    var moleculeList = MoleculeBank()
    var imageArray = [Molecule]()
    
    var gameOver = false
    var currentQuestion = 1
    var scoreSystem = Score()
    var gameArray = [Int]()
    var correctMolecule : Molecule?
    
    let keys = Keys()
 
    
    @IBAction func moleculeButtonPressed(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        if moleculeNameLabel.text == imageArray[sender.tag].moleculeName {
            generator.notificationOccurred(.success)
            evaluationImageView.image = UIImage(named: "correctanswer")
            scoreSystem.updateCurrentScore()
            updateBestScore()
            UIView.animate(withDuration: 0.5, animations: { sender.layer.borderColor = UIColor(red: 179/255, green: 219/255, blue: 149/255, alpha: 1.0).cgColor })
           
        } else {
            generator.notificationOccurred(.error)
           evaluationImageView.image = UIImage(named: "wronganswer")
            UIView.animate(withDuration: 0.5, animations: { sender.layer.borderColor = UIColor(red: 211/255, green: 145/255, blue: 143/255, alpha: 1.0).cgColor })
            for button in buttonArray {
                if button.imageView?.image == correctMolecule?.image {
                    button.layer.borderColor = UIColor(red: 179/255, green: 219/255, blue: 149/255, alpha: 1.0).cgColor
                }
            }
            
            
        }
        animateEvaluation()
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        showRewardAlert()

        buttonArray.forEach { (button) in
            button.isUserInteractionEnabled = false
        }
        nextButton.isHidden = false
    }
    
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var moleculeNameLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var evaluationImageView: UIImageView!
    
    override func viewWillLayoutSubviews() {
        for button in buttonArray {
            
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: button.frame.size.height - 10, left: button.frame.size.width - 10, bottom: button.frame.size.height - 10, right: button.frame.size.width - 10)
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Find the correct structure"
        updateGame()
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = settingsButton
        
//        for button in buttonArray {
//            button.setBackgroundImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
//        }
//        buttonArray.forEach { (button) in
//            <#code#>
//        }

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateProgressBar()
    }
    
    @objc func settingsButtonTapped(sender: UIBarButtonItem) {
        let popUpVC = self.storyboard?.instantiateViewController(withIdentifier: "PopUpController") as! SliderViewController
        popUpVC.maxScoreDelegate = self
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.modalTransitionStyle = .crossDissolve
        self.present(popUpVC, animated: true, completion: nil)
    }
    

    func updateGame() {
       
        nextButton.isHidden = true
        buttonArray.forEach { (button) in
            button.isUserInteractionEnabled = true
        }
        var numberArray = [Int]()

        while numberArray.count < 6 {
            let randomNumber = Int.random(in: 0..<moleculeList.list.count)
            if !numberArray.contains(randomNumber) && !gameArray.contains(randomNumber)  {
                numberArray.append(randomNumber)
            }
        }
        imageArray.removeAll()
        for number in numberArray {
            imageArray.append(moleculeList.list[number])
        }
        for button in buttonArray {

            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(imageArray[buttonArray.firstIndex(of: button)!].image, for: .normal)
            button.tintColor = UIColor.black
            button.imageEdgeInsets = UIEdgeInsets(top: button.frame.size.height - 10, left: button.frame.size.width - 10, bottom: button.frame.size.height - 10, right: button.frame.size.width - 10)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.black.cgColor
        }
        let randomNumberForLabel = Int.random(in: 0..<numberArray.count)
        moleculeNameLabel.text = imageArray[randomNumberForLabel].moleculeName
        
        correctMolecule = imageArray[randomNumberForLabel]
        let indexOfCorrectMolecule = moleculeList.list.firstIndex {
            $0.moleculeName == correctMolecule!.moleculeName
            }!
        gameArray.append(indexOfCorrectMolecule)
  
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        evaluationImageView.alpha = 0
        updateProgressBar()
        
        if currentQuestion == scoreSystem.maxScore {
            nextButton.setTitle("RESTART", for: .normal)
            gameOver = true
        }
        
        }
    
    func updateProgressBar() {
        currentQuestionLabel.text = "\(currentQuestion)"+"/"+"\(scoreSystem.maxScore)"
        
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBar.frame.size.width = (self.view.frame.width/CGFloat(self.scoreSystem.maxScore)) * CGFloat(self.currentQuestion)
        })
    }
    
    func animateEvaluation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.evaluationImageView.alpha = 1
            
        })
    }
    
  
    
    func restartGame() {
        gameArray.removeAll()
        gameOver = false
        currentQuestion = 1
        scoreSystem.resetCurrentScore()
        nextButton.setTitle("NEXT", for: .normal)
        updateGame()
    }
    
    func updateBestScore() {
        switch scoreSystem.maxScore {
        case 20:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFourBestScoreFor20, keyMaxAchieved: keys.gameFourAchievedFor20, keyFlipCount: keys.gameFourFlipCountFor20)
        case 30:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFourBestScoreFor30, keyMaxAchieved: keys.gameFourAchievedFor30, keyFlipCount: keys.gameFourFlipCountFor30)
        case 40:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFourBestScoreFor40, keyMaxAchieved: keys.gameFourAchievedFor40, keyFlipCount: keys.gameFourFlipCountFor40)
        case 50:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFourBestScoreFor50, keyMaxAchieved: keys.gameFourAchievedFor50, keyFlipCount: keys.gameFourFlipCountFor50)
        default:
            break
        }
    }
    
    func updateBestScoreLabel() {
        switch scoreSystem.maxScore {
        case 20:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFourBestScoreFor20))"
        case 30:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFourBestScoreFor30))"
        case 40:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFourBestScoreFor40))"
        case 50:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFourBestScoreFor50))"
        default:
            break
        }
    }
    
    func showRewardAlert() {
        let rewardAlert = UIAlertController(title: "Congratulations!", message: "You unlocked a new Reward, check it out in the Achievements.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "COOL!", style: .default, handler: nil)
        rewardAlert.addAction(dismiss)
        switch scoreSystem.maxScore {
        case 20:
            if defaults.bool(forKey: keys.gameFourAchievedFor20) == true && defaults.integer(forKey: keys.gameFourFlipCountFor20) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFourFlipCountFor20)
            }
        case 30:
            if defaults.bool(forKey: keys.gameFourAchievedFor30) == true && defaults.integer(forKey: keys.gameFourFlipCountFor30) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFourFlipCountFor30)
            }
        case 40:
            if defaults.bool(forKey: keys.gameFourAchievedFor40) == true && defaults.integer(forKey: keys.gameFourFlipCountFor40) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFourFlipCountFor40)
            }
        case 50:
            if defaults.bool(forKey: keys.gameFourAchievedFor50) == true && defaults.integer(forKey: keys.gameFourFlipCountFor50) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFourFlipCountFor50)
            }
        default:
            break
        }
        
    }
        
    
    
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if gameOver {
            restartGame()
        } else {
            currentQuestion += 1
            updateGame()
        }
    }
    
    

}

extension MultipleImageGameViewController: MaxScoreDelegate {
    func didSelectNumber(number: Int) {
        scoreSystem.maxScore = number
        restartGame()
    }
}
