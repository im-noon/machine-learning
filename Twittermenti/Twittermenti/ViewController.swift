//
//  ViewController.swift
//  Twittermenti
//
//  Created by Slimn Srarena on 8/11/19.
//  Copyright © 2019 Noon Studio. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {

//    @IBOutlet var backgroundView: UIView!
//    @IBOutlet var textField: UIView!
//    @IBOutlet var sentimentLabel: UITextField!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var sentimentLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let maxTweetCount = 100
    
    let sentimentClassify = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "YOUR_TWITTER_API_KEY",
                          consumerSecret: "YOUR_TWITTER_API_SECRET_KEY")
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Ready Go!")
    }


    @IBAction func predictionPressed(_ sender: UIButton) {
        fetchTweets()
    }
    
    func fetchTweets() {
        
        if let searchText = textField.text {
            swifter.searchTweet(using:searchText, lang: "en", count: maxTweetCount, tweetMode: .extended, success: { (results, medatda) in
                
                var tweets = [TweetSentimentClassifierInput]()
                for index in 1 ..< self.maxTweetCount {
                    if let tweet = results[index]["full_text"].string {
                        let tweetClassifiation = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetClassifiation)
                    }
                }
                
                self.makePrediction(with: tweets)
                
            }) { (error) in
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func makePrediction(with tweets:[TweetSentimentClassifierInput]) {
        do {
            var sentimentScore = 0
            let predictions = try self.sentimentClassify.predictions(inputs:tweets)
            
            for pred in predictions {
                let sentiment = pred.label
                if sentiment == "Pos" {
                    sentimentScore += 1
                }
                else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
            }
            
            updateUI(sentimentScore)
        }
        catch {
            print("There was an prediction error : \(error)")
        }
    }
    
    func updateUI(_ sentimentScore:Int) {
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        }
        else if sentimentScore > 10 {
            self.sentimentLabel.text = "😄"
        }
        else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂"
        }
        else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
        }
        else if sentimentScore > -10 {
            self.sentimentLabel.text = "😤"
        }
        else if sentimentScore > -20 {
            self.sentimentLabel.text = "😡"
        }
        else {
            self.sentimentLabel.text = "🤮"
        }
    }
}

