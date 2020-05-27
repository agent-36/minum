//
//  SecondViewController.swift
//  minum
//
//  Created by Ihwan ID on 12/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var drinkSlider: UISlider!
    @IBOutlet weak var drinkSliderLbl: UILabel! 
    @IBOutlet weak var saveBtnLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtnLbl.layer.cornerRadius = 10
    }

    @IBAction func drinkSliderAct(_ sender: Any) {
        let sliderValue = Int(drinkSlider.value)
        drinkSliderLbl.text = String("\(sliderValue)ml")
    }
    
//    @IBAction func sliderValueChanged(_ sender: UISlider) {
//        let currentValue = Int(sender.value)
//
//        label.text = "\(currentValue)"
//    }
     
    @IBAction func saveBtnAction(_ sender: Any) {
    }
    
    @IBAction func onChangePictureButtonClicked(_ sender: UIButton) {
let actionSheet = UIAlertController(title: "Change Picture",
                                            message: "Please select your picture source",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { [unowned self] (action) in
           self.openPhotoGallery()
        }))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [unowned self] (action) in
            self.openCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
     func openPhotoGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
     //open photo from iphone library
     func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
     //open iphone camera
}
        

////extension DrinkViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
////    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        dismiss(animated: true, completion: nil)
////    }
//
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
////        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
////            self.imagePickedBlock?(image)
////        }else{
////            print("Something went wrong")
////        }
////        currentVC.dismiss(animated: true, completion: nil)
////    }
//}

extension DrinkViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
      
      func imagePickerController(_ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              imageView.image = image
          }
          dismiss(animated: true, completion: nil)
      }
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          dismiss(animated: true, completion: nil)
      }
      
  }




