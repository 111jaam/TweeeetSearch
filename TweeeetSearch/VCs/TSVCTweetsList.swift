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
    
    var strSearchString = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        callWeb()
    }
    
    func callWeb(){
        viewModelsTweet = []
        
        TSNetManagerTweets.sharedInstance.createRequest(withSearchString: strSearchString)
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
        self.tblTweets.reloadData()
    }
}
