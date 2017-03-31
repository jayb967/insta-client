//
//  GalleryCollectionViewLayout.swift
//  insta-client
//
//  Created by Rio Balderas on 3/29/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit



class GalleryCollectionViewLayout: UICollectionViewFlowLayout {
   var columns = 2 //specifies a number of comlumns
   let spacing: CGFloat = 1.0 //spacing between the items
   
   var screenWidth : CGFloat {
      return UIScreen.main.bounds.width //UISCreen.main is accesing full screen
   }
   
   var itemWidth : CGFloat {
      let availableScreen = screenWidth - (CGFloat(self.columns) * self.spacing)//holds on to available width, CGFloat makes it not an integer
      return availableScreen / CGFloat(self.columns)
   }
   
   init(columns : Int = 2) {
      self.columns = columns
      
      super.init()
      
      self.minimumLineSpacing = spacing
      self.minimumInteritemSpacing = spacing
      self.itemSize = CGSize(width: itemWidth, height: itemWidth)
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}
