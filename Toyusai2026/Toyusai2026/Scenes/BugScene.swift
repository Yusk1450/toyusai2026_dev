//
//  BugScene.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/23.
//

import UIKit

class BugScene: BaseScene
{
    override func start(viewController:UIViewController?)
    {
		super.start(viewController: viewController)
		
        self.scenario = [
            // msg -> 送信者名, 内容
            ["msg", "二島", "私が先生と完成させたプログラム、バグがあったみたい\nそれで私は意識をAIに取り込まれた\nお願い\n　　　　　を入力してバグを直して"],
            ["msg", "平﨑", "二島さん！？\nそういえば、二島さんが最近見なくなるまえに、伊志郷先生が言ってた気がします\n「もう少しで、人間と同じAIが完成する」って…"],
        ]
        
        self.startScenario()
        self.delegate?.gameSceneDidStart(scene: self)
    }
    
    override func update(viewController:UIViewController?)
    {
		super.update(viewController: viewController)
        
        
    }

}
