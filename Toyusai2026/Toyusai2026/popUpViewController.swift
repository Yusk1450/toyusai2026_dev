//
//  popUpViewController.swift
//  Toyusai2026
//
//  Created by 橋本晄汰 on 2026/10/20.
//

import UIKit

class popUpViewController: BaseViewController
{
    
    @IBOutlet var popView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.yesBtn.layer.borderColor = UIColor.white.cgColor
        self.backView.isHidden = false
    }
    

    @IBAction func backBtn(_ sender: Any)
    {
        self.popView.isHidden = true
    }
    
    @IBAction func yesBtn(_ sender: Any)
    {
        let condition = true // ここに分岐条件を書く
        
        if condition {
            performSegue(withIdentifier: "toPhoto", sender: nil)
        } else {
            performSegue(withIdentifier: "toPaper", sender: nil)
        }
    }
    

    

}
