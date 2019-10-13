//
//  CustomUIButton.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 06/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class CustomUIButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
    }

}

class YesButton: CustomUIButton {
   override func setupButton() {
        super.setupButton()
        self.setBackgroundImage(UIImage(named: "YesButton"), for: .normal)
    }
}

class NoButton: CustomUIButton {
    override func setupButton() {
        super.setupButton()
        self.setBackgroundImage(UIImage(named: "NoButton"), for: .normal)
    }
    
}



//class RevealButton: CustomUIButton {
//    override func setupButton() {
//        super.setupButton()
//        self.setBackgroundImage(UIImage(named: "revealbutton"), for: .normal)
//    }
//}


