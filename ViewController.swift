//
//  ViewController.swift
//  Pokemon3D
//
//  Created by Harsh Goutam on 16/12/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        //images to track--1
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed:"PokemonCards", bundle: Bundle.main){
            //change configuration traking Images property---2
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
            print("Images Succesfully Added")
        }
       

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    //anchor is the image that got detected , response to the detected image
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
//            print(imageAnchor.referenceImage.name)
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode =  SCNNode(geometry: plane)
            
            
            planeNode.eulerAngles.x = -Float.pi / 2
            
            node.addChildNode(planeNode)
            if imageAnchor.referenceImage.name == "eevee_card"{
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn"){
                                if let pokeNode = pokeScene.rootNode.childNodes.first{
                                    pokeNode.eulerAngles.x = .pi / 2
                                    planeNode.addChildNode(pokeNode)
                                    
                                }
                            }
            }
            
            if imageAnchor.referenceImage.name == "oddish"{
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn"){
                                if let pokeNode = pokeScene.rootNode.childNodes.first{
                                    pokeNode.eulerAngles.x = .pi / 2
                                    planeNode.addChildNode(pokeNode)
                                    
                                }
                            }
            }
            
            
        }
        return node
    }
}
