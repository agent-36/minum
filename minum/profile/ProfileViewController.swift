//
//  SettingsViewController.swift
//  minum
//
//  Created by Ihwan ID on 12/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToHistory(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Drink", bundle: nil)
            let vc = storyboard.instantiateInitialViewController() as? DrinkViewController ?? UIViewController()
       //vc.modalPresentationStyle = .formSheet
            present(vc, animated: true, completion: nil)
       
    }
    
}
