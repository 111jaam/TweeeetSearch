//
//  TSVCTweetsList.swift
//  TweeeetSearch
//
//  Created by Bharat Byan on 16/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import UIKit

class TSVCTweetsList: UIViewController {
   
    var viewModelsTweet: [TSViewModelTweet] = []
    
    @IBOutlet weak var tblTweets: UITableView!
    @IBOutlet weak var actvityTweetsList: UIActivityIndicatorView!
    
    var strSearchString = ""
    var strLocation = ""
    var strTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        
        actvityTweetsList.startAnimating()
        tblTweets.isHidden = true
        callWeb()
    }
    
    func callWeb(){
        viewModelsTweet = []
        
        TSNetManagerTweets.sharedInstance.createRequest(withSearchString: strSearchString, strLocation: strLocation, strTime: strTime)
        TSNetManagerTweets.sharedInstance.delegate = self
    }
}

extension TSVCTweetsList: UITableViewDataSource {
    // MARK: - Table View DataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModelsTweet.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetsCell", for: indexPath) as! TSCellTweetList
        
        // Configure the cell...
        cell.configureCell(viewModelsTweet[indexPath.row])
        
        return cell
    }
}

extension TSVCTweetsList: TSProtocolManagerTweets {
    
    func sendData(arrayOfViewModel: Array<TSViewModelTweet>){
                
        viewModelsTweet = arrayOfViewModel
        
        if viewModelsTweet.count > 1 {
            self.title = "Tweets Found:\(viewModelsTweet.count)"
            
            let alertView = UIAlertController(title: "Message", message: "Tweets Found:\(viewModelsTweet.count)", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                self.tblTweets.isHidden = false
                self.tblTweets.reloadData()
                self.actvityTweetsList.stopAnimating()
                self.actvityTweetsList.isHidden = true
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
            
        }else{
            let alertView = UIAlertController(title: "Message", message: "No Tweets found, try searching something else.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                self.actvityTweetsList.stopAnimating()
                self.actvityTweetsList.isHidden = true
                _ = self.navigationController?.popViewController(animated: true)
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
