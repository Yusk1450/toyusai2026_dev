//
//  ViewController.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/09.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Alamofire
import SwiftyJSON

class ViewController: BaseViewController
{
    @IBOutlet weak var StartBtn: UIButton!
    override func viewDidLoad()
	{
		super.viewDidLoad()

	}
	

    @IBAction func StartBtn(_ sender: Any)
    {
        performSegue(withIdentifier: "toChat", sender: nil)
    }
    
}

