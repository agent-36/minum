//
//  OnBoardingViewController.swift
//  minum
//
//  Created by Ihwan ID on 12/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
           
            let storyboard = UIStoryboard(name: "Water", bundle: nil)
            let vc = storyboard.instantiateInitialViewController() as? WaterViewController ?? UIViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        
    
    }
}
