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
//   @IBOutlet weak var resultLabel: UILabel!
    
   var image:UIImage!
//   var text:UILabel!
   var name:String!
   
   override func viewDidLoad() {
       super.viewDidLoad()
       photoView.image = image
       // Do any additional setup after loading the view.
      // detectPhoto(image: photoView.image!)
//       detectPhoto(text: resultLabel.text!)
//       view.showLoadingView(inView: view)

   }
   
   
   @IBAction func cancelButton(_ sender: Any) {
       dismiss(animated: true, completion: nil)
   }
    
   @IBAction func saveButton(_ sender: Any) {
       guard let imageToSave = image else {
           return
       }
     
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
    dismiss(animated: true, completion: nil)
    
   }
//   func detectPhoto(image: UIImage) {
//       //load coreml model
//       guard let ciImage = CIImage(image: image) else {
//           fatalError("Couldn't convert UIImage to CIImage")
//       }
//       guard let model = try? VNCoreMLModel(for: "Inceptionv3().model") else {
//           fatalError("Can't load CoreML Model")
//       }
//       let request = VNCoreMLRequest(model: model) {
//           (vnRequest, error) in
//           print(vnRequest.results?.first as Any)
//           guard let results = vnRequest.results as?
//               [VNClassificationObservation], let firstResult = results.first else {
//                   fatalError("Unexpected result")
//           }
//           DispatchQueue.main.async {
//
//               if(firstResult.identifier.contains("water bottle")){
//                   self.name = "water_bottle"
//               }else if(firstResult.identifier.contains("water jug")){
//                   self.name = "water_bottle"
//               }else{
//                  self.name = "Bukan kendaraan dunia"
//               }
//
//             self.ResultPhoto.image = UIImage(named: self.name)
////             self.resultLabel.text = UILabel(named: self.name)
//
//
//
//           }
//       }
//
//       let handler = VNImageRequestHandler(ciImage: ciImage)
//       DispatchQueue.global(qos:
//           DispatchQoS.QoSClass.userInteractive).async {
//               do {
//                   try handler.perform([request])
//               } catch {
//                   print(error)
//               }
//       }
//   }
}

