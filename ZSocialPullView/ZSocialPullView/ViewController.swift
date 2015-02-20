//
//  ViewController.swift
//  ZPullView
//
//  Created by Ricardo Zertuche on 2/19/15.
//  Copyright (c) 2015 Ricardo Zertuche. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZSocialPullDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var he = UIImage(named: "heart_e.png")
        var hf = UIImage(named: "heart_f.png")
        var se = UIImage(named: "share_e.png")
        var sf = UIImage(named: "share_f.png")
        
        self.view.backgroundColor = UIColor.blackColor()
        
        var v = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 375))
        var img1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 375))
        img1.image = UIImage(named: "1.jpg")
        v.addSubview(img1)
        
        var socialPullPortrait = ZSocialPullView(frame: CGRect(x: 0, y: 22, width: self.view.frame.width, height: 400))
        socialPullPortrait.setLikeImages(he!, filledImage: hf!)
        socialPullPortrait.setShareImages(se!, filledImage: sf!)
        socialPullPortrait.backgroundColorOriginal = UIColor.blackColor()
        socialPullPortrait.Zdelegate = self
        socialPullPortrait.setUIView(v)
        self.view.addSubview(socialPullPortrait)
        
        ///////////////////////////////////////////////////////////////////////////////////////
        
        var v2 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        var img2 = UIImageView(frame: CGRect(x: 0, y: 0, width: v2.frame.width, height: 200))
        img2.image = UIImage(named: "2.jpg")
        v2.addSubview(img2)
        
        var socialPullLandscape = ZSocialPullView(frame: CGRect(x: 0, y: 450, width: self.view.frame.width, height: 200))
        socialPullLandscape.setLikeImages(he!, filledImage: hf!)
        socialPullLandscape.setShareImages(se!, filledImage: sf!)
        socialPullLandscape.backgroundColorOriginal = UIColor.blackColor()
        socialPullLandscape.Zdelegate = self
        socialPullLandscape.setUIView(v2)
        self.view.addSubview(socialPullLandscape)
        
    }
    
    func ZSocialPullAction(view: ZSocialPullView, action: String) {
        println(action)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

