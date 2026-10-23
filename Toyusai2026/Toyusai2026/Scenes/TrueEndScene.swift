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
        self.scenario = [
            // msg -> 送信者名, 内容
            ["msg", "二島 彩子", "先生は、私を消そうとしていたんじゃない。\nこの研究を、誰にも続けさせないようにしていたんだと思う。\n先輩。\n私を見つけてくれて、ありがとうございました。"],
        ]
        
        self.startScenario()
        self.delegate?.gameSceneDidStart(scene: self)
    }
    
    override func update(viewController:UIViewController?)
    {
        
        
        
    }
    
    override func stop(viewController:UIViewController?)
    {
        self.timer?.invalidate()
    }
}
