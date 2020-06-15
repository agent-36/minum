//
//  FirstViewController.swift
//  minum
//
//  Created by Ihwan ID on 12/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import WaveAnimationView

class WaterViewController: UIViewController {

    @IBOutlet weak var lapView: UIView!
    
    var wave: WaveAnimationView!
    
    @IBOutlet weak var drinkBtnlbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lapView.layer.cornerRadius = lapView.frame.size.width/2
        lapView.clipsToBounds = true

        lapView.layer.borderColor = UIColor(rgb: 0x4D80E4).cgColor
        lapView.layer.backgroundColor = UIColor(rgb: 0x253961).cgColor
        lapView.layer.borderWidth = 5.0
    
        drinkBtnlbl.layer.cornerRadius = 5

        wave = WaveAnimationView(frame: CGRect(origin: .zero, size: lapView.bounds.size), color: UIColor(rgb: 0x5CC2F4))
               lapView.addSubview(wave)
               wave.startAnimation()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        wave.stopAnimation()
        
    }
  
    @IBAction func goToDrink(_ sender: UIButton) {
                  let storyboard = UIStoryboard(name: "Drink", bundle: nil)
                  let vc = storyboard.instantiateInitialViewController() as? NewDrinkViewController ?? UIViewController()
                  present(vc, animated: true, completion: nil)
          }


}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
   
}
