//
//  FilterCell.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 03/05/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FilterCell : UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            iconImageView.isHidden = !iconImageView.isHidden
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var filterOption : FilterOption? {
        didSet {
            nameLabel.text = filterOption?.name
//            if let imageName = filterOption?.imageName {
//                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
//                iconImageView.tintColor = .black
//            }
//            iconImageView.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
//            iconImageView.tintColor = .black
        }
    }
    
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark")
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let bottomLineSeparator = CALayer()
        bottomLineSeparator.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 0.5)
        bottomLineSeparator.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(bottomLineSeparator)
        
    }

    
    
}
