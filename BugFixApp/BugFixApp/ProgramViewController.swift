//
//  ProgramViewController.swift
//  BugFixApp
//
//  Created by 橋本晄汰 on 2026/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProgramViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var executeBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
	// サーバIP
	let ip = "192.168.13.200"
	// サーバURL
	var url:String!
	
	func sendFlagToServer(flagIndex:Int)
	{
		if let url = self.url
		{
			AF.request("\(url)/flag",
					   method: .post,
					   parameters: ["flag_id": flagIndex],
					   encoding: URLEncoding.default,
					   headers: nil
			)
				.responseJSON { res in
			}
		}
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		self.url = "http://\(self.ip):8888/server"
		
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
        let input = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        self.imgView.isHidden = true

        if input == "2401450"
        {
			self.sendFlagToServer(flagIndex: 8)
        }
		else if input == "1450"
        {
			self.sendFlagToServer(flagIndex: 6)
        }
		else
        {
            self.imgView.isHidden = false
        }
        
    }
    
}
