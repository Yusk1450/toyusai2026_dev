//
//  ronbunARViewController.swift
//  Toyusai2026
//
//  Created by 橋本晄汰 on 2026/10/20.
//

import UIKit
import SceneKit
import ARKit

class PaperARViewController: BaseViewController,ARSCNViewDelegate
{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    
    var isAR = false

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		sceneView.delegate = self
        self.isAR = false
	}
        
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARImageTrackingConfiguration()
		
		// "ARResources" グループから参照画像を読み込む
		if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: Bundle.main) {
			configuration.trackingImages = trackedImages
			configuration.maximumNumberOfTrackedImages = 1
		}
		
		// Run the view's session
		sceneView.session.run(configuration)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// Pause the view's session
		sceneView.session.pause()
	}
    
    @IBAction func backBtn(_ sender: Any)
    {
        if (!isAR)
        {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.presentingViewController?.dismiss(animated: true) {
                let director = GameDirector.shared
                director.currentScene?.startScenario()
            }
		}
    }
        
	// MARK: - ARSCNViewDelegate
	
	func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
		
		// 検出されたアンカーが画像アンカーか確認
		guard let imageAnchor = anchor as? ARImageAnchor else { return }
		
		// どの画像が読み込まれたか判定（必要に応じて "test" の場合のみにするなど分岐可能）
		if imageAnchor.referenceImage.name == "paper" {
            self.isAR = true
			// 1. 検出された実際のマーカーと同じ幅・高さを持つ平面（SCNPlane）を作成
			let plane = SCNPlane(
				width: imageAnchor.referenceImage.physicalSize.width,
				height: imageAnchor.referenceImage.physicalSize.height
			)
			
			// 2. 平面の表面（マテリアル）に表示したい画像（test2）を設定する
			plane.firstMaterial?.diffuse.contents = UIImage(named: "ronbun")
			
			// 3. 平面からノードを作成
			let planeNode = SCNNode(geometry: plane)
			
			// 4. 初期状態では垂直に立っているため、X軸方向に倒してマーカーと平行（水平）にする
			planeNode.eulerAngles.x = -Float.pi / 2
			
			// 5. 検出されたノードに追加する
			node.addChildNode(planeNode)
		}
	}
}
