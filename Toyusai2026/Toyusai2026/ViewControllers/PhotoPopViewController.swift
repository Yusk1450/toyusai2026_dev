//
//  PhotoPopViewController.swift
//  Toyusai2026
//
//  Created by 橋本晄汰 on 2026/10/22.
//

import UIKit

class PhotoPopViewController: BaseViewController
{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var toArBtn: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.backBtn.isHidden = true
        
        let director = GameDirector.shared
        if (director.gimmickFlags[1] == true)
        {
            self.backBtn.isHidden = false
        }
        
    }
    
    @IBAction func toArBtn(_ sender: Any)
    {
        performSegue(withIdentifier: "toPhotoAR", sender: nil)
    }
    
    @IBAction func toback(_ sender: Any) {
        self.dismiss(animated: false)
    }

}
