# ZSocialPullView

<h6>Swift Social UIView inside UIScrollView</h6>

<p>Inspired by this GIF:</p>

<img src="https://m1.behance.net/rendition/modules/152914209/disp/06fa314c839f7fc2fa0df1b0d7f5d1de.gif"/>
<p>So far:</p>
[![ZMaterialButton](http://img.youtube.com/vi/ksMkNRxzudQ/0.jpg)](http://www.youtube.com/watch?v=ksMkNRxzudQ)
<br>
<br>
**You need to add the ZSocialPullDelegate to your Controller:**

```swift
class ViewController: UIViewController, ZSocialPullDelegate {
}
```
<br>
**To ZSocialPullView just create a UIView with your desired content and create a ZSocialPullView with a frame.**
<br>
You can add the like or share images you prefer.
You **MUST** set the backgroundColorOriginal property for the ZSocialPullView as the same color of your superview.
Remember to add the delegate
**Most importantly, the .setUIView is the last function to call for this control**
<br>

```swift
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
```
<br>
**Add the delegate function ZSocialPullAction().**
<br>
```swift
func ZSocialPullAction(view: ZSocialPullView, action: String) {
        println(action)
    }
```

Hope you like it :]
<br>
<p>Follow me on Twitter <a href="https://www.twitter.com/richzertuche" target="_blank"> @richzertuche</a></p>

