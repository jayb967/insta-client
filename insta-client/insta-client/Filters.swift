//
//  Filters.swift
//  insta-client
//
//  Created by Rio Balderas on 3/28/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

enum FilterName : String {
   case vintage = "CIPhotoEffectTransfer"
   case blackAndWhite = "CIPhotoEffectMono"
   case hatchedScreen = "CIHatchedScreen"
   case zoomBlur = "CIZoomBlur"
   case xRay = "CIXRay"
}


typealias FilterCompletion = (UIImage?) -> ()

class Filters {
   
   static var originalImage : UIImage?  //makes instance that lives in class of "Filters"
   
   static let shared = Filters()//this makes class a singleton
   
   var context: CIContext
   
   private init() {
      let options = [kCIContextWorkingColorSpace: NSNull()]
      guard let eaglContext = EAGLContext(api: .openGLES2) else {fatalError("Failed to create EAGLContext")}//actual gpu context
      
      context = CIContext(eaglContext: eaglContext, options: options)
      
   }
   
   //   func filterChoices(name: String, title: String, filteredName: FilterName) -> UIAlertAction{
   //               let name = UIAlertAction(title: title, style: .default){(action) in
   //                  filter(name:filteredName, image: image, completion: {(filteredImage) in self.imageView.image = filteredImage})
   //               }
   //            }
   
 
   class func filter(name: FilterName, image: UIImage, completion: @escaping FilterCompletion) {
      OperationQueue().addOperation {
         
         for name in CIFilter.filterNames(inCategories: nil){
            print(name)
         }
         
         guard let filter = CIFilter(name: name.rawValue) else { fatalError("Failed to create CIFilter")}
         //changing image from UI to CI image and vice versa
         
         let coreImage = CIImage(image: image)
         filter.setValue(coreImage, forKey: kCIInputImageKey)
         
         //------------------------------------------------------------------------------------------------------------
         //GPU Context
         //         let options = [kCIContextWorkingColorSpace: NSNull()]
         //         guard let eaglContext = EAGLContext(api: .openGLES2) else {fatalError("Failed to create EAGLContext")}//actual gpu context
         
         //create CI context
         //         let ciContext = CIContext(eaglContext: eaglContext, options: options)
         
         //Get final image from using GPU
         guard let outputImage = filter.outputImage else {fatalError("Falied to get output image from Filter.")}
         
         if let cgImage = Filters.shared.context.createCGImage(outputImage, from: outputImage.extent){
            let finalImage = UIImage(cgImage: cgImage)
            
            OperationQueue.main.addOperation {
               completion(finalImage)
            }
         } else {
            OperationQueue.main.addOperation {
               completion(nil)
            }
         }
      }
      
      
   }
   
   
   //   class FilterActions : UIAlertAction {
   //
   //      func filterAction(title: title, style: style){(action) in filter(name: FilterName?, image.image, completion: {(filteredimage) in self.imageView.image = filteredImage})
   //      }
   //   }
}

//Filters.originalImage //this is how you would acces it
