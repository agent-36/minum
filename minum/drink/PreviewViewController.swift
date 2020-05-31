//
//  PreviewViewController.swift
//  minum
//
//  Created by Edo Lorenza on 29/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    
    @IBOutlet weak var photoView: UIImageView!
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.image = image
        // Do any additional setup after loading the view.
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
