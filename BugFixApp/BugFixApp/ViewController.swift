//
//  ViewController.swift
//  BugFixApp
//
//  Created by 橋本晄汰 on 2026/10/21.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var roginBtn: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        selectView.layer.borderWidth = 1
        selectView.layer.cornerRadius = 12
        selectView.layer.borderColor = UIColor.black.cgColor

		// キーボード表示
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShowNotification),name: UIResponder.keyboardWillShowNotification,object: nil)

		// キーボード非表示
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHideNotification),name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
	@objc func keyboardWillShowNotification(notification:NSNotification)
	{
		guard let userInfo = notification.userInfo else { return }
		guard let isLocalUserInfoKey = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber else { return }
		
		if (!isLocalUserInfoKey.boolValue) { return }
		
		let transform = CGAffineTransform(translationX: 0, y: -300)
		self.view.transform = transform
	}
	
	@objc func keyboardWillHideNotification(notification:NSNotification)
	{
		guard let userInfo = notification.userInfo else { return }
		guard let isLocalUserInfoKey = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber else { return }

		if (!isLocalUserInfoKey.boolValue) { return }
		
		self.view.transform = CGAffineTransform.identity
	}
    
    @IBAction func loginBtn(_ sender: Any)
    {
        let num = numField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
		if num == "1231450" && name == "二島彩子"
        {
            performSegue(withIdentifier: "toProgram", sender: nil)
        }
    }
    
}

