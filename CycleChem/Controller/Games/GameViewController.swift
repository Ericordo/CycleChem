//
//  GameViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 16/11/2020.
//  Copyright © 2020 Eric Ordonneau. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private let header : UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        
        return button
    }()
    
    private let settingsButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let progressBar : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let scoreLabel : UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let bestScoreLabel : UILabel = {
        let label = UILabel()
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backButton.addSoftUIEffectForButton(cornerRadius: 18, themeColor: Colors.mainColor)
        settingsButton.addSoftUIEffectForButton(cornerRadius: 18, themeColor: Colors.mainColor)
        
    }
    
    @objc private func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSettings() {
        
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.mainColor
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        view.addSubview(header)
        header.addSubview(titleLabel)
        header.addSubview(backButton)
        header.addSubview(settingsButton)
        view.addSubview(progressBar)
        view.addSubview(scoreLabel)
        view.addSubview(bestScoreLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        
        
        
        header.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(46)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        
        progressBar.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(header.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
