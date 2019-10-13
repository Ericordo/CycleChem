//
//  QuizViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 04/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var oxygenLabel: UILabel!
    @IBOutlet weak var nitrogenLabel: UILabel!
    @IBOutlet weak var sulfurLabel: UILabel!
    @IBOutlet weak var ringLabel: UILabel!
    @IBOutlet weak var saturationLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var namePicker: UIPickerView!
    @IBOutlet weak var progressBar: UIView!
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!

    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var evaluationImageView: UIImageView!
    
    @IBOutlet weak var heightNextButton: NSLayoutConstraint!
    @IBOutlet weak var heightSubmitButton: NSLayoutConstraint!
    @IBOutlet weak var heightNamePicker: NSLayoutConstraint!
    @IBOutlet weak var heightCorrectAnswerLabel: NSLayoutConstraint!
    @IBOutlet weak var heightEvaluationImageView: NSLayoutConstraint!
    
    
    let moleculeList = MoleculeBank()
    var pickerArray = [Molecule]()
    var randomMoleculeNumber = 0
    var correctAnswer = false
    var possibleAnswers = [String]()
    var scoreSystem = Score()
    var gameArray = [Int]()
    var gameOver = false
    var currentQuestion = 1
    
    var correctMolecule: Molecule?
    
    let keys = Keys()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Quiz"
        namePicker.delegate = self
        namePicker.dataSource = self
        updateGame()
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = settingsButton
        
        if self.view.frame.height < 600 {
            heightNextButton.constant = 25
            heightSubmitButton.constant = 25
            heightNamePicker.constant = 90
            heightCorrectAnswerLabel.constant = 30
            heightEvaluationImageView.constant = 44
            
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
            if !numberArray.contains(randomNumber) {
                numberArray.append(randomNumber)
            }
        }
        pickerArray.removeAll()
        for number in numberArray {
            pickerArray.append(moleculeList.list[number])
        }
        namePicker.reloadAllComponents()
    }
    
    func updateGame() {
        submitButton.isEnabled = true
        nextButton.isHidden = true
        namePicker.isUserInteractionEnabled = true

        setPickerArray()
        randomMoleculeNumber = Int.random(in: 0..<pickerArray.count)
        gameArray.append(randomMoleculeNumber)
        if gameArray.count == 0 {
            randomMoleculeNumber = Int.random(in: 0..<moleculeList.list.count)
            gameArray.append(randomMoleculeNumber)
        } else {
            while gameArray.count < currentQuestion {
                randomMoleculeNumber = Int.random(in: 0..<moleculeList.list.count)
                if !gameArray.contains(randomMoleculeNumber) {
                    gameArray.append(randomMoleculeNumber)
                }
            }
        }
        oxygenLabel.text = "Number of Oxygen atom(s): \(pickerArray[randomMoleculeNumber].oxygenCount)"
        nitrogenLabel.text = "Number of Nitrogen atom(s): \(pickerArray[randomMoleculeNumber].nitrogenCount)"
        sulfurLabel.text = "Number of Sulfur atom(s): \(pickerArray[randomMoleculeNumber].sulfurCount)"
        if pickerArray[randomMoleculeNumber].ringCount == 1 {
            ringLabel.text = "Ring size:  \(pickerArray[randomMoleculeNumber].ringSize)"
        } else {
            ringLabel.text = "Number of rings: \(pickerArray[randomMoleculeNumber].ringCount)"
        }
        saturationLabel.text = pickerArray[randomMoleculeNumber].isSaturated ? "The molecule is saturated" : "The molecule is unsaturated"
        correctMolecule = pickerArray[randomMoleculeNumber]
       namePicker.selectRow(0, inComponent: 0, animated: true)
        
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
        
    
    
    func checkAnswer() {
        possibleAnswers.removeAll()
        submitButton.isEnabled = false
        let index = namePicker.selectedRow(inComponent: 0)
        let generator = UINotificationFeedbackGenerator()
       let selectedMolecule = pickerArray[index]
            if selectedMolecule.nitrogenCount == correctMolecule?.nitrogenCount && selectedMolecule.oxygenCount == correctMolecule?.oxygenCount && selectedMolecule.sulfurCount == correctMolecule?.sulfurCount && selectedMolecule.isSaturated == correctMolecule?.isSaturated && (selectedMolecule.ringCount == correctMolecule?.ringCount || selectedMolecule.ringSize == correctMolecule?.ringSize) {
                correctAnswer = true
                generator.notificationOccurred(.success)
                evaluationImageView.image = UIImage(named: "correctanswer")
                scoreSystem.updateCurrentScore()
                updateBestScore()
        } else {
            correctAnswer = false
                generator.notificationOccurred(.error)
        
                for molecule in pickerArray {
                    if molecule.nitrogenCount == correctMolecule?.nitrogenCount && molecule.oxygenCount == correctMolecule?.oxygenCount && molecule.sulfurCount == correctMolecule?.sulfurCount && molecule.isSaturated == correctMolecule?.isSaturated && (molecule.ringCount == correctMolecule?.ringCount || molecule.ringSize == correctMolecule?.ringSize) {
                        possibleAnswers.append(molecule.moleculeName)
                    }
                }
                correctAnswerLabel.text = "Correct answer: "
                for moleculeName in possibleAnswers {
                    if possibleAnswers.count == 1 {
                    correctAnswerLabel.text = "Correct answer: \(moleculeName)"
                    } else {
                        correctAnswerLabel.text = "Correct answers: \(possibleAnswers.joined(separator: ","))"
                    }
                }
            
            evaluationImageView.image = UIImage(named: "wronganswer")
    
        }
    
        animateEvaluation()
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        namePicker.isUserInteractionEnabled = false
        nextButton.isHidden = false
        showRewardAlert()
        
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
    
    
    func updateProgressBar() {
        currentQuestionLabel.text = "\(currentQuestion)"+"/"+"\(scoreSystem.maxScore)"
        
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBar.frame.size.width = (self.view.frame.width/CGFloat(self.scoreSystem.maxScore)) * CGFloat(self.currentQuestion)
        })
    }
    
    func updateBestScore() {
        switch scoreSystem.maxScore {
        case 20:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFiveBestScoreFor20, keyMaxAchieved: keys.gameFiveAchievedFor20, keyFlipCount: keys.gameFiveFlipCountFor20)
        case 30:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFiveBestScoreFor30, keyMaxAchieved: keys.gameFiveAchievedFor30, keyFlipCount: keys.gameFiveFlipCountFor30)
        case 40:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFiveBestScoreFor40, keyMaxAchieved: keys.gameFiveAchievedFor40, keyFlipCount: keys.gameFiveFlipCountFor40)
        case 50:
            scoreSystem.updateBestScore(keyBestScore: keys.gameFiveBestScoreFor50, keyMaxAchieved: keys.gameFiveAchievedFor50, keyFlipCount: keys.gameFiveFlipCountFor50)
        default:
            break
        }
    }
    
    func updateBestScoreLabel() {
        switch scoreSystem.maxScore {
        case 20:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFiveBestScoreFor20))"
        case 30:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFiveBestScoreFor30))"
        case 40:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFiveBestScoreFor40))"
        case 50:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameFiveBestScoreFor50))"
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
            if defaults.bool(forKey: keys.gameFiveAchievedFor20) == true && defaults.integer(forKey: keys.gameFiveFlipCountFor20) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFiveFlipCountFor20)
            }
        case 30:
            if defaults.bool(forKey: keys.gameFiveAchievedFor30) == true && defaults.integer(forKey: keys.gameFiveFlipCountFor30) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFiveFlipCountFor30)
            }
        case 40:
            if defaults.bool(forKey: keys.gameFiveAchievedFor40) == true && defaults.integer(forKey: keys.gameFiveFlipCountFor40) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFiveFlipCountFor40)
            }
        case 50:
            if defaults.bool(forKey: keys.gameFiveAchievedFor50) == true && defaults.integer(forKey: keys.gameFiveFlipCountFor50) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameFiveFlipCountFor50)
            }
        default:
            break
        }
        
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




extension QuizViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row].moleculeName
    }
    
    
}

extension QuizViewController: MaxScoreDelegate {
    func didSelectNumber(number: Int) {
        scoreSystem.maxScore = number
        restartGame()
    }
}
