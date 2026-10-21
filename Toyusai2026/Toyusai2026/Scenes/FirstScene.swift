//
//  FirstScene.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/21.
//

import UIKit

class FirstScene: BaseScene
{
	override func start(viewController:UIViewController?)
	{
		self.scenario = [
			// msg -> 送信者名, 内容
			["msg", "伊志郷", "今年度の伊志郷ゼミの在籍者リストを共有します。\n画像をタップして、自分の名前があるか確認してください。"],
			// 在籍者リスト
			// img -> 送信者名, 画像名
			["img", "伊志郷", "list"],
			["msg", "山井", "ちょっと…このリスト、一人だけ名前と顔写真が塗りつぶされていませんか…？"],
			["msg", "伊志郷", "ゼミ生のみなさんへ。\n新しい学生証を机の上に置いておきましたので、各自持っていってください。\n学生証をタブレットの裏面に近づけると、登録されている学生情報を確認できます。"]
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
