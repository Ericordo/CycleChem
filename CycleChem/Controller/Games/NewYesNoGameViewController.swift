//
//  NewYesNoGameViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 17/11/2020.
//  Copyright © 2020 Eric Ordonneau. All rights reserved.
//

import UIKit

class NewYesNoGameViewController: GameViewController {
    
    private let yesButton : UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.yes, for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        button.layer.cornerRadius = 40
        return button
    }()
    
    private let noButton : UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.no, for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        button.layer.cornerRadius = 40
        return button
    }()
    
    private let buttonStackView : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .equalCentering
        sv.axis = .horizontal
        return sv
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.text = "Molecule"
        return label
    }()
    
    private let moleculeImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let viewModel : YesNoGameViewModel
    
    init(viewModel: YesNoGameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        yesButton.addSoftUIEffectForButton(cornerRadius: 40, themeColor: Colors.mainColor)
        noButton.addSoftUIEffectForButton(cornerRadius: 40, themeColor: Colors.mainColor)
    }
    
    private func bindViewModel() {
        
    }
    
    
    private func setupUI() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(yesButton)
        buttonStackView.addArrangedSubview(noButton)
        view.addSubview(nameLabel)
        view.addSubview(moleculeImage)
        addConstraints()
    }
    
    private func addConstraints() {
        yesButton.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        
        noButton.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(80)
            make.bottom.equalToSuperview().offset(-150)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(nameLabel.font.lineHeight)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-50)
        }
        
        
    }
}
