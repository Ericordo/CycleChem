//
//  SliderViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 07/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//  IAP : com.price.ads50questions

import UIKit
import StoreKit

protocol MaxScoreDelegate {
    func didSelectNumber(number: Int)
}


var bonusPurchased : Bool = false

class SliderViewController: UIViewController {
    
    var maxScoreDelegate: MaxScoreDelegate!
    
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var maxScoreSlider: UISlider!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var scoreSystem = Score()
    
    var products: [SKProduct] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sliderView.layer.cornerRadius = 10
        sliderView.layer.masksToBounds = true
        sliderView.layer.borderWidth = 2
        sliderView.layer.borderColor = UIColor.black.cgColor

        
        confirmButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        instructionLabel.text = "Select the number of questions: "
        updateValueLabel()

    }
    
    func updateValueLabel() {
        sliderValueLabel.text = "\(scoreSystem.maxScore)"
    }
    
    
    @IBAction func maxScoreSliderMoved(_ sender: UISlider) {
        
        
        sender.value = roundf(sender.value)
        let valueSelected = sender.value

        switch valueSelected {
        case 0.0:
            scoreSystem.maxScore = 20
        case 1.0:
            scoreSystem.maxScore = 30
        case 2.0:
            scoreSystem.maxScore = 40
        case 3.0:
            scoreSystem.maxScore = 50
        default:
            scoreSystem.maxScore = 20
        }
        updateValueLabel()
        
    }
    
    func showPurchaseAlert() {
        
        IAPProduct.store.requestProducts{ [weak self] success, products in
            guard let self = self else { return }
            if success {
                self.products = products!
            }
        }
        let purchaseAlert = UIAlertController(title: "In-App Purchase", message: "Unlock the 50 questions and remove the ad.", preferredStyle: .alert)
        let buy = UIAlertAction(title: "Buy", style: .default) { action in self.buyPurchase() }
        let restore = UIAlertAction(title: "Restore Purchase", style: .default, handler: { action in self.restorePurchase() })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        purchaseAlert.addAction(buy)
        purchaseAlert.addAction(restore)
        purchaseAlert.addAction(cancel)
        self.present(purchaseAlert, animated: true, completion: nil)
    }
    
    func showPaymentNotAvailable() {
        let purchaseAlert = UIAlertController(title: "In-App Purchase", message: "Not available", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        purchaseAlert.addAction(cancel)
        self.present(purchaseAlert, animated: true, completion: nil)
    }
    
    func buyPurchase() {
        IAPProduct.store.buyProduct(products[0])
    }
    
    func restorePurchase() {
       IAPProduct.store.restorePurchases()
    }
    
    
    
    
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        let bonusPurchased = defaults.bool(forKey: "com.price.ads50questions")
        if scoreSystem.maxScore == 50 && bonusPurchased == false
        {
            if IAPHelper.canMakePayments() {
                showPurchaseAlert()
            } else {
                showPaymentNotAvailable()
            }
        } else {
        maxScoreDelegate.didSelectNumber(number: scoreSystem.maxScore)
        dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
