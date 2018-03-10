//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Raquel Figueroa-Opperman on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var profileTagline: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.af_setImage(withURL: (User.current?.image)!)
        userName.text = User.current?.name
        userHandle.text = User.current?.screenName
        numTweets.text = String(describing: User.current!.tweets!)
        numFollowers.text = String(describing: User.current!.followers!)
        numFollowing.text = String(describing: User.current!.following!)
        profileTagline.text = User.current?.tagline
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
