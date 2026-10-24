//
//  VC.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/21.
//
import UIKit

class StudentsCardViewController: BaseViewController
{
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var noDataText: UILabel!
    
    @IBOutlet weak var backbtn: UIButton!
    
    var studentName = ""
    private var resumeTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backbtn.isHidden = false
        self.cardImage.image = UIImage(named: studentName)
		if (self.studentName == "nishima")
        {
            self.noDataText.isHidden = false
            self.backbtn.isHidden = true
        }
        else
        {
            self.noDataText.isHidden = true
            self.backbtn.isHidden = false
        }
    }

    override func viewDidAppear(_ animated: Bool)
	{
        super.viewDidAppear(animated)
		
		let director = GameDirector.shared
		director.currentViewController = self
		
		if (self.studentName == "nishima") {
			
			Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { timer in
				
				if let currentScene = director.currentScene as? StudentCardScene
				{
					currentScene.isLoadMishima = true
				}
				
				director.currentViewController = self.presentingViewController
				
				self.dismiss(animated: false) {
					if let currentScene = director.currentScene as? StudentCardScene
					{
						currentScene.startScenario()
					}
				}

			}
			
		}
    }
    
    func StudentsCard(name:String)
    {
		let director = GameDirector.shared
		
        self.cardImage.image = UIImage(named: name)
        if (name == "nishima")
        {
            self.noDataText.isHidden = false
            self.backbtn.isHidden = true

			Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { timer in

				if let currentScene = director.currentScene as? StudentCardScene
				{
					currentScene.isLoadMishima = true
				}
				
				director.currentViewController = self.presentingViewController
				
				self.dismiss(animated: false) {
					if let currentScene = director.currentScene as? StudentCardScene
					{
						currentScene.startScenario()
					}
				}

			}
		}
        else
        {
            self.noDataText.isHidden = true
            self.backbtn.isHidden = false
        }
    }
    
    @IBAction func toBack(_ sender: Any) {
        let director = GameDirector.shared
        director.currentViewController = self.presentingViewController
        self.dismiss(animated: false, completion: nil)
    }
    
}
