//
//  TrueEnd2ViewController.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/24.
//

import UIKit

class TrueEnd2ViewController: UIViewController
{
	@IBOutlet weak var creditImageView: UIImageView!
	
	var timer:Timer?
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.creditImageView.isHidden = false
		self.creditImageView.frame.origin.y = self.view.frame.height
		
		self.timer = Timer.scheduledTimer(timeInterval: 0.01,
										  target: self,
										  selector: #selector(self.timerAction),
										  userInfo: nil,
										  repeats: true)
	}
	
	@objc func timerAction()
	{
		self.creditImageView.frame.origin.y -= 0.4
		
		if (self.creditImageView.frame.origin.y <= -760)
		{
			self.timer?.invalidate()
			
			Timer.scheduledTimer(withTimeInterval: 8.0,
								 repeats: false) { timer in
				self.performSegue(withIdentifier: "toEnd", sender: nil)
			}
		}
	}

}
