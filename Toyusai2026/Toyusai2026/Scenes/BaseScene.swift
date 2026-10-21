//
//  BaseScene.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/21.
//

import UIKit
import AVFoundation
import MessageKit

protocol GameSceneDelegate: AnyObject
{
	func gameSceneDidStart(scene:BaseScene)
}

class BaseScene: NSObject
{
	var scenario = [[String]]()
	var currentMessageIdx = 0
	
	var timer:Timer?
	
	var audioPlayer:AVAudioPlayer?
	var delegate:GameSceneDelegate?
	
	func start(viewController:UIViewController?)
	{
		let path = Bundle.main.path(forResource: "sound", ofType: "mp3")
		let url = URL(fileURLWithPath: path!)
		self.audioPlayer = try? AVAudioPlayer(contentsOf: url)
		self.audioPlayer?.prepareToPlay()
		
		self.delegate?.gameSceneDidStart(scene: self)
	}
	
	// シナリオを開始する
	func startScenario()
	{
		self.timer = Timer.scheduledTimer(timeInterval: 1.0,
										  target: self,
										  selector: #selector(self.nextMessage(timer:)),
										  userInfo: nil,
										  repeats: false)
	}
	
	// シナリオ用のタイマー
	@objc func nextMessage(timer:Timer)
	{
		let director = GameDirector.shared
				
		if self.currentMessageIdx < self.scenario.count
		{
			let scenario = self.scenario[self.currentMessageIdx]
			let cmd = scenario[0]
			
			// メッセージ送信
			if (cmd == "msg")
			{
				// 送信者
				let name = scenario[1]
				// 内容
				let message = scenario[2]

				if let viewController = director.currentViewController as? ChatViewController
				{
					if let sender = viewController.createSender(name: name)
					{
						let msg = viewController.createMessage(text: message, sender: sender)
						viewController.addMessage(message: msg)
					}
				}
			}
			else if (cmd == "img")
			{
				if let viewController = director.currentViewController as? ChatViewController
				{
					// 送信者
					let name = scenario[1]
					// 画像名
					let imgName = scenario[2]
					
					if let img = UIImage(named: imgName),
					   let sender = viewController.createSender(name: name)
					{
						let msg = MockMessage(
							image: img,
							sender: sender,
							messageId: UUID().uuidString,
							date: Date()
						)
						viewController.addMessage(message: msg)
					}
				}
			}
			else if (cmd == "wait")
			{
			}
		}
		
		self.currentMessageIdx += 1

		if (self.currentMessageIdx <= self.scenario.count - 1)
		{
			self.timer = Timer.scheduledTimer(timeInterval: 5.0,
											  target: self,
											  selector: #selector(self.nextMessage(timer:)),
											  userInfo: nil,
											  repeats: false)
		}
	}
	
	func update(viewController:UIViewController?)
	{
	}
	
	func stop(viewController:UIViewController?)
	{
	}
	
	func playNextSound()
	{
		self.audioPlayer?.play()
	}
}
