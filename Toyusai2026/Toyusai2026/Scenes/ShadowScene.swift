//
//  ShadowScene.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/22.
//

import UIKit

class ShadowScene: BaseScene
{
    override func start(viewController:UIViewController?)
    {
		super.start(viewController: viewController)
		
        self.scenario = [
            ["msg", "掛川", "最近気になることがあるんです\n夜中ゼミ室に忘れ物を取りに行ったら、誰もいない部屋の中から物音が聞こえたんです"],
            ["msg", "杉原", "え、掛川先輩もですか！\n実はこのまえ私も聞いちゃいました…"],
            ["wait", "15"],
            ["msg", "伊志郷", "どうやら卒業生がゼミ室に来ているようですね。\nゼミ室のカーテンの奥には入らないようにしてください。"]
        ]
        
        self.startScenario()
        self.delegate?.gameSceneDidStart(scene: self)
    }
    
    override func update(viewController:UIViewController?)
    {
		super.update(viewController: viewController)
        
		let director = GameDirector.shared
		if (director.gimmickFlags[5])
		{
			director.changeScene(scene: BugScene())
		}
        
    }
    
}
