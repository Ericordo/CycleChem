//
//  DrawMoleculeViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 06/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

struct CellData {
    var opened = Bool()
    var title = String()
    var sectionData: [String]? = [String]()
}

class DrawMoleculeViewController: UIViewController {

    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var moleculeNameLabel: UILabel!
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var evaluationImageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectedMoleculeImageView: UIImageView!
    @IBOutlet weak var correctAnswerView: UIView!
    
    @IBOutlet weak var progressBarTrailing: NSLayoutConstraint!
    
    
    let propertySwitch = UISwitch()
    
    let moleculeList = MoleculeBank()
    
    
    var tableViewData = [CellData]()
    var givenAnswer = Answer()
    var answerToGive = Answer()
    var randomNumber = Int()
    var gameArray = [Int]()
    var currentQuestion = 1
    var scoreSystem = Score()
    var gameOver = false
    var correctAnswer = false
    var selectedMoleculeImage = UIImage()
    let keys = Keys()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Select all that apply"
        randomNumber = Int.random(in: 0..<moleculeList.list.count)
        gameArray.append(randomNumber)
        gameTableView.delegate = self
        gameTableView.dataSource = self
        gameTableView.tableFooterView = UIView(frame: CGRect.zero)
        gameTableView.separatorStyle = .none
        
