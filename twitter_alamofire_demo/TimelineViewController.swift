//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {

    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tweetBarButton: UIBarButtonItem!
    
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        activityIndicator.startAnimating()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchTweets()
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
//                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }

    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchTweets()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell

        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "composeTweetSegue"){
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.delegate = self
        }
        
        else if (segue.identifier == "tweetDetailSegue") {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let tweet = tweets[indexPath.row]
                let detailViewController = segue.destination as! TweetDetailViewController
                detailViewController.tweet = tweet
            }
        }
        
        else if (segue.identifier == "profileViewSegue") {
            let profileViewController = segue.destination as! ProfileViewController

        }
        
    }
    
    func did(post: Tweet) {
        self.fetchTweets()
        
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        APIManager.shared.updateHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}
