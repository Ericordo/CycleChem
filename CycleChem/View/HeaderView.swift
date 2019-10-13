//
//  HeaderView.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 26/05/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setpUpHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerLabel : UILabel = {
        let label = UILabel()
        
//        label.frame = CGRect(x: 5, y: 5, width: 10, height: 10)
        
        
        
        return label
    }()
    
    
    func setpUpHeader() {
        
        self.backgroundColor = .lightGray
        self.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true    }
}
