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
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    

    @IBAction func backBtn(_ sender: Any)
    {
        self.popView.isHidden = true
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
