//
//  GamesViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 12/04/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//
// APP-ID : ca-app-pub-2576147676997057~9934223514
// ADD-ID : ca-app-pub-2576147676997057/2957751622

import UIKit
import GoogleMobileAds

class GamesViewController: UIViewController {

    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonArray.forEach { (button) in
            button.layer.cornerRadius = 10
            button.titleLabel?.textAlignment = .center
            button.titleEdgeInsets = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
        }
        
        
        let achievementsButton = UIBarButtonItem(image: UIImage(named: "achievements"), style: .plain, target: self, action: #selector(achievementsButtonTapped))
        achievementsButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = achievementsButton

        bannerView.adUnitID = "ca-app-pub-2576147676997057/2957751622"
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = [ "2073d7c67f85b9f1e4093b2ee2d8a368" ]
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        
        let bonusPurchased : Bool = defaults.bool(forKey: "com.price.ads50questions")
        
        if bonusPurchased {
            bannerView.isHidden = true
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let bonusPurchased : Bool = defaults.bool(forKey: "com.price.ads50questions")
        
        if bonusPurchased {
            bannerView.isHidden = true
        }
    }
    
    @objc func achievementsButtonTapped(sender: UIBarButtonItem) {
        let achievementsVC = self.storyboard?.instantiateViewController(withIdentifier: "AchievementsController")
        achievementsVC?.modalPresentationStyle = .overFullScreen
        self.navigationController!.pushViewController(achievementsVC!, animated: true)
    }
    
    


}

extension GamesViewController : GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
}
