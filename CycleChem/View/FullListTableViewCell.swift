//
//  FullListTableViewCell.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 10/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FullListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        
        // Initialization code
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

        // Configure the view for the selected state
    }

}
