//
//  Post.swift
//  insta-client
//
//  Created by Rio Balderas on 3/28/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Post {
   let image: UIImage //because it snot optional it need to be initialized
   let creationDate: Date?
   
   init(image: UIImage, creationDate: Date?) { //initializing here
      self.image = image
      self.creationDate = creationDate
   }
}

enum PostError : Error {
   case writingImageToData
   case writingDataToDisk
}

extension Post {
   class func recordFor(post: Post) throws -> CKRecord? {
      guard let data = UIImageJPEGRepresentation (post.image, 0.7) else { throw PostError.writingImageToData }
      
      do{
         try data.write(to: post.image.path)
         
         let asset = CKAsset(fileURL: post.image.path)
         
         let record = CKRecord(recordType: "Post")
         record.setValue(asset, forKey: "image")
         
         return record
         
      } catch {
         throw PostError.writingDataToDisk
      }
      
   }
   
}
