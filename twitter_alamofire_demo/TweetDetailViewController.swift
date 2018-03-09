//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Raquel Figueroa-Opperman on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var numRetweets: UILabel!
    @IBOutlet weak var numFavorited: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var tweet: Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tweet = tweet {
            userImage.af_setImage(withURL: tweet.user.image)
            userName.text = tweet.user.name
            userHandle.text = "@" + tweet.user.screenName!
            tweetLabel.text = tweet.text
            date.text = tweet.createdAtString
            numRetweets.text = (String(tweet.retweetCount))
            numFavorited.text = (String(describing:tweet.favoriteCount!))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
