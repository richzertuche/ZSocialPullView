//
//  ZSocialScrollView.swift
//  ZPullView
//
//  Created by Ricardo Zertuche on 2/19/15.
//  Copyright (c) 2015 Ricardo Zertuche. All rights reserved.
//

import UIKit

@objc protocol ZSocialPullDelegate {
    func ZSocialPullAction(view: ZSocialPullView,action:String)
}

class ZSocialPullView: UIView, UIScrollViewDelegate
{
    var Zdelegate: ZSocialPullDelegate?
    
    var scrollview: UIScrollView!
    
    var likeEmptyImage: UIImage?
    var likeFilledImage: UIImage?
    
    var emptyLikeView: UIView!
    var filledLikeView: UIView!
    
    var shareEmptyImage: UIImage?
    var shareFilledImage: UIImage?
    
    var emptyShareView: UIView!
    var filledShareView: UIView!
    
    var backgroundColorOriginal: UIColor?
    
    private var originalView: UIView!
    private var bounceVar:CGFloat = 0.0
    private var bouncing:Bool = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setLikeImages(emptyImage: UIImage, filledImage: UIImage)
    {
        likeEmptyImage = emptyImage
        likeFilledImage = filledImage
    }
    
    func setShareImages(emptyImage: UIImage, filledImage: UIImage)
    {
        shareEmptyImage = emptyImage
        shareFilledImage = filledImage
    }
    
