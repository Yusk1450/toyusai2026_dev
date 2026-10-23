//
//  VRScene.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/22.
//

import UIKit

class VRScene: BaseScene
{
    override func start(viewController:UIViewController?)
    {
		super.start(viewController: viewController)
		
        self.scenario = [
            // msg -> 送信者名, 内容
            ["msg", "伊志郷", "明日VRゴーグルを使った実験を行うので、ゴーグルを被って動くか確かめてみてください。"],
            ["wait", "10"],
            ["msg", "平崎", "自分達の書いた論文の2枚目と3枚目がどこかにいってしまった\n誰かもし見つけたら確認したいからこういう感じで置いてくれないか？\n置いたらカメラに写してもらえると助かる"],
            ["img", "平崎", "guidePaper"],
            
        ]
        
        self.startScenario()
        self.delegate?.gameSceneDidStart(scene: self)
    }
    
    override func update(viewController:UIViewController?)
    {
		super.update(viewController: viewController)
        
        
    }
    
}
