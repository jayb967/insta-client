//
//  FilterCell.swift
//  insta-client
//
//  Created by Rio Balderas on 3/30/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
   @IBOutlet weak var imageView: UIImageView!
   
   @IBOutlet weak var filterNameLabel: UILabel!
   
   override func prepareForReuse() {
      super.prepareForReuse()
      
      self.imageView.image = nil
      self.filterNameLabel.text = nil
   }
}
