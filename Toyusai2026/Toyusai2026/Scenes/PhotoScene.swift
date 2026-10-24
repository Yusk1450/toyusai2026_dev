//
//  PhotoScene.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/22.
//

import UIKit

class PhotoScene: BaseScene
{
	override func start(viewController:UIViewController?)
	{
		super.start(viewController: viewController)
		
		self.scenario = [
			// msg -> 送信者名, 内容
			["msg", "橋口", "このまえ撮ったゼミ生の集合写真をゼミ室に置いておきました\n変なものが映っていないか確認したいので、カメラで写してもらえませんか？"],
			["segue", "toPhotoPop"],
            ["wait"],
            ["msg", "橋口", "大丈夫そうですね。ただ、なんか人数が少ないような…？"],
            ["msg", "山井", "そういえば、最近あの子ゼミで見てないな\n夜中に研究でも進めてるのかな。せっかく先輩から引き継いだ研究がようやく完成するっていうのに"],
            ["msg", "野々村", "伊志郷先生も最近見ないですよね"],
            ["msg", "橋口", "突然すみません！ゼミ室のパソコンにログインできなくなってしまい…パスワード教えてください！"],
            ["msg", "山井", "「1450」だよ、ゼミ室で何か入力を求められたら「1450」って入力するって覚えておくと良いよ"]
		]
		
		self.startScenario()
		self.delegate?.gameSceneDidStart(scene: self)
	}
	
	override func update(viewController:UIViewController?)
	{
		super.update(viewController: viewController)
		
        // セリフが最期まで言ったら…
        if (self.currentMessageIdx >= self.scenario.count)
        {
            // クリアフラグ
            director.sendFlagToServer(flagIndex: 2)
        }
		
		
	}
}
