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
    
    private let bannerView = GADBannerView()
    
    private lazy var buttonOne = createGameButton(tintColor: .systemRed, icon: "airplane")
    private lazy var buttonTwo = createGameButton(tintColor: .systemTeal, icon: "bandage.fill")
    private lazy var buttonThree = createGameButton(tintColor: .systemPink, icon: "camera.fill")
    private lazy var buttonFour = createGameButton(tintColor: .systemIndigo, icon: "gift.fill")
    private lazy var buttonFive = createGameButton(tintColor: .systemPurple, icon: "flame.fill")
    private lazy var buttonSix = createGameButton(tintColor: .systemOrange, icon: "pause.circle.fill")
    
    var buttons = [UIButton]()
    
    let overallStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.spacing = 20
        return sv
    }()
    
    let stackViewOne : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
       let stackViewTwo : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
    let stackViewThree : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
    private let achievementsButton : UIButton = {
        let button = UIButton()
        button.setImage(Images.achievements, for: .normal)
        button.setTitle("  \(AppStrings.achievements)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        return button
    }()
    
    private let infoButton : UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBanner()
        bindViewModel()
        
//        buttonArray.forEach { (button) in
//            button.layer.cornerRadius = 10
//            button.titleLabel?.textAlignment = .center
//            button.titleEdgeInsets = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
//        }
        
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let bonusPurchased : Bool = defaults.bool(forKey: "com.price.ads50questions")
        bannerView.isHidden = bonusPurchased
        buttons.forEach { button in
            button.addSoftUIEffectForButton(cornerRadius: 20,
                                            themeColor: Colors.mainColor)
        }
        achievementsButton.addSoftUIEffectForButton(cornerRadius: 10,
                                                    themeColor: Colors.mainColor)
    }
    
    private func bindViewModel() {
        buttonOne.reactive.controlEvents(.touchUpInside).observeValues { _ in
            let GameOneVC = NewYesNoGameViewController(viewModel: YesNoGameViewModel())
            self.navigationController?.pushViewController(GameOneVC, animated: true)
        }
        
        achievementsButton.reactive.controlEvents(.touchUpInside).observeValues { _ in
            let achievementsVC = AchievementsViewController()
            self.present(achievementsVC, animated: true, completion: nil)
        }
    }
    
    private func setupBanner() {
        bannerView.adUnitID = "ca-app-pub-2576147676997057/2957751622"
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = ["2073d7c67f85b9f1e4093b2ee2d8a368"]
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    private func setupUI() {
        self.view.backgroundColor = Colors.mainColor
        self.navigationController?.navigationBar.isHidden = true
        buttons = [buttonOne,
                   buttonTwo,
                   buttonThree,
                   buttonFour,
                   buttonFive,
                   buttonSix]
        view.addSubview(bannerView)
        view.addSubview(achievementsButton)
        view.addSubview(overallStackView)
        overallStackView.addArrangedSubview(stackViewOne)
        overallStackView.addArrangedSubview(stackViewTwo)
        overallStackView.addArrangedSubview(stackViewThree)
        stackViewOne.addArrangedSubview(buttonOne)
        stackViewOne.addArrangedSubview(buttonTwo)
        stackViewTwo.addArrangedSubview(buttonThree)
        stackViewTwo.addArrangedSubview(buttonFour)
        stackViewThree.addArrangedSubview(buttonFive)
        stackViewThree.addArrangedSubview(buttonSix)
        addConstraints()
    }
    
    private func addConstraints() {
        bannerView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(320)
            make.bottom.equalToSuperview().offset(-110)
            make.centerX.equalToSuperview()
        }
        
        achievementsButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bannerView.snp.top).offset(-20)
        }
        
        overallStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(achievementsButton.snp.top).offset(-30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        buttons.forEach { button in
            button.snp.makeConstraints { make in
                make.width.height.equalTo(100)
            }
        }
    }
    
    private func createGameButton(tintColor: UIColor, icon: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: icon, withConfiguration: configuration)
        button.tintColor = tintColor
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        return button
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
