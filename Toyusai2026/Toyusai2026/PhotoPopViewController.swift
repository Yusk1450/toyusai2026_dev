//
//  PhotoPopViewController.swift
//  Toyusai2026
//
//  Created by 橋本晄汰 on 2026/10/22.
//

import UIKit

class PhotoPopViewController: BaseViewController
{

    @IBOutlet weak var toArBtn: UIButton!
    override func viewDidLoad()
    
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toArBtn(_ sender: Any)
    {
        performSegue(withIdentifier: "toPhotoAR", sender: nil)
    }
    
}
