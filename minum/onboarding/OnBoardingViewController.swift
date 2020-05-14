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
//        onBoardNextButton.layer.cornerRadius = 10
               
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
           
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController() as? UITabBarController ?? UITabBarController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        
     
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
