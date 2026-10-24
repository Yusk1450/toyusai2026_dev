//
//  TrueEnd1ViewController.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/24.
//

import UIKit

class TrueEnd1ViewController: UIViewController {

    override func viewDidLoad()
	{
        super.viewDidLoad()

	
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		Timer.scheduledTimer(withTimeInterval: 10.0,
							 repeats: false) { timer in
			
			self.performSegue(withIdentifier: "toStaffRoll", sender: nil)
			
		}
	}

}