    func setUIView(view: UIView){
        
        //Centering the original View
        view.frame = CGRect(x: self.frame.width/2-view.frame.width/2, y: self.frame.height/2-view.frame.height/2, width: view.frame.width, height: view.frame.height)
        view.backgroundColor = backgroundColorOriginal
        //
        originalView = view
        
        //Like Button Filled
        filledLikeView = UIView(frame: CGRect(x: view.frame.width-65+view.frame.origin.x, y: self.frame.height/2-25, width: 50, height:50))
        var likeFilledImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: filledLikeView.frame.width, height: filledLikeView.frame.height))
        likeFilledImageView.image = likeFilledImage
        filledLikeView.addSubview(likeFilledImageView)
        self.addSubview(filledLikeView)
        
        //Like Button Empty
        emptyLikeView = UIView(frame: CGRect(x: view.frame.width-65+view.frame.origin.x, y: self.frame.height/2-25, width: 50, height:50))
        emptyLikeView.backgroundColor = backgroundColorOriginal
        var likeEmptyImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: emptyLikeView.frame.width, height: emptyLikeView.frame.height))
        likeEmptyImageView.image = likeEmptyImage
        emptyLikeView?.addSubview(likeEmptyImageView)
        self.addSubview(emptyLikeView!)
        
        //Share Button Filled
        filledShareView = UIView(frame: CGRect(x: view.frame.origin.x+15, y: self.frame.height/2-25, width: 50, height:50))
        var shareFilledImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: filledShareView.frame.width, height: filledShareView.frame.height))
        shareFilledImageView.image = shareFilledImage
        filledShareView.addSubview(shareFilledImageView)
        self.addSubview(filledShareView)
        
        //Share Button Empty
        emptyShareView = UIView(frame: CGRect(x: view.frame.origin.x+15, y: self.frame.height/2-25, width: 50, height:50))
        emptyShareView.backgroundColor = backgroundColorOriginal
        var shareEmptyImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: emptyShareView.frame.width, height: emptyShareView.frame.height))
        shareEmptyImageView.image = shareEmptyImage
        emptyShareView?.addSubview(shareEmptyImageView)
        self.addSubview(emptyShareView!)
        
        
        //
        scrollview = UIScrollView(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        scrollview.delegate = self
        scrollview.bounces = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.alwaysBounceHorizontal = true
        scrollview.backgroundColor = UIColor.clearColor()
        scrollview.contentSize = CGSize(width: self.frame.width+1, height: self.frame.height)
        self.addSubview(scrollview)
        scrollview.addSubview(view)
        
        emptyLikeView.hidden = true
        filledLikeView.hidden = true
        emptyShareView.hidden = true
        filledShareView.hidden = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var n = scrollView.contentOffset.x / self.frame.width
        if bouncing == false {
            if n>0{
                self.colorLikeView(n)
                emptyLikeView.hidden = false
                filledLikeView.hidden = false
                emptyShareView.hidden = true
                filledShareView.hidden = true
                
            }
            else if n<0{
                self.colorShareView(n)
                emptyLikeView.hidden = true
                filledLikeView.hidden = true
                emptyShareView.hidden = false
                filledShareView.hidden = false
            }
        }
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        bouncing = true
        
        if scrollview.contentOffset.x >= 75.0 {
            self.didLike()
        }
        else if scrollview.contentOffset.x <= -75.0 {
            self.didShare()
        }
        
        if scrollview.contentOffset.x >= 0 {
            self.filledShareView.hidden = true
            self.emptyShareView.hidden = true
        }
        else if scrollview.contentOffset.x < 0 {
            self.filledLikeView.hidden = true
            self.emptyLikeView.hidden = true
        }
        
        if scrollView.contentOffset.x >= 50 { bounceVar = 50 }
        if scrollView.contentOffset.x < 50 && scrollView.contentOffset.x > -50 { bounceVar = scrollView.contentOffset.x }
        if scrollView.contentOffset.x < -50 { bounceVar = -50 }

        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5, options: .CurveEaseOut, animations: {
            //self.scrollview.setContentOffset(CGPointMake(0.00266666666666667, 0), animated: true)
            self.scrollview.setContentOffset(CGPointMake(0.00266666666666667-self.bounceVar, 0), animated: true)
            }, completion:{
                finished in
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("bounceBack1"), userInfo: nil, repeats: false)
        })
    }
    
    func bounceBack1()
    {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5, options: .CurveEaseOut, animations: {
            //self.scrollview.setContentOffset(CGPointMake(0.00266666666666667, 0), animated: true)
            self.scrollview.setContentOffset(CGPointMake(0.00266666666666667+self.bounceVar/2, 0), animated: true)
            self.layoutIfNeeded()
            }, completion:{
                finished in
                self.filledLikeView.hidden = true
                self.emptyLikeView.hidden = true
                self.filledShareView.hidden = true
                self.emptyShareView.hidden = true
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("bounceBack2"), userInfo: nil, repeats: false)
        })
    }
    
    func bounceBack2()
    {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5, options: .CurveEaseOut, animations: {
            //self.scrollview.setContentOffset(CGPointMake(0.00266666666666667, 0), animated: true)
            self.scrollview.setContentOffset(CGPointMake(0.00266666666666667-self.bounceVar/4, 0), animated: true)
            self.layoutIfNeeded()
            }, completion:{
                finished in
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("bounceBack3"), userInfo: nil, repeats: false)
        })
    }
    
    func bounceBack3()
    {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 5, options: .CurveEaseOut, animations: {
            //self.scrollview.setContentOffset(CGPointMake(0.00266666666666667, 0), animated: true)
            self.scrollview.setContentOffset(CGPointMake(0.00266666666666667, 0), animated: true)
            self.layoutIfNeeded()
            }, completion:{
                finished in
                self.filledLikeView.hidden = false
                self.emptyLikeView.hidden = false
                self.filledShareView.hidden = false
                self.emptyShareView.hidden = false
                self.bouncing = false
        })
    }
    
    func colorLikeView(percent: CGFloat){
        var x = (percent*100)/0.29
        var y = (50-x)+20
        if  (y<0){
            y=0
            }
            emptyLikeView.frame = CGRect(x: originalView.frame.width-65+originalView.frame.origin.x, y: self.frame.height/2-25, width: 100, height:y)
    }
    
    func colorShareView(percent: CGFloat){
        var abspercent = abs(percent)
        var x = (abspercent*100)/0.29
        var y = (50-x)+20
        if  (y<0){
            y=0
        }
        emptyShareView.frame = CGRect(x: originalView.frame.origin.x+15, y: self.frame.height/2-25, width: 100, height:y)
    }
    
    func didLike(){
        self.Zdelegate?.ZSocialPullAction(self, action: "didLike")
    }
    
    func didShare(){
        self.Zdelegate?.ZSocialPullAction(self, action: "didShare")
    }
}
