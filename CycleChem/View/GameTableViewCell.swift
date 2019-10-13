//
//  GameTableViewCell.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 13/05/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var gameStepper: UIStepper!
    
//    var cellData: CellData! {
//        didSet {
//            gameLabel.text = cellData.sectionData![gameStepper.tag]
//        }
//    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red: 1, green: 211/255, blue: 211/255, alpha: 1)
        gameStepper.minimumValue = 0
        gameStepper.maximumValue = 9
        self.selectionStyle = .none
     
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
