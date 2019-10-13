//
//  PickRightNameViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 22/02/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class PickRightNameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return moleculeList.list.count
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {


        return pickerArray[row].moleculeName
    }
    
    @IBOutlet weak var moleculeImage: UIImageView!
    @IBOutlet weak var moleculeNamePicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var evaluationImageView: UIImageView!
    
    @IBOutlet weak var heightCorrectAnswer: NSLayoutConstraint!
    @IBOutlet weak var heightEvaluationImage: NSLayoutConstraint!
    @IBOutlet weak var heightSubmitButton: NSLayoutConstraint!
    @IBOutlet weak var heightNextButton: NSLayoutConstraint!
    
    
    var randomNumberImage = 0
    let moleculeList = MoleculeBank()
    var correctAnswer = false
    var pickerArray = [Molecule]()
   
    var scoreSystem = Score()
    var gameArray = [Int]()
    var currentQuestion = 1
    var gameOver = false
    let keys = Keys()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Find the correct name"
        moleculeNamePicker.delegate = self
        moleculeNamePicker.dataSource = self
        updateGame()
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = settingsButton
        
        if self.view.frame.height < 600 {
            heightCorrectAnswer.constant = 30
            heightEvaluationImage.constant = 44
            heightSubmitButton.constant = 29
            heightNextButton.constant = 29
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
    
    func setPickerArray() {
        var numberArray = [Int]()
        while numberArray.count < 5 {
            let randomNumber = Int.random(in: 0..<moleculeList.list.count)
            if !numberArray.contains(randomNumber) && !gameArray.contains(randomNumber) {
                numberArray.append(randomNumber)
            }
        }
        pickerArray.removeAll()
        for number in numberArray {
            pickerArray.append(moleculeList.list[number])
        }
        moleculeNamePicker.reloadAllComponents()
    }
    
    func updateGame() {
        submitButton.isEnabled = true
        nextButton.isHidden = true
        setPickerArray()
        moleculeNamePicker.isUserInteractionEnabled = true
        randomNumberImage = Int.random(in: 0 ..< pickerArray.count)

        moleculeImage.image = pickerArray[randomNumberImage].image
        let correctMolecule = pickerArray[randomNumberImage]
        let indexOfCorrectMolecule = moleculeList.list.firstIndex {
            $0.moleculeName == correctMolecule.moleculeName
            }!
        gameArray.append(indexOfCorrectMolecule)
        
        
        moleculeNamePicker.selectRow(0, inComponent: 0, animated: true)
        
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        evaluationImageView.alpha = 0
        correctAnswerLabel.alpha = 0
        updateProgressBar()
        
        if currentQuestion == scoreSystem.maxScore {
            nextButton.setTitle("RESTART", for: .normal)
            gameOver = true
        }
    }
    

    
    func restartGame() {
        gameArray.removeAll()
        gameOver = false
        currentQuestion = 1
        scoreSystem.resetCurrentScore()
        nextButton.setTitle("NEXT", for: .normal)
        updateGame()
    }
    
    func animateEvaluation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.evaluationImageView.alpha = 1
            if !self.correctAnswer {
            self.correctAnswerLabel.alpha = 1
            }
        })
    }
    
    func updateBestScore() {
        switch scoreSystem.maxScore {
        case 20:
            scoreSystem.updateBestScore(keyBestScore: keys.gameTwoBestScoreFor20, keyMaxAchieved: keys.gameTwoAchievedFor20, keyFlipCount: keys.gameTwoFlipCountFor20)
        case 30:
            scoreSystem.updateBestScore(keyBestScore: keys.gameTwoBestScoreFor30, keyMaxAchieved: keys.gameTwoAchievedFor30, keyFlipCount: keys.gameTwoFlipCountFor30)
        case 40:
            scoreSystem.updateBestScore(keyBestScore: keys.gameTwoBestScoreFor40, keyMaxAchieved: keys.gameTwoAchievedFor40, keyFlipCount: keys.gameTwoFlipCountFor40)
        case 50:
            scoreSystem.updateBestScore(keyBestScore: keys.gameTwoBestScoreFor50, keyMaxAchieved: keys.gameTwoAchievedFor50, keyFlipCount: keys.gameTwoFlipCountFor50)
        default:
            break
        }
    }
    
    func updateBestScoreLabel() {
        switch scoreSystem.maxScore {
        case 20:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameTwoBestScoreFor20))"
        case 30:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameTwoBestScoreFor30))"
        case 40:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameTwoBestScoreFor40))"
        case 50:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameTwoBestScoreFor50))"
        default:
            break
        }
    }
    
    func checkAnswer() {
        submitButton.isEnabled = false
        let index = moleculeNamePicker.selectedRow(inComponent: 0)
        let selectedName = pickerArray[index].moleculeName
        let generator = UINotificationFeedbackGenerator()
        if selectedName == pickerArray[randomNumberImage].moleculeName {
            generator.notificationOccurred(.success)
            correctAnswer = true
            evaluationImageView.image = UIImage(named: "correctanswer")
            scoreSystem.updateCurrentScore()
            updateBestScore()
            
        } else {
            generator.notificationOccurred(.error)
            correctAnswer = false

            correctAnswerLabel.text = "Correct answer : \(pickerArray[randomNumberImage].moleculeName)"
            evaluationImageView.image = UIImage(named: "wronganswer")
        }
        animateEvaluation()
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        moleculeNamePicker.isUserInteractionEnabled = false
        nextButton.isHidden = false
        showRewardAlert()
        
    }
    
        func showRewardAlert() {
        let rewardAlert = UIAlertController(title: "Congratulations!", message: "You unlocked a new Reward, check it out in the Achievements.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "COOL!", style: .default, handler: nil)
        rewardAlert.addAction(dismiss)
            switch scoreSystem.maxScore {
            case 20:
                if defaults.bool(forKey: keys.gameTwoAchievedFor20) == true && defaults.integer(forKey: keys.gameTwoFlipCountFor20) < 1 {
                    self.present(rewardAlert, animated: true, completion: nil)
                    defaults.set(1, forKey: keys.gameTwoFlipCountFor20)
                }
            case 30:
                if defaults.bool(forKey: keys.gameTwoAchievedFor30) == true && defaults.integer(forKey: keys.gameTwoFlipCountFor30) < 1 {
                    self.present(rewardAlert, animated: true, completion: nil)
                    defaults.set(1, forKey: keys.gameTwoFlipCountFor30)
                }
            case 40:
                    if defaults.bool(forKey: keys.gameTwoAchievedFor40) == true && defaults.integer(forKey: keys.gameTwoFlipCountFor40) < 1 {
                        self.present(rewardAlert, animated: true, completion: nil)
                        defaults.set(1, forKey: keys.gameTwoFlipCountFor40)
                    }
            case 50:
                        if defaults.bool(forKey: keys.gameTwoAchievedFor50) == true && defaults.integer(forKey: keys.gameTwoFlipCountFor50) < 1 {
                            self.present(rewardAlert, animated: true, completion: nil)
                            defaults.set(1, forKey: keys.gameTwoFlipCountFor50)
                        }
            default:
                break
            }
            
        }

    
    func updateProgressBar() {
        currentQuestionLabel.text = "\(currentQuestion)"+"/"+"\(scoreSystem.maxScore)"
        
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBar.frame.size.width = (self.view.frame.width/CGFloat(self.scoreSystem.maxScore)) * CGFloat(self.currentQuestion)
        })
    }

    
    
    

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        checkAnswer()
    }
        
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if gameOver {
            restartGame()
        } else {
            currentQuestion += 1
            updateGame()
        }
    }
    
    

}

extension PickRightNameViewController: MaxScoreDelegate {
    func didSelectNumber(number: Int) {
        scoreSystem.maxScore = number
        restartGame()
    }
}

/* To improve:
 avoid the same random number to be generated when tapping NEXT
 setting a delay between check answer and update game (not sure if necessary)
 limit number of items in the UIPickers (maybe max 10 or 20)
Sometimes you can see the same molecule twice in a row, make a gamearray that contains the correct molecule and avoid showing the same molecule by checking if the array already contains it
 


 */
