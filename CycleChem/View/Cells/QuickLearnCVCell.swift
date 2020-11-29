//
//  QuickLearnCVCell.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 06/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class QuickLearnCVCell: UICollectionViewCell {
    
    static let reuseID = "QuickLearnCVCell"
    
    private let moleculeImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with molecule: Molecule, and learningType: LearningType) {
        moleculeImage.image = molecule.image
        nameLabel.text = molecule.name
        moleculeImage.isHidden = learningType.hideMolecule
        nameLabel.isHidden = learningType.hideName
        
    }
    
    func revealEverything() {
        moleculeImage.isHidden = false
        nameLabel.isHidden = false
    }
    
    private func setupCell() {
////        self.backgroundColor = .systemBackground
//        self.backgroundColor = Colors.mainColor
//        self.layer.cornerRadius = 35
//        self.layer.borderWidth = 2
//        self.layer.borderColor = UIColor.black.cgColor
////        self.layer.masksToBounds = true
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
//        self.layer.shadowRadius = 6
//        self.layer.shadowOpacity = 1.0
//        self.layer.masksToBounds = false
        self.addSoftUIEffectForView()
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(moleculeImage)
        addConstraints()
    }
    
    
    
    private func addConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(self.nameLabel.font.lineHeight)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        moleculeImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalTo(nameLabel.snp.top).offset(-20)
        }
    }
    
  
    
    
}
