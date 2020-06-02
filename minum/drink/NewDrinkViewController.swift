////
////  NewDrinkViewController.swift
////  minum
////
////  Created by Edo Lorenza on 28/05/20.
////  Copyright © 2020 Ihwan ID. All rights reserved.
////
//
import UIKit
import AVFoundation

class NewDrinkViewController: UIViewController {

@IBOutlet weak var cameraButton: UIButton!
   
        var captureSession = AVCaptureSession()
        var backCamera: AVCaptureDevice?
        var currentDevice: AVCaptureDevice?
    
        var photoOutput: AVCapturePhotoOutput?
        
        var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
        
        var image: UIImage?
        

        
     
         override func viewDidLoad() {
                super.viewDidLoad()
               
                setupDevice()
                setupInputOutput()
                setupPreviewLayer()
            
                setupCaptureSession()
                captureSession.startRunning()
                    
                styleCaptureButton()
                
                //hide navigation bar for NewDrink Controller
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            
            }
            
            
            func styleCaptureButton() {
                cameraButton.layer.borderColor = UIColor.white.cgColor
                cameraButton.layer.borderWidth = 5
                cameraButton.clipsToBounds = true
                cameraButton.layer.cornerRadius = min(cameraButton.frame.width, cameraButton.frame.height) / 2
            }
            
            func setupCaptureSession() {
                captureSession.sessionPreset = AVCaptureSession.Preset.photo
            }
            
            func setupDevice() {
                let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
                let devices = deviceDiscoverySession.devices
                
                
                for device in devices {
                    if device.position == AVCaptureDevice.Position.back {
                        backCamera = device
                    }
                }
                currentDevice = backCamera
            }
            
            func setupInputOutput() {
                do {
                    
                    let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
                    captureSession.addInput(captureDeviceInput)
                    photoOutput = AVCapturePhotoOutput()
                    photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
                    captureSession.addOutput(photoOutput!)
                    
                    
                } catch {
                    print(error)
                }
            }
            
            func setupPreviewLayer() {
                self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                self.cameraPreviewLayer?.frame = view.frame
                
                self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
            }
            
            
        
   @IBAction func cameraButton(_ sender: Any) {
       let settings = AVCapturePhotoSettings()
              self.photoOutput?.capturePhoto(with: settings, delegate: self)
          }
          
          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "PreviewPhoto" {
                  let previewViewController = segue.destination as! PreviewViewController
                  previewViewController.image = self.image
              }
          }
      }

      extension NewDrinkViewController: AVCapturePhotoCaptureDelegate {
          func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
              if let imageData = photo.fileDataRepresentation() {
                  self.image = UIImage(data: imageData)
                  performSegue(withIdentifier: "PreviewPhoto", sender: nil)
              }
          }
      }
