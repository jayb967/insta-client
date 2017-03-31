//
//  GalleryCell.swift
//  insta-client
//
//  Created by Rio Balderas on 3/29/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
   @IBOutlet weak var imageView: UIImageView!
   
   @IBOutlet weak var dateLabel: UILabel!
   var post: Post!{
      
      //property observers
      didSet{
         self.imageView.image = post.image
         self.dateLabel.text = DateFormatter.localizedString(from: post.creationDate!, dateStyle: .short, timeStyle: .short)//this formats the date so that it is shorter with date and time.
      }
   }
   //every collection view cells have
   //could use this rather than dequeing and queueing
   override func prepareForReuse() {
      super.prepareForReuse()
      
      self.imageView.image = nil
      self.dateLabel.text = nil
   }
}
