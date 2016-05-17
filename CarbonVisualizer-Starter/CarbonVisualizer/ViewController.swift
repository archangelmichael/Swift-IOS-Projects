/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import SceneKit

class ViewController: UIViewController {
    // UI
    @IBOutlet weak var geometryLabel: UILabel!
    @IBOutlet weak var sceneView: SCNView!
    
    // Set rotation around y only
//     Geometry
    var geometryNode: SCNNode = SCNNode()
//
//    // Gestures
//    var currentAngle: Float = 0.0
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.sceneSetup()
        
        geometryLabel.text = "Atoms\n"
        geometryNode = Atoms.allAtoms()
        sceneView.scene!.rootNode.addChildNode(geometryNode)
    }
    
    // Set rotation around y only
//    func panGesture(sender: UIPanGestureRecognizer) {
//        let translation = sender.translationInView(sender.view!)
//        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
//        newAngle += currentAngle
//        
//        geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
//        
//        if(sender.state == UIGestureRecognizerState.Ended) {
//            currentAngle = newAngle
//        }
//    }
    
    // MARK: Scene
    func sceneSetup() {
        let scene = SCNScene()
        self.setupLighting(scene)
        self.setupCamera(scene)
        
        // Set up box
//        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 1.0)
//        let boxNode = SCNNode(geometry: boxGeometry)
//        scene.rootNode.addChildNode(boxNode)
        
        // Set rotation around y only
//        geometryNode = boxNode
//        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesture(_:)))
//        sceneView.addGestureRecognizer(panRecognizer)
        
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
    }
    
    func setupLighting(scene: SCNScene) -> Void {
        // Setup light
        let light = SCNLight()
        light.type = SCNLightTypeSpot
        light.color = UIColor.greenColor() //UIColor(white: 0.2, alpha: 1.0)
        
        // Setup ambient light
        light.type = SCNLightTypeAmbient
        let ambientLightNode = SCNNode()
        ambientLightNode.light = light
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Setup directional light
        //        light.type = SCNLightTypeDirectional
        //        let directionalLightNode = SCNNode()
        //        directionalLightNode.position = SCNVector3Make(0, 50, 50)
        //        directionalLightNode.orientation = SCNQuaternion(x: -0.26, y: -0.32, z: 0, w: 0.91)
        //        scene.rootNode.addChildNode(directionalLightNode)
        
        // Setup omni light
        //        light.type = SCNLightTypeOmni
        //        let omniLightNode = SCNNode()
        //        omniLightNode.position = SCNVector3Make(0, 50, 50)
        //        scene.rootNode.addChildNode(omniLightNode)
        
        // Setup spot light
        //        light.type = SCNLightTypeSpot
        //        let spotLightNode = SCNNode()
        //        spotLightNode.light = light.type
        //        spotLightNode.position = SCNVector3(x: 0, y: 0, z: 20)
        //        spotLightNode.orientation = SCNQuaternion(x: 0, y: 0, z: 1, w: 0.5)
        //        scene.rootNode.addChildNode(spotLightNode)
    }
    
    func setupCamera(scene: SCNScene) -> Void {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 25)
//        // Setup corner camera
//        cameraNode.position = SCNVector3Make(25, 25, 25)
//        cameraNode.eulerAngles = SCNVector3Make(Float(-M_PI/4), Float(M_PI/4), 0);
        scene.rootNode.addChildNode(cameraNode)
    }
    
    // MARK: IBActions
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        // 1
        geometryNode.removeFromParentNode()
        // currentAngle = 0.0
        
        // 2
        switch sender.selectedSegmentIndex {
        case 0:
            geometryLabel.text = "Atoms\n"
            geometryNode = Atoms.allAtoms()
        case 1:
            geometryLabel.text = "Methane\n(Natural Gas)"
            geometryNode = Molecules.methaneMolecule()
        case 2:
            geometryLabel.text = "Ethanol\n(Alcohol)"
            geometryNode = Molecules.ethanolMolecule()
        case 3:
            geometryLabel.text = "Polytetrafluoroethylene\n(Teflon)"
            geometryNode = Molecules.ptfeMolecule()
        default:
            break
        }
        
        // 3
        sceneView.scene!.rootNode.addChildNode(geometryNode)
    }
    
    // MARK: Style
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: Transition
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        sceneView.stop(nil)
        sceneView.play(nil)
    }
}
