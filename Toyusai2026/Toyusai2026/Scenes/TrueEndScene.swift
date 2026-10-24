//
//  TrueEndScene.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/23.
//

import UIKit

class TrueEndScene: BaseScene
{
    override func start(viewController:UIViewController?)
    {
		super.start(viewController: viewController)
		
		let director = GameDirector.shared
		director.gameTimer?.invalidate()
		director.gameTimer = nil
		
        self.scenario = [
            ["msg", "二島 彩子", "先生は、私を消そうとしていたんじゃない。\nこの研究を、誰にも続けさせないようにしていたんだと思う。"],
//			["msg", "二島 彩子", "先輩。"],
//			["msg", "二島 彩子", "私を見つけてくれて、ありがとうございました。"],
			["wait", "10"],
			["segue", "toTrueEnd"]
        ]
        
        self.startScenario()
        self.delegate?.gameSceneDidStart(scene: self)
    }
    
    override func update(viewController:UIViewController?)
    {
        super.update(viewController: viewController)
        
        
    }
}
