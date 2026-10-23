//
//  GameDirector.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/21.
//

import UIKit
import OSCKit
import Alamofire
import SwiftyJSON

enum OSCAddress: String
{
	case NFCDevice = "/reply"
}

protocol GameDirectorDelegate: AnyObject
{
	func gameDirectorDidChangeNextScript(gameDirector:GameDirector, script:String)
	func gameDirectorDidUpdate(gameDirector:GameDirector)
}

protocol StudentsCardPresenting: AnyObject
{
	func StudentsCard(name: String)
}

extension ChatViewController: StudentsCardPresenting {}
extension StudentsCardViewController: StudentsCardPresenting {}

class GameDirector: NSObject
{
	static let shared = GameDirector()

	var delegate:GameDirectorDelegate?
	
	// サーバIP
	let ip = "172.16.1.9"
	// サーバURL
	var url:String!

	// OSCポート番号
	let port:UInt16 = 5555
	private let oscServer:OSCUdpServer!
	
	// 残り時間
	var remainGameTime = 600
	var gameTimer:Timer?

	var currentViewController:UIViewController?
	
	// 現在のシーンクラス
	var currentScene:BaseScene?

	// ギミッククリアフラグ
	var gimmickFlags = [false, false, false, false, false, false, false, false, false]

	let studentNamesByCardID = [
		"D2 D5 F7 06": "nishima",   // 二島
		"82 ED D0 06": "hirazaki",  // 平﨑
		"43 54 D1 06": "yamai",     // 山井
		"5B F0 79 3B": "hashiguti", // 橋口
		"26 12 3A 03": "kakegawa",  // 掛川
		"3B 06 D4 06": "suzumura",  // 鈴村
		"2D 88 D5 06": "nonomura",  // 野々村
		"AC 13 F5 06": "sugihara",  // 杉原
	]
	
	override init()
	{
		self.oscServer = OSCUdpServer(port: self.port)
		
		super.init()
		self.oscServer.delegate = self
		
		do
		{
			try self.oscServer.startListening()
		}
		catch
		{
			print(error.localizedDescription)
		}
		
//		self.url = "http://\(self.ip):8888/server"
		self.url = "http://\(self.ip):8888/WORKS/NBU/toyusai2026_dev/server"
	}
	
	/* ----------------------------------------------------
	 * ゲームを開始する
	-----------------------------------------------------*/
	func startGame()
	{
		self.remainGameTime = 600
				
		self.gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
											  target: self,
											  selector: #selector(self.updateGameStatus(timer:)),
											  userInfo: nil,
											  repeats: true)
	}
	
	/* ----------------------------------------------------
	 * ゲームループ
	-----------------------------------------------------*/
	@objc func updateGameStatus(timer:Timer)
	{
		self.remainGameTime -= 1
				
		// 時間切れ
		if (self.remainGameTime < 0)
		{
			self.gameTimer?.invalidate()
			
//			if let viewController = self.currentViewController
//			{
//				let storyboard = UIStoryboard(name: "Main", bundle: nil)
//				if let timeoverViewController = storyboard.instantiateViewController(withIdentifier: "TimeoverEndViewController") as? TimeoverEndViewController
//				{
//					viewController.present(timeoverViewController, animated: true, completion: nil)
//				}
//			}
			
			return
		}
		
		// サーバのフラグを確認する
		self.updateServerFlag()
		
		self.currentScene?.update(viewController: self.currentViewController)
		self.delegate?.gameDirectorDidUpdate(gameDirector: self)
	}

	func updateServerFlag()
	{
		if let url = self.url
		{
			AF.request("\(url)/flag",
					   method: .get,
					   parameters: nil,
					   encoding: URLEncoding.default,
					   headers: nil
			)
				.responseJSON { res in
				
//					print(res.data)
					
					if let data = res.data
					{
						let json = JSON(data)
						
						print(json)
						
						for i in stride(from: 0, to: self.gimmickFlags.count, by: 1)
						{
							self.gimmickFlags[i] = json[i].boolValue
						}
					}

			}
		}
	}
	
	func sendFlagToServer(flagIndex:Int)
	{
		if let url = self.url
		{
			AF.request("\(url)/flag",
					   method: .post,
					   parameters: ["flag_id": flagIndex],
					   encoding: URLEncoding.default,
					   headers: nil
			)
				.responseJSON { res in
			}
		}
	}
	
	/* ----------------------------------------------------
	 * シーンの切り替え
	 ----------------------------------------------------*/
	func changeScene(scene:BaseScene)
	{
		self.currentScene?.stop(viewController: self.currentViewController)
		self.currentScene?.delegate = nil
		
		self.currentScene = scene
//		self.currentScene?.delegate = self
		self.currentScene?.start(viewController: self.currentViewController)
	}
	
	/* ----------------------------------------------------
	 * OSCの送信
	 ----------------------------------------------------*/
	func sendSimpleOSCMessage(ip:String, address:String)
	{
		let client = OSCUdpClient(host: ip, port: self.port)
		if let message = try? OSCMessage(with: address, arguments: [])
		{
			if let _ = try? client.send(message)
			{
			}
		}
	}
	
}

extension GameDirector: OSCUdpServerDelegate
{
	func server(_ server: OSCUdpServer, didReceivePacket packet: any OSCPacket, fromHost host: String, port: UInt16)
	{
		if let message = packet as? OSCMessage
		{
//			print(message.addressPattern.fullPath)
			
			// NFC
			if (message.addressPattern.fullPath == OSCAddress.NFCDevice.rawValue)
			{
				print(message.arguments)
				
				if let uuid = message.arguments[0] as? String
				{
					// --------------------------------------------------
					// 集合写真
					// --------------------------------------------------
					if (uuid == "photo")
					{
						self.changeScene(scene: PhotoScene())
					}
					// --------------------------------------------------
					// VRゴーグル
					// --------------------------------------------------
					else if (uuid == "vr")
					{
						
					}

					
					// --------------------------------------------------
					// 学生証
					// --------------------------------------------------
					if let name = self.studentNamesByCardID[uuid],
					   let cardViewController = self.currentViewController as? StudentsCardPresenting
					{
						cardViewController.StudentsCard(name: name)
					}
				}
			}
		}
	}
	
	func server(_ server: OSCUdpServer, socketDidCloseWithError error: (any Error)?)
	{
	}
	
	func server(_ server: OSCUdpServer, didReadData data: Data, with error: any Error)
	{
	}
}
