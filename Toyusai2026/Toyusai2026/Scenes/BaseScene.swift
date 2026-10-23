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
		try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
		try? AVAudioSession.sharedInstance().setActive(true)

		let path = Bundle.main.path(forResource: "sound", ofType: "mp3")
		let url = URL(fileURLWithPath: path!)
		self.audioPlayer = try? AVAudioPlayer(contentsOf: url)
		self.audioPlayer?.prepareToPlay()
		
		self.delegate?.gameSceneDidStart(scene: self)
	}
	
	// シナリオを開始する
	func startScenario()
	{
		if let timer = self.timer
		{
			// すでに開始していたら
			if (timer.isValid)
			{
				return
			}
		}
		
        self.timer?.invalidate()
		self.timer = Timer.scheduledTimer(timeInterval: 1.0,
										  target: self,
										  selector: #selector(self.nextMessage(timer:)),
										  userInfo: nil,
										  repeats: false)
	}
	
	// シナリオ用のタイマー
	@objc func nextMessage(timer:Timer)
	{
		guard let viewController = GameDirector.shared.currentViewController as? ChatViewController else
		{
			return
		}
		
		var isWait = false
				
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

				if let sender = viewController.createSender(name: name)
				{
					let msg = viewController.createMessage(text: message, sender: sender)
					viewController.addMessage(message: msg)
					
					self.audioPlayer?.currentTime = 0
					self.audioPlayer?.play()
				}
			}
			// 画像を表示する
			else if (cmd == "img")
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

					self.audioPlayer?.currentTime = 0
					self.audioPlayer?.play()
				}
			}
			// セグエを起動する
			else if (cmd == "segue")
			{
				let segueName = scenario[1]
				
				viewController.performSegue(withIdentifier: segueName, sender: nil)

			}
			else if (cmd == "wait")
			{
				// 待機時間が指定されている場合
				if (scenario.count == 2)
				{
					let intervalTime = TimeInterval(scenario[1])
					
					self.timer = Timer.scheduledTimer(timeInterval: intervalTime!,
													  target: self,
													  selector: #selector(self.nextMessage(timer:)),
													  userInfo: nil,
													  repeats: false)
				}
				
                isWait = true
			}
		}
		
		self.currentMessageIdx += 1

		if (self.currentMessageIdx <= self.scenario.count - 1 && !isWait)
		{
			self.timer = Timer.scheduledTimer(timeInterval: 5.0,
											  target: self,
											  selector: #selector(self.nextMessage(timer:)),
											  userInfo: nil,
											  repeats: false)
		}
//		else
//		{
//			self.timer?.invalidate()
//			self.timer = nil
//		}
	}
	
	func update(viewController:UIViewController?)
	{
	}
	
	func stop(viewController:UIViewController?)
	{
		self.timer?.invalidate()
		self.timer = nil
	}
	
	func playNextSound()
	{
		self.audioPlayer?.play()
	}
}
