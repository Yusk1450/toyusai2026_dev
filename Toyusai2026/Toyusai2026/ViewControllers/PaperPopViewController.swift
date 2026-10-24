//
//  PaperPopViewController.swift
//  Toyusai2026
//
//  Created by 橋本晄汰 on 2026/10/22.
//

import UIKit

class PaperPopViewController: BaseViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var toArBtn: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.backBtn.isHidden = true
        
        let director = GameDirector.shared
        if (director.gimmickFlags[3] == true)
        {
            self.backBtn.isHidden = false
        }
        
    }
    
    @IBAction func toArBtn(_ sender: Any)
    {
        performSegue(withIdentifier: "toPaperAR", sender: nil)
    }
    @IBAction func toBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}
