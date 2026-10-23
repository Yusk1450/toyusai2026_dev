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
    }
    
    override func update(viewController:UIViewController?)
    {
    }
    
    override func stop(viewController:UIViewController?)
    {
        self.timer?.invalidate()
    }
}
