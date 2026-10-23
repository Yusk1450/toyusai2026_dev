//
//  photoViewController.swift
//  Toyusai2026
//
//  Created by 橋本晄汰 on 2026/10/20.
//

import UIKit
import SceneKit
import ARKit

class PhotoViewController: BaseViewController,ARSCNViewDelegate
{

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var rewindBtn: UIButton!
    
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		sceneView.delegate = self
	}
        
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARImageTrackingConfiguration()
		
		// "ARResources" グループから参照画像を読み込む
		if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: Bundle.main) {
			configuration.trackingImages = trackedImages
			configuration.maximumNumberOfTrackedImages = 1
		}
		
		sceneView.session.run(configuration)
	}
        
	override func viewWillDisappear(_ animated: Bool)
	{
		super.viewWillDisappear(animated)
		
		sceneView.session.pause()
	}
    
    @IBAction func backBtn(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
	// MARK: - ARSCNViewDelegate
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
	{
        guard let imageAnchor = anchor as? ARImageAnchor else {return}
        let videoNode = SKVideoNode(fileNamed: "test2.mp4")
        videoNode.play()
        let videoScene = SKScene(size: CGSize(width: 1371, height: 1080))
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoNode.yScale = -1.0
        videoScene.addChild(videoNode)
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = videoScene
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(planeNode)
    }
}
