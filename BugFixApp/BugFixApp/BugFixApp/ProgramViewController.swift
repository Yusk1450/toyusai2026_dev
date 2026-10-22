//
//  ProgramViewController.swift
//  BugFixApp
//
//  Created by 橋本晄汰 on 2026/10/22.
//

import UIKit

class ProgramViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var executeBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        self.imgView.isHidden = true
    }
    
    @objc private func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func executeBtn(_ sender: Any)
    {
        let input = textField.text ?? ""
        
        if input == "2401450"
        {
            
        } else if input == "1450"
        {
            
        }else
        {
            self.imgView.isHidden = false
        }
        
    }
    
}
