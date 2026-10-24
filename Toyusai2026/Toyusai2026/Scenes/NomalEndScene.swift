//
//  NomalEndScene.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/23.
//

import UIKit

class NomalEndScene: BaseScene
{
    override func start(viewController:UIViewController?)
    {
		super.start(viewController: viewController)

		self.scenario = [
			
		]
		
		self.startScenario()
		self.delegate?.gameSceneDidStart(scene: self)
	}
    
    override func update(viewController:UIViewController?)
    {
		super.update(viewController: viewController)
		
    }
}
