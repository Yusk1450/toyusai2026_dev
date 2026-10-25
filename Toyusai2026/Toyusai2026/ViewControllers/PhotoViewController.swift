//
//  photoViewController.swift
//  Toyusai2026
//
//  Created by 橋本晄汰 on 2026/10/20.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class PhotoViewController: BaseViewController,ARSCNViewDelegate
{

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var backBtn: UIButton!

    var player: AVPlayer?
    var stepTimer: Timer?
    var waitNishimaTimer: Timer?
    
    var isTrack = false
    
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
    
    @IBAction func nextStepDown(_ sender: Any) {
        self.stepTimer?.invalidate()
        self.stepTimer = Timer.scheduledTimer(timeInterval: 0.08,
                                              target: self,
                                              selector: #selector(self.holdNextStep),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    @IBAction func nextStepUp(_ sender: Any) {
        self.stepTimer?.invalidate()
        self.stepTimer = nil
    }
    
    @objc func holdNextStep()
    {
        self.step(forward: true)
    }
    
    
    @IBAction func backStepDown(_ sender: Any) {
        self.stepTimer?.invalidate()
        self.stepTimer = Timer.scheduledTimer(timeInterval: 0.08,
                                              target: self,
                                              selector: #selector(self.holdBackStep),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    @IBAction func backStepUp(_ sender: Any) {
        self.stepTimer?.invalidate()
        self.stepTimer = nil
    }
    
    @objc func holdBackStep()
    {
        self.step(forward: false)
    }
    
    func step(forward: Bool) {
        
        if (self.isTrack)
        {
            if let player = self.player {
                self.player?.pause()
                
                let fps: Int32 = 60
                let frame = CMTime(value: 8, timescale: fps)
                let currentTime = player.currentTime()
                let step: CMTime
                if (forward) {
                    step = CMTimeAdd(currentTime, frame)
                } else {
                    step = CMTimeSubtract(currentTime, frame)
                }

                player.seek(to: step, toleranceBefore: .zero, toleranceAfter: .zero){ _ in
                    let framIndex = Int(currentTime.seconds * Double(fps))
                    if (framIndex > 236 && framIndex < 253)
                    {
                        if (self.waitNishimaTimer == nil)
                        {
                            self.waitNishimaTimer = Timer.scheduledTimer(timeInterval: 5.0,
                                target: self,
                                selector: #selector(self.nextChat),
                                userInfo: nil,
                                repeats: false)
                        }

                    }
                    else
                    {
                        self.waitNishimaTimer?.invalidate()
                        self.waitNishimaTimer = nil
                    }
                }
            }
            
        }
    }
    
    @objc func nextChat()
    {
        self.waitNishimaTimer?.invalidate()
        self.waitNishimaTimer = nil
        guard let player = self.player else { return }
        
        let framIndex = Int(player.currentTime().seconds * 60)
        if (framIndex >= 236 && framIndex <= 253)
        {
            
            self.presentingViewController?.presentingViewController?.dismiss(animated: false)
            {
                let director = GameDirector.shared
                director.currentScene?.startScenario()
            }
        }
    }
    // MARK: - ARSCNViewDelegate
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
	{
        guard let imageAnchor = anchor as? ARImageAnchor else {return}
        self.isTrack = true
        if (self.player != nil)
        {
            return
        }
        guard let url = Bundle.main.url(forResource: "photoAR", withExtension: "mp4") else {return}
        self.player = AVPlayer(url: url)
        self.player?.pause()
        let videoNode = SKVideoNode(avPlayer: self.player!)
        videoNode.play()
        self.player?.pause()
        let videoScene = SKScene(size: CGSize(width: 1420, height: 1000))
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoNode.yScale = -1.0
        videoScene.addChild(videoNode)
//        let plane = SCNPlane(width: 0.165, height:0.117)
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height
        )
        plane.firstMaterial?.diffuse.contents = videoScene
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(planeNode)
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
    {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        self.isTrack = imageAnchor.isTracked
    }
}

