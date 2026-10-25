//
//  FirstScene.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/21.
//

import UIKit

class StudentCardScene: BaseScene
{
	var isLoadMishima = false
	
	override func start(viewController:UIViewController?)
	{
		super.start(viewController: viewController)
		
		self.scenario = [
			// msg -> 送信者名, 内容
			["msg", "伊志郷", "今年度の伊志郷ゼミの在籍者リストを共有します。\n自分の名前があるか確認してください。"],
			// 在籍者リスト
			// img -> 送信者名, 画像名
			["img", "伊志郷", "list"],
			["msg", "山井", "ちょっと…このリスト、一人だけ名前が塗りつぶされていませんか…？"],
			["msg", "伊志郷", "ゼミ生のみなさんへ。\n新しい学生証を机の上に置いておきましたので、各自持っていってください。\n学生証をタブレットの裏面に近づけると、登録されている学生情報を確認できます。"],
			["wait"],
			["msg", "掛川", "先生、学籍番号1231450の学生証が読み込めないみたいです"],
			["msg", "伊志郷", "ひとつだけ読み込みができない学生証があるので、あとで回収します。触らないでください。"],
            ["msg", "掛川", "そういえばこの間撮った集合写真ってどこかにありますか？"]
		]
		
		self.startScenario()
		self.delegate?.gameSceneDidStart(scene: self)
	}
	
	override func update(viewController:UIViewController?)
	{
		super.update(viewController: viewController)
		
		let director = GameDirector.shared
		
		// セリフが最期まで言ったら…
		if (self.currentMessageIdx >= self.scenario.count)
		{
			// クリアフラグ
			director.sendFlagToServer(flagIndex: 0)
		}
	}
}
