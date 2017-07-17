//
//  TSCellTweetList.swift
//  TweeeetSearch
//
//  Created by Bharat Byan on 16/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import UIKit

class TSCellTweetList: UITableViewCell {
   
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTweet: UIImageView!
    
    //The lazy image object
    lazy var lazyImage:LazyImage = LazyImage()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ viewModel: TSViewModelTweet)
    {
        if MyVariables.isTweetTextON {
            self.lblTitle.isHidden = false
        }else{
            self.lblTitle.isHidden = true
        }
        
        self.lblTitle.text = viewModel.title

        self.lazyImage.showWithSpinner(imageView:self.imgTweet, url:viewModel.webLink!) {
            (error:LazyImageError?) in
            //Lazy loading complete. Do something..
        }
    }
}
