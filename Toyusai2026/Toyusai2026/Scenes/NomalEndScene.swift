//
//  NomalEndScene.swift
//  Toyusai2026
//
//  Created by ichinose-PC on 2026/10/23.
//

import UIKit

class NomalEndScene: BaseScene
{
    override func start(viewController:UIViewController?)
    {
		super.start(viewController: viewController)

		let director = GameDirector.shared
		director.gameTimer?.invalidate()
		director.gameTimer = nil

		self.scenario = [
            ["img", "伊志郷", "screenshot"],
            ["msg", "伊志郷", "このバグを直したのは誰ですか！！"],
            ["msg", "平﨑", "この画像、\n二島さんが研究で作っていたもの…？\nそういえば先生、二島さんと一緒に研究していたような…？"],
            ["msg", "山井", "そういえば二島さんがいなくなった日、\n先生って何していました…？"],
			["wait", "10"],
			["segue", "toBadEnd"]
		]
		
		self.startScenario()
		self.delegate?.gameSceneDidStart(scene: self)
	}
    
    override func update(viewController:UIViewController?)
    {
		super.update(viewController: viewController)
		
    }
}
