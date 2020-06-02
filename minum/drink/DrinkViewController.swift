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
    @IBOutlet weak var drinkButtonTap: UIButton!
    
//    @IBOutlet weak var saveBtnLbl: UIButton!
    
    @IBOutlet weak var waterVolumeTextField: UITextField!
    
    
    let volumes = ["100",
                "200",
                "300",
                "500",
                "600",
                "700",
                "800"]
    
    var selectVolume: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        createVolumePicker()
        createToolbar()
        
        drinkButtonTap.layer.cornerRadius = 5
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DrinkViewController.dismissKeyboard))
        
      
      
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
 
}


//UIPickerview
extension DrinkViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
