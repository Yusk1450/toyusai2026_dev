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
    
    var studentName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardImage.image = UIImage(named: studentName)
        if (studentName == "nishima")
        {
            self.noDataText.isHidden = false
        }
        else
        {
            self.noDataText.isHidden = true
        }


    }

    override func viewDidAppear(_ animated: Bool)
	{
        super.viewDidAppear(animated)
		
		let director = GameDirector.shared
		director.currentViewController = self
        
    }
    
    func StudentsCard(name:String)
    {
        self.cardImage.image = UIImage(named: name)
        if (name == "nishima")
        {
            self.noDataText.isHidden = false
        }
        else
        {
            self.noDataText.isHidden = true
        }
    }
    
    @IBAction func toBack(_ sender: Any) {
        let director = GameDirector.shared
        director.currentViewController = self.presentingViewController
        self.dismiss(animated: false, completion: nil)
    }
    
}
