//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Raquel Figueroa-Opperman on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}


class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    
    var tweet: Tweet!
    
    var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var tweetCountdown: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.delegate = self
        tweetText.isEditable = true
        self.tweetText.layer.borderWidth = 3.0
        self.tweetText.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        
        userImage.af_setImage(withURL: (User.current?.image)!)
        userName.text = User.current?.name
        userHandle.text = "@" + (User.current?.screenName)!
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let charLimit = 141
        let userText = NSString(string: tweetText.text).replacingCharacters(in: range, with: text)
        tweetCountdown.text = String(charLimit - userText.utf8CString.count)
        
        return userText.utf8CString.count < charLimit
    }

    
    
    @IBAction func didTapTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetText.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
