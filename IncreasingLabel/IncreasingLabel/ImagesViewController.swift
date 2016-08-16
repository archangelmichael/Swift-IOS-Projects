//
//  ImagesViewController.swift
//  IncreasingLabel
//
//  Created by Radi on 8/11/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    
    
    @IBOutlet weak var ivOne: UIImageView!
    @IBOutlet weak var ivTwo: UIImageView!
    
    var startDate: NSDate?
    var index : Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startDate = NSDate()
        let timer = NSTimer(timeInterval: 2,
                            target: self,
                            selector: #selector(animateChange(_:)),
                            userInfo: nil,
                            repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateChange(timer: NSTimer) -> Void {
        index += 1
        
        if index >= self.imageURLS.count {
            index = 0
        }
        
        let seconds = Int(NSDate().timeIntervalSinceDate(self.startDate!))
        
        if (seconds % 4 == 0) {
            self.loadImageFromUrl(self.imageURLS[index], toView: self.ivOne)
        }
        else {
            self.loadImageFromUrl(self.imageURLS[index], toView: self.ivTwo)
        }
    }
    
    
    func loadImageFromUrl(url: String, toView: UIImageView) -> Void {
         let url = NSURL(string: url)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let data = NSData(contentsOfURL: url!) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.animateChangeImage(toView, image: UIImage(data: data))
                });
            }
        }
    }
    
    func animateChangeImage(iv: UIImageView, image: UIImage?) -> Void {
        UIView.transitionWithView(iv,
                                  duration:0.5,
                                  options: UIViewAnimationOptions.TransitionCrossDissolve,
                                  animations: { iv.image = image },
                                  completion: nil)
    }
    

    @IBAction func onBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    let imageURLS = [
        "https://property-monster.com/property/images/fc720e5c-3de5-400a-9b5b-181de4112037.jpg",
        "https://property-monster.com/property/images/9a94f274-708f-4754-b2f9-976be1035f0d.jpg",
        "https://property-monster.com/property/images/7648d087-ba99-4dc4-be39-d519be1bcf0f.jpg",
        "https://property-monster.com/property/images/5dd82cd2-3f73-4d90-b755-8b7d02c81ffa.jpg",
        "https://property-monster.com/property/images/d1d0211d-0260-44de-9dcd-4b9c818284fb.jpg",
        "https://property-monster.com/property/images/800305a7-b702-4aab-a442-f5367d19dad1.jpg",
        "https://property-monster.com/property/images/99d39b6d-66d0-4d14-8e9c-46499a400c59.jpg",
        "https://property-monster.com/property/images/18f75439-bb7c-4482-a9c6-c97336734154.jpg",
        "https://property-monster.com/property/images/298d96e0-6cf3-4d76-86c1-47bbedcfbda4.jpg",
        "https://property-monster.com/property/images/e43bf89f-e2a2-4034-9271-ac5796c99b2b.jpg",
        "https://property-monster.com/property/images/26a1d7ea-0cc4-4f73-9359-a9fc9c626bc4.jpg",
        "https://property-monster.com/property/images/7fa63027-aae6-48fd-9034-38ae26957154.jpg",
        "https://property-monster.com/property/images/d8c211c6-f507-4c3f-a26c-eaf5e90978ec.jpg",
        "https://property-monster.com/property/images/bf5e9753-0d43-41cc-b2f0-9f8c330151aa.jpg",
        "https://property-monster.com/property/images/4549cde0-cd83-44ea-9b4c-ccdd1c46470d.jpg",
        "https://property-monster.com/property/images/6eea107f-a8b2-409e-8e05-e6e440dea1a0.jpg",
        "https://property-monster.com/property/images/d1d92125-c94a-4326-96b7-13352d8d5709.jpg",
        "https://property-monster.com/property/images/ae5c692e-8986-47a6-a0b6-3d61d56910b0.jpg",
        "https://property-monster.com/property/images/d0be598e-99de-48e1-b9fe-8544e58a6244.jpg",
        "https://property-monster.com/property/images/e427a1f3-eeb6-43a0-a588-71775717c00f.jpg",
      "https://property-monster.com/property/images/1e43a515-7871-46df-8e00-ad75b622f7cb.jpg",
        "https://property-monster.com/property/images/fd01dc90-fd42-4a73-83dc-28c7e2b609d7.jpg",
        "https://property-monster.com/property/images/9fcbb80c-9c4b-4752-8bfa-f3b0ad65bc37.jpg",
        "https://property-monster.com/property/images/f0df67f2-ec52-4e1a-ae2a-c4095037e493.jpg",
    "https://property-monster.com/property/images/03099a12-8b0e-4984-99d8-7454dc6817e5.jpg",
       "https://property-monster.com/property/images/2ee6f930-27c6-42a6-b70c-5b8663ccf8f2.jpg",
        "https://property-monster.com/property/images/427081b1-b59d-442e-9516-ae5d3328a5a4.jpg",
       "https://property-monster.com/property/images/1078c8a5-137b-4cd7-a727-6f02bfa081e8.jpg",
        "https://property-monster.com/property/images/dbdd09a5-12f5-4822-a61f-ad2aeae9ac27.jpg",
        "https://property-monster.com/property/images/e23be999-8e85-4786-b156-2090155d12a2.jpg",
        "https://property-monster.com/property/images/a957cf62-eb13-4852-bd12-ed1de4f830dd.jpg",
        "https://property-monster.com/property/images/f57d9149-f16b-4c48-b8d6-23f6bda26089.jpg",
        "https://property-monster.com/property/images/3bd5c2d3-0502-48ed-804f-0d2fc5e08e76.jpg",
      "https://property-monster.com/property/images/7a771bb9-852e-4a5b-8542-e49704142c56.jpg",
        "https://property-monster.com/property/images/340b3959-3db2-4c7d-b3bf-8e98ff949420.jpg",
        "https://property-monster.com/property/images/9e928940-0282-4abd-8762-6ff5eff79113.jpg",
        "https://property-monster.com/property/images/20179fdf-260d-4488-8d4d-c054138ab62f.jpg",
        "https://property-monster.com/property/images/b2810b1b-b564-460b-a944-28fa13890782.jpg",
       "https://property-monster.com/property/images/41bbd916-4ad4-4754-a837-a01862cc8a93.jpg",
      "https://property-monster.com/property/images/302ed137-767a-40ae-8de7-42831fc86fcd.jpg",
       "https://property-monster.com/property/images/1149ed4b-582b-48b2-8aed-eb8fa4f59c62.jpg",
       "https://property-monster.com/property/images/4e412eea-8bae-4494-bdab-6b8ef00af904.jpg",
        "https://property-monster.com/property/images/bf7eadc6-ecb6-47dc-ad34-7a03afcf1ddf.jpg",
       "https://property-monster.com/property/images/34302550-8ecf-45ad-970a-3730c8f68284.jpg",
    "https://property-monster.com/property/images/6a418892-8360-4e2e-826a-b05580c028a8.jpg",
        "https://property-monster.com/property/images/41ae9475-0607-4a04-816c-7e0a3ea4a41e.jpg"]
}
