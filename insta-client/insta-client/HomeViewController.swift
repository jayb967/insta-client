//
//  HomeViewController.swift
//  insta-client
//
//  Created by Rio Balderas on 3/27/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   let imagePicker = UIImagePickerController()
   
   @IBOutlet weak var imageView: UIImageView!
   
   @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
   
   @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
  
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
           }
      
 
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      filterButtonTopConstraint.constant = 8
      postButtonBottomConstraint.constant = 8
   
      
      UIView.animate(withDuration: 1.0) {
         self.view.layoutIfNeeded()

   }
   }
   
   func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType){
      
      self.imagePicker.delegate = self
      self.imagePicker.sourceType = sourceType
      self.present(self.imagePicker, animated: true, completion: nil)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      self.dismiss(animated: true, completion: nil) //allows user to cancel and dismisses
   }
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      
      
      if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
         self.imageView.image = originalImage
         Filters.originalImage = originalImage
      }
      imagePicker.dismiss(animated: true, completion: nil)
      print("Info:\(info)")
   }

   @IBAction func imageTapped(_ sender: Any) {
      print("User Tapped Image!")
      self.presentAlert()
   }
   
   @IBAction func postButtonPressed(_ sender: Any) {
      
      if let image = self.imageView.image {
         
         let newPost = Post(image: image)
         
         CloudKit.shared.save(post: newPost, completion: { (success) in
            if success {
            print("Saved Post successfully to CloudKit")
            } else {
               print("We did not successfully save to CloudKit")
            }
         })
         
      }
      
   }

   @IBAction func filterButtonPressed(_ sender: Any) {
      
      guard let image = self.imageView.image else { return }
      
      let alertController = UIAlertController(title: "Filter", message: "Please select a filter", preferredStyle: .alert)
      
      let blackAndWhiteAction = UIAlertAction(title: "Black & White", style: .default) { (action) in
         Filters.filter(name: .blackAndWhite, image: image, completion: { (filteredImage) in
            self.imageView.image = filteredImage
         })
      }
      
      let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
         Filters.filter(name: .vintage, image: image, completion: { (filteredimage) in
            self.imageView.image = filteredimage
         })
      }
      
      let hatchedAction = UIAlertAction(title: "Hatched", style: .default) { (action) in
         Filters.filter(name: .hatchedScreen, image: image
            , completion: { (filteredImage) in
               self.imageView.image = filteredImage
         })
      }
      
      let zoomBlurAction = UIAlertAction(title: "Zoom Blur", style: .default) { (action) in
         Filters.filter(name: .zoomBlur, image: image, completion: { (filteredImage) in
            self.imageView.image = filteredImage
         })
      }
      
      let xRayAction = UIAlertAction(title: "X-Ray", style: .default) { (action) in
         Filters.filter(name: .xRay, image: image, completion: { (filteredImage) in
            self.imageView.image = filteredImage
         })
      }
      
      
      let resetAction = UIAlertAction(title: "Reset Image", style: .destructive) { (action) in
         self.imageView.image = Filters.originalImage
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      
      alertController.addAction(blackAndWhiteAction)
      alertController.addAction(vintageAction)
      alertController.addAction(hatchedAction)
      alertController.addAction(zoomBlurAction)
      alertController.addAction(xRayAction)
      alertController.addAction(resetAction)
      alertController.addAction(cancelAction)
      
      
      self.present(alertController, animated: true, completion: nil)
      
      
   }
   
   func presentAlert(){
      let alertController = UIAlertController(title: "Source", message: "Please Select Source Type", preferredStyle: .alert)
      
      let cameraAction = UIAlertAction(title: "Camera", style: .default) {(action) in
      self.presentImagePickerWith(sourceType: .camera)}
      
      let photoAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
         self.presentImagePickerWith(sourceType: .photoLibrary)
         
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
      
      alertController.addAction(cameraAction)
      alertController.addAction(photoAction)
      alertController.addAction(cancelAction)
      
      self.present(alertController, animated: true, completion: nil)
      
      
      
   }
   

}
