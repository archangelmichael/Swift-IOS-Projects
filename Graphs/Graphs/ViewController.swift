//
//  ViewController.swift
//  Graphs
//
//  Created by Radi on 5/16/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import SwiftCSV

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let nodesPath = NSBundle.mainBundle().pathForResource("nodes_rgl_200", ofType: "csv"),
            let nodesString = try? String(contentsOfFile: nodesPath) else {
            print("Bad nodes file")
            return
        }
        
        var nodes : [String: Node] = [:]
        var edges : [Connection] = []
        
        let nodesData = CSV(string: nodesString)
        // Access them as a dictionary "id","label","size","color","x","y","z"
        nodesData.enumerateAsDict { nodeDict in
            guard let id = nodeDict["id"],
                let x = nodeDict["x"],
                let y = nodeDict["y"],
                let z = nodeDict["z"],
                let color = nodeDict["color"],
                let size = nodeDict["size"],
                let label = nodeDict["label"]
            else {
                    print("Bad node")
                    return
            }
            
            let node = Node(id: id, x: x, y: y, z: z, color: color, size: Double(size)!, label: label)
            nodes[node.id] = node
        }
        
        print("\(nodes.count) Nodes loaded")
        
        guard let edgesPath = NSBundle.mainBundle().pathForResource("edges_rgl_200", ofType: "csv"),
            let edgesString = try? String(contentsOfFile: edgesPath) else {
                print("Bad edges file")
                return
        }
        
        let edgesData = CSV(string: edgesString)
            // Access them as a dictionary "from","to","size","color"
            edgesData.enumerateAsDict { edgeDict in
                guard let from = edgeDict["from"],
                    let to = edgeDict["to"],
                    let color = edgeDict["color"],
                    let size = edgeDict["size"]
                    else {
                        print("Bad edge")
                        return
                }
                
                guard let nodeFrom = nodes[from],
                    let nodeTo = nodes[to] else {
                        print("Bad edge ids")
                        return
                }
                
                let edge = Connection(from: nodeFrom, to: nodeTo, color: color, size: Double(size)!)
                edges.append(edge)
        }
        
        print("\(edges.count) Edges loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func drawEdge() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer)

    }
}

