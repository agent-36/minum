//  PreviewViewController.swift
//  minum
//
//  Created by Edo Lorenza on 29/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//
import UIKit
import CoreML
import Vision

class PreviewViewController: UIViewController {
   
   @IBOutlet weak var ResultPhoto: UIImageView!
   @IBOutlet weak var photoView: UIImageView!
   @IBOutlet weak var drinkBtnLbl: UIButton!
   @IBOutlet weak var waterVolumeTextField: UITextField!
    
   let volumes = ["100",
               "200",
               "300",
               "500",
               "600",
               "700",
               "800",
               "900",
               "1000"]
   

//var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
 let notification = UINotificationFeedbackGenerator()
//A concrete UIFeedbackGenerator subclass that creates haptics to communicate successes, failures, and warnings.
      
   var selectVolume: String?
   var image:UIImage!
   var text:UILabel!
   var name:String!
   
   override func viewDidLoad() {
       super.viewDidLoad()
       photoView.image = image
       detectPhoto(image: photoView.image!)
       createVolumePicker()
       createToolbar()
    
      drinkBtnLbl.layer.cornerRadius = 5
             
   }
    
      func createVolumePicker() {
            
            let volumePicker = UIPickerView()
            volumePicker.delegate = self
            
            waterVolumeTextField.inputView = volumePicker
            
            //Customizations
            volumePicker.backgroundColor = .lightGray
        }
        
        
        func createToolbar() {
            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            
            //Customizations
            toolBar.barTintColor = .white
            toolBar.tintColor = .systemBlue
            
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PreviewViewController.dismissKeyboard))
        
          
          
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2, height: 40))
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.textAlignment = NSTextAlignment.center
            label.text = "Water Volume (ml)"
            label.textColor = .lightGray
            
            let labelButton = UIBarButtonItem(customView: label)
            
            toolBar.setItems([doneButton, labelButton], animated: false)

            toolBar.isUserInteractionEnabled = true
            
            waterVolumeTextField.inputAccessoryView = toolBar
        }
        
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
     

   //save image and picker to core data
   @IBAction func saveButton(_ sender: Any) {
    
    //self.hapticImpact.impactOccurred()
    
    notification.notificationOccurred(.success)
    //notificationType The type of notification feedback (success,warning,error).
    
    guard let imageToSave = image else {
               return
           }
    
    guard let newData = CoreDataManager.shared.createDrink(image: imageToSave, amount: selectVolume!) else { return }
    
    print(newData)
    
       }

    
    
   func detectPhoto(image: UIImage) {
       //load coreml model
       guard let ciImage = CIImage(image: image) else {
           fatalError("Couldn't convert UIImage to CIImage")
       }
       guard let model = try? VNCoreMLModel(for: NewImageClassifier().model) else {
           fatalError("Can't load CoreML Model")
       }
    
       let request = VNCoreMLRequest(model: model) {
           (vnRequest, error) in
           print(vnRequest.results?.first as Any)
           guard let results = vnRequest.results as?
               [VNClassificationObservation], let firstResult = results.first else {
                   fatalError("Unexpected result")
           }
           DispatchQueue.main.async {
               if(firstResult.identifier.contains("water bottle")){
                   self.name = "water"
               }else if(firstResult.identifier.contains("water cup")){
                   self.name = "water"
               }else if(firstResult.identifier.contains("water glass")){
                   self.name = "water"
               }else{
                  self.name = "Not classifier"
               }
             
             self.ResultPhoto.image = UIImage(named: self.name)
            
           }
       }

       let handler = VNImageRequestHandler(ciImage: ciImage)
       DispatchQueue.global(qos:
           DispatchQoS.QoSClass.userInteractive).async {
               do {
                   try handler.perform([request])
               } catch {
                   print(error)
               }
       }
   }
}


//UIPickerview
extension PreviewViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return volumes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return volumes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectVolume = volumes[row]
        waterVolumeTextField.text = selectVolume
    }
    
}
