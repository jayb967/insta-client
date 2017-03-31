//
//  UIExtensions.swift
//  insta-client
//
//  Created by Rio Balderas on 3/28/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

extension UIImage {
   func resize(size: CGSize) -> UIImage? { //core graphics from UI
      UIGraphicsBeginImageContext(size)
      
      self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
      
      let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
      
      UIGraphicsEndImageContext()
      
      return resizedImage
   }
   
   var path: URL {
      guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
         fatalError("Error getting documents directory")
      }
      
      return documentsDirectory.appendingPathComponent("image")
      
   }
   
}
//makes strigified version of class aka galleryCell.indentifier
extension UIResponder {
   static var identifier : String {
      return String(describing: self)
   }
}
