//
//  CustomCell.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 21/11/14.
//  Copyright (c) 2014 ccs. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var newsItem:NewsItem? {
        
        didSet {
            if let item = newsItem {
                categoryLabel.text = item.category.type()
                categoryLabel.textColor = item.category.color()
                contentLabel.text = item.summary
            }
            else {
                categoryLabel.text = nil
                contentLabel.text = nil
            }
        }
    }
}
