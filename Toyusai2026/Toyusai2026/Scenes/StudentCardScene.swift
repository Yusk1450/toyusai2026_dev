//
//  FirstScene.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/21.
//

import UIKit

class StudentCardScene: BaseScene
{
	func showStudentCard(uuid:String)
	{
		let director = GameDirector.shared

		if let currentViewController = director.currentViewController as? ChatViewController
		{
			// 二島
			if (uuid == "D2 D5 F7 06")
			{
				currentViewController.showCardPopup(imagename: "nishima")
			}
			// 平﨑
			else if (uuid == "82 ED D0 06")
			{
				currentViewController.showCardPopup(imagename: "hirazaki")
			}
			// 山井
			else if (uuid == "43 54 D1 06")
			{
				currentViewController.showCardPopup(imagename: "yamai")
			}
			// 橋口
			else if (uuid == "5B F0 79 3B")
			{
				currentViewController.showCardPopup(imagename: "hashiguti")
			}
			// 掛川
			else if (uuid == "26 12 3A 03")
			{
				currentViewController.showCardPopup(imagename: "kakegawa")
			}
			// 鈴村
			else if (uuid == "3B 06 D4 06")
			{
				currentViewController.showCardPopup(imagename: "suzumura")
			}
			// 野々村
			else if (uuid == "2D 88 D5 06")
			{
				currentViewController.showCardPopup(imagename: "nonomura")
			}
			// 杉原
			else if (uuid == "AC 13 F5 06")
			{
				currentViewController.showCardPopup(imagename: "sugihara")
			}
		}
		
	}
	
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
