//
//  LostPaperScene.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/22.
//

import UIKit

class LostPaperScene: BaseScene
{
    override func start(viewController:UIViewController?)
    {
		super.start(viewController: viewController)
		
        self.scenario = [
            ["msg", "平崎", "見つけてくれてありがとうございます。いったい誰が移動したんだろう…"],
            ["msg", "伊志郷", "その論文は私が捨てました。もうその研究は中止されています。\nこの件については、これ以上調べる必要はありません。"],
        ]
		        
        self.startScenario()
        self.delegate?.gameSceneDidStart(scene: self)
    }
    
    override func update(viewController:UIViewController?)
    {
		super.update(viewController: viewController)
        
        
    }
    
}
