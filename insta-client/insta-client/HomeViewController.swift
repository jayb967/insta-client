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
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
      
      print("Info:\(info)")
   }

   @IBAction func imageTapped(_ sender: Any) {
      print("User Tapped Image!")
      self.presentAlert()
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
