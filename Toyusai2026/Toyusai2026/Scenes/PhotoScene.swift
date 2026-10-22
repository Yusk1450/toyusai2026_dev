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
		self.scenario = [
			// msg -> 送信者名, 内容
			["msg", "橋口", "このまえ撮ったゼミ生の集合写真をゼミ室に置いておきました\n変なものが映っていないか確認したいので、カメラで写してもらえませんか？"],
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