        updateGame()
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = settingsButton
        

        
        tableViewData = [CellData(opened: false, title: "Contains Nitrogen", sectionData: ["Number of Nitrogen atoms: \(givenAnswer.nitrogenCount)"]),
                         CellData(opened: false, title: "Contains Oxygen", sectionData: ["Number of Oxygen atoms: \(givenAnswer.oxygenCount)"]),
                         CellData(opened: false, title: "Contains Sulfur", sectionData: ["Number of Sulfur atoms: \(givenAnswer.sulfurCount)"]),
                         CellData(opened: false, title: "Molecule has only one ring", sectionData: ["Size of the ring: \(givenAnswer.ringSize)"]),
                         CellData(opened: false, title: "Molecule is saturated", sectionData: nil)]

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
        submitButton.isEnabled = true
        nextButton.isHidden = true
        if gameArray.count == 0 {
            randomNumber = Int.random(in: 0..<moleculeList.list.count)
            gameArray.append(randomNumber)
        } else {
            while gameArray.count < currentQuestion {
                randomNumber = Int.random(in: 0..<moleculeList.list.count)
                if !gameArray.contains(randomNumber) {
                    gameArray.append(randomNumber)
                }
            }
        }
        let selectedMolecule = moleculeList.list[randomNumber]
        selectedMoleculeImage = selectedMolecule.image
        let selectedMoleculeRingBool = selectedMolecule.ringSize == 0 ? false : true
        answerToGive = Answer(hasNitrogen: selectedMolecule.hasNitrogen, hasOxygen: selectedMolecule.hasOxygen, hasSulfur: selectedMolecule.hasSulfur, nitrogenCount: selectedMolecule.nitrogenCount, oxygenCount: selectedMolecule.oxygenCount, sulfurCount: selectedMolecule.sulfurCount, hasOnlyOneRing: selectedMoleculeRingBool, ringSize: selectedMolecule.ringSize, ringCount: selectedMolecule.ringCount, isSaturated: selectedMolecule.isSaturated)
        moleculeNameLabel.text = selectedMolecule.moleculeName
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        evaluationImageView.alpha = 0
        correctAnswerView.alpha = 0
        selectedMoleculeImageView.alpha = 0
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
        updateTableView()
    }
    
    func animateEvaluation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.evaluationImageView.alpha = 1
            if !self.correctAnswer {
                self.correctAnswerView.alpha = 1
                self.selectedMoleculeImageView.alpha = 1

            }
        })
    }
    
    func updateProgressBar() {
        currentQuestionLabel.text = "\(currentQuestion)"+"/"+"\(scoreSystem.maxScore)"
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBarTrailing.constant = self.view.frame.width - (self.view.frame.width/(CGFloat(self.scoreSystem.maxScore)) * CGFloat(self.currentQuestion))
            self.view.layoutIfNeeded()
        })
    }
    
    func updateBestScore() {
        switch scoreSystem.maxScore {
        case 20:
            scoreSystem.updateBestScore(keyBestScore: keys.gameSixBestScoreFor20, keyMaxAchieved: keys.gameSixAchievedFor20, keyFlipCount: keys.gameSixFlipCountFor20)
        case 30:
            scoreSystem.updateBestScore(keyBestScore: keys.gameSixBestScoreFor30, keyMaxAchieved: keys.gameSixAchievedFor30, keyFlipCount: keys.gameSixFlipCountFor30)
        case 40:
            scoreSystem.updateBestScore(keyBestScore: keys.gameSixBestScoreFor40, keyMaxAchieved: keys.gameSixAchievedFor40, keyFlipCount: keys.gameSixFlipCountFor40)
        case 50:
            scoreSystem.updateBestScore(keyBestScore: keys.gameSixBestScoreFor50, keyMaxAchieved: keys.gameSixAchievedFor50, keyFlipCount: keys.gameSixFlipCountFor50)
        default:
            break
        }
    }
    
    func updateBestScoreLabel() {
        switch scoreSystem.maxScore {
        case 20:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameSixBestScoreFor20))"
        case 30:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameSixBestScoreFor30))"
        case 40:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameSixBestScoreFor40))"
        case 50:
            bestScoreLabel.text = "Best Score: \(defaults.integer(forKey: keys.gameSixBestScoreFor50))"
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
            if defaults.bool(forKey: keys.gameSixAchievedFor20) == true && defaults.integer(forKey: keys.gameSixFlipCountFor20) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameSixFlipCountFor20)
            }
        case 30:
            if defaults.bool(forKey: keys.gameSixAchievedFor30) == true && defaults.integer(forKey: keys.gameSixFlipCountFor30) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameSixFlipCountFor30)
            }
        case 40:
            if defaults.bool(forKey: keys.gameSixAchievedFor40) == true && defaults.integer(forKey: keys.gameSixFlipCountFor40) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameSixFlipCountFor40)
            }
        case 50:
            if defaults.bool(forKey: keys.gameSixAchievedFor50) == true && defaults.integer(forKey: keys.gameSixFlipCountFor50) < 1 {
                self.present(rewardAlert, animated: true, completion: nil)
                defaults.set(1, forKey: keys.gameSixFlipCountFor50)
            }
        default:
            break
        }
        
    }
    
    
    func checkAnswer() {
        submitButton.isEnabled = false
        if givenAnswer.hasNitrogen == false {
            givenAnswer.nitrogenCount = 0
        }
        if givenAnswer.hasOxygen == false {
            givenAnswer.oxygenCount = 0
        }
        if givenAnswer.hasSulfur == false {
            givenAnswer.sulfurCount = 0
        }
        if givenAnswer.hasOnlyOneRing == false {
            givenAnswer.ringSize = 0
            givenAnswer.ringCount = 2
        }
        givenAnswer = Answer(hasNitrogen: givenAnswer.hasNitrogen, hasOxygen: givenAnswer.hasOxygen, hasSulfur: givenAnswer.hasSulfur, nitrogenCount: givenAnswer.nitrogenCount, oxygenCount: givenAnswer.oxygenCount, sulfurCount: givenAnswer.sulfurCount, hasOnlyOneRing: givenAnswer.hasOnlyOneRing, ringSize: givenAnswer.ringSize, ringCount: givenAnswer.ringCount, isSaturated: givenAnswer.isSaturated)
        let generator = UINotificationFeedbackGenerator()
        if givenAnswer.hasNitrogen == answerToGive.hasNitrogen && givenAnswer.hasOxygen == answerToGive.hasOxygen && givenAnswer.hasSulfur == answerToGive.hasSulfur && givenAnswer.nitrogenCount == answerToGive.nitrogenCount && givenAnswer.oxygenCount == answerToGive.oxygenCount && givenAnswer.sulfurCount == answerToGive.sulfurCount && givenAnswer.ringCount == answerToGive.ringCount && givenAnswer.ringSize == answerToGive.ringSize && givenAnswer.isSaturated == answerToGive.isSaturated {
            generator.notificationOccurred(.success)
            correctAnswer = true
            evaluationImageView.image = UIImage(named: "correctanswer")
            scoreSystem.updateCurrentScore()
            updateBestScore()
        } else {
            generator.notificationOccurred(.error)
            correctAnswer = false
            selectedMoleculeImageView.image = selectedMoleculeImage.withRenderingMode(.alwaysTemplate)
            selectedMoleculeImageView.tintColor = .white

            evaluationImageView.image = UIImage(named: "wronganswer")
        }
        animateEvaluation()
        currentScoreLabel.text = "Score: \(scoreSystem.currentScore)"
        updateBestScoreLabel()
        nextButton.isHidden = false
        showRewardAlert()
        
    }
    
    @objc func switchTapped(sender: UISwitch) {
        tableViewData[sender.tag].opened = !tableViewData[sender.tag].opened
        let indexPath = IndexPath(row: 0, section: sender.tag)
        if sender.tag != 4 {
            if tableViewData[sender.tag].opened == false {
                gameTableView.deleteRows(at: [indexPath], with: .none)
            } else {
                gameTableView.insertRows(at: [indexPath], with: .none)
            }
        }
        
        switch sender.tag {
        case 0:
            givenAnswer.hasNitrogen = !givenAnswer.hasNitrogen
            print(givenAnswer.hasNitrogen)
        case 1:
            givenAnswer.hasOxygen = !givenAnswer.hasOxygen
        case 2:
            givenAnswer.hasSulfur = !givenAnswer.hasSulfur
        case 3:
            givenAnswer.hasOnlyOneRing = !givenAnswer.hasOnlyOneRing
            givenAnswer.ringCount = givenAnswer.hasOnlyOneRing ? 1 : 2
        case 4:
            givenAnswer.isSaturated = !givenAnswer.isSaturated
        default:
            break
        }
  
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        checkAnswer()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if gameOver {
            restartGame()
        } else {
            currentQuestion += 1
            updateGame()
            updateTableView()
        }
    }
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        
        switch sender.tag {
        case 0:
            givenAnswer.nitrogenCount = Int(sender.value)
            print("From stepper \(Int(sender.value))")
            tableViewData[sender.tag].sectionData![0] = "Number of Nitrogen atoms: \(givenAnswer.nitrogenCount)"
        case 1:
            givenAnswer.oxygenCount = Int(sender.value)
            tableViewData[1].sectionData![0] = "Number of Oxygen atoms: \(givenAnswer.oxygenCount)"
        case 2:
            givenAnswer.sulfurCount = Int(sender.value)
            tableViewData[2].sectionData![0] = "Number of Sulfur atoms: \(givenAnswer.sulfurCount)"
        case 3:
            givenAnswer.ringSize = Int(sender.value)
            tableViewData[3].sectionData![0] = "Size of the ring: \(givenAnswer.ringSize)"
        default:
            break
        }
        gameTableView.reloadData()
    }
    
    func updateTableView() {
        for i in 0..<tableViewData.count{
            tableViewData[i].opened = false
        }
        givenAnswer.hasNitrogen = false
        givenAnswer.hasOxygen = false
        givenAnswer.hasSulfur = false
        givenAnswer.hasOnlyOneRing = false
        givenAnswer.isSaturated = false
        givenAnswer.nitrogenCount = 0
        givenAnswer.oxygenCount = 0
        givenAnswer.sulfurCount = 0
        givenAnswer.ringSize = 0

                tableViewData[0].sectionData![0] = "Number of Nitrogen atoms: \(givenAnswer.nitrogenCount)"
                tableViewData[1].sectionData![0] = "Number of Oxygen atoms: \(givenAnswer.oxygenCount)"
                tableViewData[2].sectionData![0] = "Number of Sulfur atoms: \(givenAnswer.sulfurCount)"
                tableViewData[3].sectionData![0] = "Size of the ring: \(givenAnswer.ringSize)"
        
        
  
    
        gameTableView.reloadData()
        
    }
    
 

}

