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
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if (tweet.retweeted == false) {
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unRetweeting: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unRetweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        refreshData()
    }
    
    @IBAction func didTapLike(_ sender: Any) {
        if (tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount! += 1
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        refreshData()
    }
    
    func refreshData() {
        numRetweets.text = (String(tweet.retweetCount))
        numFavorited.text = (String(describing:tweet.favoriteCount!))
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
