//
//  FullListCell.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 10/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FullListCell: UITableViewCell {
    
    static let reuseID = "FullListCell"
    
    private let backgroundViewCell : UIView = {
        let view = UIView()
        return view
    }()
    
    private let moleculeImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with molecule: Molecule) {
        self.moleculeImage.image = molecule.image
        self.nameLabel.text = molecule.name
    }
    
    private func setupCell() {
        self.backgroundColor = Colors.mainColor
        self.selectionStyle = .none
//        self.addSoftUIEffectForView()
        self.contentView.addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(moleculeImage)
        backgroundViewCell.addSubview(nameLabel)
        backgroundViewCell.backgroundColor = Colors.mainColor
        backgroundViewCell.addSoftUIEffectForView()
//        self.contentView.addSubview(moleculeImage)
//        self.contentView.addSubview(nameLabel)
        addConstraints()
    }
    
    private func addConstraints() {
        
        backgroundViewCell.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
        
        moleculeImage.snp.makeConstraints { make in
            make.height.width.equalTo(90)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(self.moleculeImage.snp.trailing).offset(60)
        }
    }
}