extension DrawMoleculeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return 0
        } else {
            if tableViewData[section].opened == true {
                return tableViewData[section].sectionData!.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gameTableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        cell.gameLabel.text = tableViewData[indexPath.section].sectionData?[indexPath.row]
        cell.gameLabel.adjustsFontSizeToFitWidth = true
        cell.gameStepper.tag = indexPath.section
        switch indexPath.section {
        case 0:
            if givenAnswer.nitrogenCount != Int(cell.gameStepper.value) {
                cell.gameStepper.reset()
            }
        case 1:
            if givenAnswer.oxygenCount != Int(cell.gameStepper.value) {
                cell.gameStepper.reset()
            }
        case 2:
            if givenAnswer.sulfurCount != Int(cell.gameStepper.value) {
                cell.gameStepper.reset()
            }
        case 3:
            if givenAnswer.ringSize != Int(cell.gameStepper.value) {
                cell.gameStepper.reset()
            }
        default:
            break
        }
       
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let tableViewCell = GameTableViewCell()
        return tableViewCell.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 184/255, green: 234/255, blue: 1, alpha: 1)

            
            let label = UILabel()
//            label.text = sections[section]
            label.text = tableViewData[section].title
            label.adjustsFontSizeToFitWidth = true
            label.frame = CGRect(x: 10, y: 11, width: 290, height: 21)
            view.addSubview(label)
            let control = UISwitch()
            switch section {
            case 0:
               control.isOn = givenAnswer.hasNitrogen
            case 1:
                control.isOn = givenAnswer.hasOxygen
            case 2:
                control.isOn = givenAnswer.hasSulfur
            case 3:
                control.isOn = givenAnswer.hasOnlyOneRing
            case 4:
                control.isOn = givenAnswer.isSaturated
            default:
                break
            }
//            control.isOn = givenAnswer.hasNitrogen
            control.tag = section
            control.frame = CGRect(x: 350, y: 5, width: 100, height: 30)
            control.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
            view.addSubview(control)
            control.translatesAutoresizingMaskIntoConstraints = false
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            return view
        }()
        return headerView
    }
    
}

extension DrawMoleculeViewController: MaxScoreDelegate {
    func didSelectNumber(number: Int) {
        scoreSystem.maxScore = number
        restartGame()
    }
}

extension UIStepper {
    func reset() {
        self.value = 0
    }
}
