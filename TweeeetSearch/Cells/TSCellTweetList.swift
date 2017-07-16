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
        self.lblTitle.text = viewModel.title
    }
}
