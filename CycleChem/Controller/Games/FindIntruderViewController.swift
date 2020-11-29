//
//  FindIntruderViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 06/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FindIntruderViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var evaluationImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet var labelArray: [UILabel]!
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var progressBarTrailing: NSLayoutConstraint!
    
    
    
    var scoreSystem = Score()
    var moleculeList = MoleculeBank()
    var moleculeArray = [Molecule]()
    var labelTag: Int?
    
    var gameOver = false
    var currentQuestion = 1
    var currentGameArray: [String] = []
    
    var selectedMoleculeForIntruderImage: Molecule?
    
    let keys = Keys()
    

    
    override func viewWillLayoutSubviews() {
        for button in buttonArray {

            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: button.frame.size.height - 10, left: button.frame.size.width - 10, bottom: button.frame.size.height - 10, right: button.frame.size.width - 10)
  
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonArray = [button0, button1, button2, button3, button4, button5]
        labelArray = [label0, label1, label2, label3, label4, label5]
        self.navigationItem.title = "Find the mistake"
        updateGame()

        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = settingsButton
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
            if !numberArray.contains(randomNumber) {
                numberArray.append(randomNumber)
            }
        }
        moleculeArray.removeAll()
        for number in numberArray {
            moleculeArray.append(moleculeList.list[number])
        }
        for button in buttonArray {
            
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(moleculeArray[buttonArray.firstIndex(of: button)!].image, for: .normal)
            button.tintColor = UIColor.black
            button.imageEdgeInsets = UIEdgeInsets(top: button.frame.size.height - 10, left: button.frame.size.width - 10, bottom: button.frame.size.height - 10, right: button.frame.size.width - 10)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.black.cgColor
        }
        for label in labelArray {
            label.text = moleculeArray[labelArray.firstIndex(of: label)!].name
        }
        
        let randomNumberForLabel = Int.random(in: 0..<numberArray.count)
        let selectedLabelForIntruder = labelArray[randomNumberForLabel]
        var randomNumberArrayForIntruderMolecule: [Int] = []
        while randomNumberArrayForIntruderMolecule.count < 1 {
            let randomNumberForIntruderMolecule = Int.random(in: 0..<moleculeList.list.count)
            if !numberArray.contains(randomNumberForIntruderMolecule) {
                randomNumberArrayForIntruderMolecule.append(randomNumberForIntruderMolecule)
            }
        }
        selectedMoleculeForIntruderImage = moleculeList.list[randomNumberArrayForIntruderMolecule[0]]
        selectedLabelForIntruder.text = selectedMoleculeForIntruderImage!.name
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
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBarTrailing.constant = self.view.frame.width - (self.view.frame.width/(CGFloat(self.scoreSystem.maxScore)) * CGFloat(self.currentQuestion))
            self.view.layoutIfNeeded()
        })
    }
    
    func animateEvaluation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.evaluationImageView.alpha = 1
            
        })
    }
    
    func restartGame() {
        gameOver = false
        currentQuestion = 1
        scoreSystem.resetCurrentScore()
        nextButton.setTitle("NEXT", for: .normal)
        updateGame()
    }
    
    func updateBestScore() {
        switch scoreSystem.maxScore {
        case 20:
            scoreSystem.updateBestScore(keyBestScore: keys.gameThreeBestScoreFor20, keyMaxAchieved: keys.gameThreeAchievedFor20, keyFlipCount: keys.gameThreeFlipCountFor20)
        case 30:
            scoreSystem.updateBestScore(keyBestScore: keys.gameThreeBestScoreFor30, keyMaxAchieved: keys.gameThreeAchievedFor30, keyFlipCount: keys.gameThreeFlipCountFor30)
        case 40:
            scoreSystem.updateBestScore(keyBestScore: keys.gameThreeBestScoreFor40, keyMaxAchieved: keys.gameThreeAchievedFor40, keyFlipCount: keys.gameThreeFlipCountFor40)
        case 50:
            scoreSystem.updateBestScore(keyBestScore: keys.gameThreeBestScoreFor50, keyMaxAchieved: keys.gameThreeAchievedFor50, keyFlipCount: keys.gameThreeFlipCountFor50)
        default:
            break
        }
    }
    
    func updateBestScoreLabel() {
        switch scoreSystem.maxScore {
        case 20:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameThreeBestScoreFor20))"
        case 30:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameThreeBestScoreFor30))"
        case 40:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameThreeBestScoreFor40))"
        case 50:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameThreeBestScoreFor50))"
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
            if defaults.bool(forKey: keys.gameThreeAchievedFor20) == true && defaults.integer(forKey: keys.gameThreeFlipCountFor20) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameThreeFlipCountFor20)
            }
        case 30:
            if defaults.bool(forKey: keys.gameThreeAchievedFor30) == true && defaults.integer(forKey: keys.gameThreeFlipCountFor30) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameThreeFlipCountFor30)
            }
        case 40:
            if defaults.bool(forKey: keys.gameThreeAchievedFor40) == true && defaults.integer(forKey: keys.gameThreeFlipCountFor40) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameThreeFlipCountFor40)
            }
        case 50:
            if defaults.bool(forKey: keys.gameThreeAchievedFor50) == true && defaults.integer(forKey: keys.gameThreeFlipCountFor50) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameThreeFlipCountFor50)
            }
        default:
            break
        }
        
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if gameOver {
            restartGame()
        } else {
            currentQuestion += 1
            updateGame()
        }
    }
    
    @IBAction func moleculeButtonPressed(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        if labelArray[sender.tag].text != moleculeArray[sender.tag].name {
            generator.notificationOccurred(.success)
            evaluationImageView.image = UIImage(named: "correctanswer")
            scoreSystem.updateCurrentScore()
            updateBestScore()
            UIView.animate(withDuration: 0.5, animations: { sender.layer.borderColor = UIColor(red: 179/255, green: 219/255, blue: 149/255, alpha: 1.0).cgColor })
        } else {
            generator.notificationOccurred(.error)
            evaluationImageView.image = UIImage(named: "wronganswer")
            UIView.animate(withDuration: 0.5, animations: { sender.layer.borderColor = UIColor(red: 211/255, green: 145/255, blue: 143/255, alpha: 1.0).cgColor })
            for label in labelArray {
                if label.text == selectedMoleculeForIntruderImage?.name {
                    labelTag = label.tag
                }
            }
            for button in buttonArray {
                if button.tag == labelTag { button.layer.borderColor = UIColor(red: 179/255, green: 219/255, blue: 149/255, alpha: 1.0).cgColor}
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
    



}

extension FindIntruderViewController: MaxScoreDelegate {
    func didSelectNumber(number: Int) {
        scoreSystem.maxScore = number
        restartGame()
    }
}
