//
//  CloudKit.swift
//  insta-client
//
//  Created by Rio Balderas on 3/27/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import Foundation
import CloudKit

class CloudKit {
   static let shared = CloudKit() //this makes it a singleton
   
   let container = CKContainer.default()
   
   var privateDatabase : CKDatabase {
      return container.privateCloudDatabase
   }
   
}
