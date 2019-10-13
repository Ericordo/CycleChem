//
//  YesNoGameViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 19/02/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class YesNoGameViewController: UIViewController {
    
    @IBOutlet weak var moleculeImage: UIImageView!
    @IBOutlet weak var moleculeNameLabel: UILabel!
    @IBOutlet weak var yesButton: YesButton!
    @IBOutlet weak var noButton: NoButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var evaluationImageView: UIImageView!
    
    @IBOutlet weak var heightYesButton: NSLayoutConstraint!
    @IBOutlet weak var widthYesButton: NSLayoutConstraint!
    @IBOutlet weak var widthNoButton: NSLayoutConstraint!
    @IBOutlet weak var heightNoButton: NSLayoutConstraint!
    @IBOutlet weak var heightEvaluationImageView: NSLayoutConstraint!
    @IBOutlet weak var spaceBetweenLabelandImage: NSLayoutConstraint!
    @IBOutlet weak var spaceBetweenLabelandMolecule: NSLayoutConstraint!
    
    
    var randomNumberImage: Int?
    var randomNumberName1: Int?
    var randomNumberName2: Int?
    var selectedNumberForName = 0
    var arrayToPickFrom: [Int] = []
    var correctAnswer = false
    var scoreSystem = Score()
    let moleculeList = MoleculeBank()
    var gameArray = [Int]()
    var currentQuestion = 1
    var gameOver = false
    let keys = Keys()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Yes or No?"
        updateGame()
        
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = settingsButton
        
        if self.view.frame.height < 600 {
            widthNoButton.constant = 110
            widthYesButton.constant = 110
            heightNoButton.constant = 50
            heightYesButton.constant = 50
            heightEvaluationImageView.constant = 44
            moleculeNameLabel.font = moleculeNameLabel.font.withSize(25)
            spaceBetweenLabelandImage.constant = 10
            spaceBetweenLabelandMolecule.constant = 20
        }
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
    
    
    func createNumbersForGame() {
        while gameArray.count < currentQuestion {
        randomNumberImage = Int.random(in: 0 ... moleculeList.list.count-1)
            if !gameArray.contains(randomNumberImage!) {
                gameArray.append(randomNumberImage!)
            }
        }
        randomNumberName1 = Int.random(in: 0 ... moleculeList.list.count-1)
        randomNumberName2 = Int.random(in: 0 ... moleculeList.list.count-1)
        arrayToPickFrom = [randomNumberImage, randomNumberName1, randomNumberName2] as! [Int]
    }
    
    func updateGame() {
        createNumbersForGame()
        let randomNumberToSelectName = Int.random(in: 0...2)
        selectedNumberForName = arrayToPickFrom[randomNumberToSelectName]
        if let randomNumberImage = randomNumberImage {
            moleculeImage.image = moleculeList.list[randomNumberImage].image
        }
        moleculeNameLabel.text = moleculeList.list[selectedNumberForName].moleculeName
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        updateProgressBar()
        evaluationImageView.alpha = 0
        yesButton.isEnabled = true
        noButton.isEnabled = true
        nextButton.isHidden = true
        
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
    
    func restartGame() {
        gameArray.removeAll()
        yesButton.isEnabled = true
        noButton.isEnabled = true
        gameOver = false
        currentQuestion = 1
        scoreSystem.resetCurrentScore()
        nextButton.setTitle("NEXT", for: .normal)
        updateGame()
    }
    
    
    func animateEvaluation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.evaluationImageView.alpha = 1
        })
    }
    
    func updateBestScore() {
        switch scoreSystem.maxScore {
        case 20:
            scoreSystem.updateBestScore(keyBestScore: keys.gameOneBestScoreFor20, keyMaxAchieved: keys.gameOneAchievedFor20, keyFlipCount: keys.gameOneFlipCountFor20)
        case 30:
            scoreSystem.updateBestScore(keyBestScore: keys.gameOneBestScoreFor30, keyMaxAchieved: keys.gameOneAchievedFor30, keyFlipCount: keys.gameOneFlipCountFor30)
        case 40:
            scoreSystem.updateBestScore(keyBestScore: keys.gameOneBestScoreFor40, keyMaxAchieved: keys.gameOneAchievedFor40, keyFlipCount: keys.gameOneFlipCountFor40)
        case 50:
            scoreSystem.updateBestScore(keyBestScore: keys.gameOneBestScoreFor50, keyMaxAchieved: keys.gameOneAchievedFor50, keyFlipCount: keys.gameOneFlipCountFor50)
        default:
            break
        }
    }
    
    func updateBestScoreLabel() {
        switch scoreSystem.maxScore {
        case 20:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameOneBestScoreFor20))"
        case 30:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameOneBestScoreFor30))"
        case 40:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameOneBestScoreFor40))"
        case 50:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameOneBestScoreFor50))"
        default:
            break
        }
    }
    
    func checkAnswerGiven() {
        
        
        if selectedNumberForName == randomNumberImage {
            correctAnswer = true
            
        } else {
            correctAnswer = false
        }
        nextButton.isHidden = false
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }
    

    
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        checkAnswerGiven()
       let generator = UINotificationFeedbackGenerator()
        if correctAnswer {
            
            
            generator.notificationOccurred(.success)
            scoreSystem.updateCurrentScore()
            evaluationImageView.image = UIImage(named: "correctanswer")
        } else {
             generator.notificationOccurred(.error)
            evaluationImageView.isHidden = false
            evaluationImageView.image = UIImage(named: "wronganswer")
        }
        animateEvaluation()
        updateBestScore()
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        showRewardAlert()
        
       
        
        
    }
    
    
    @IBAction func noButtonTapped(_ sender: Any) {
        checkAnswerGiven()
        let generator = UINotificationFeedbackGenerator()
        if correctAnswer {
            
            generator.notificationOccurred(.error)
            evaluationImageView.isHidden = false
            evaluationImageView.image = UIImage(named: "wronganswer")
        } else {
        
            generator.notificationOccurred(.success)
            scoreSystem.updateCurrentScore()
            evaluationImageView.isHidden = false
            evaluationImageView.image = UIImage(named: "correctanswer")
        }
        animateEvaluation()
        updateBestScore()
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        showRewardAlert()
  
    }
    
    func showRewardAlert() {
        let rewardAlert = UIAlertController(title: "Congratulations!", message: "You unlocked a new Reward, check it out in the Achievements.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "COOL!", style: .default, handler: nil)
        rewardAlert.addAction(dismiss)
        switch scoreSystem.maxScore {
        case 20:
            if defaults.bool(forKey: keys.gameOneAchievedFor20) == true && defaults.integer(forKey: keys.gameOneFlipCountFor20) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameOneFlipCountFor20)
            }
        case 30:
            if defaults.bool(forKey: keys.gameOneAchievedFor30) == true && defaults.integer(forKey: keys.gameOneFlipCountFor30) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameOneFlipCountFor30)
            }
        case 40:
            if defaults.bool(forKey: keys.gameOneAchievedFor40) == true && defaults.integer(forKey: keys.gameOneFlipCountFor40) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameOneFlipCountFor40)
            }
        case 50:
            if defaults.bool(forKey: keys.gameOneAchievedFor50) == true && defaults.integer(forKey: keys.gameOneFlipCountFor50) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameOneFlipCountFor50)
            }
        default:
            break
        }
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if gameOver {
            restartGame()
        } else {
            currentQuestion += 1
            updateGame()
            
        }
    }
    
    
        
    }

extension YesNoGameViewController: MaxScoreDelegate {
    func didSelectNumber(number: Int) {
        scoreSystem.maxScore = number
        restartGame()
    }
}
    
    
    

    



