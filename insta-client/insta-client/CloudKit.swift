//
//  CloudKit.swift
//  insta-client
//
//  Created by Rio Balderas on 3/27/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit
import CloudKit

typealias PostCompletion = (Bool) -> ()
typealias PostsCompletion = ([Post]?) -> ()

class CloudKit {
   static let shared = CloudKit() //this makes it a singleton
   
   let container = CKContainer.default()
   
   var privateDatabase : CKDatabase {
      return container.privateCloudDatabase
   }
   func save(post: Post, completion: @escaping PostCompletion) {
      do {
         if let record = try Post.recordFor(post: post){
            
            privateDatabase.save(record, completionHandler: { (record, error) in
               
               if error != nil{
                completion(false)
                  print(error?.localizedDescription)
                  
                  return
               }
               if let record = record {
                  print(record)
                  completion(true)
               } else {
                  completion(false)
               }
               
            })
         }
      } catch {
         print(error)
      }
   }
   
   func getPosts(completion: @escaping PostsCompletion) {
      //cloudkit query
      let postQuery = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))//predicate is a way of organizing data in a certain order
      
      self.privateDatabase.perform(postQuery, inZoneWith: nil) { (records, error) in
         if error != nil {
            OperationQueue.main.addOperation {
               completion(nil)
            }
         }
         
         if let records = records {
            
            var posts = [Post]()//
            for record in records {
               
               let date = record.creationDate
               
               if let asset = record["image"] as? CKAsset {
                  let path = asset.fileURL.path //going to give path to where it wrote asset
                  if let image = UIImage(contentsOfFile: path){
                     let newPost = Post(image: image, creationDate: date)
                     posts.append(newPost)
                  }
                  
               }
               
            }
            OperationQueue.main.addOperation {
               completion(posts)
            }
            
         }
         
         
      }
   }
}
