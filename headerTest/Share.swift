//
//  Share.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 23/09/15.
//  Copyright (c) 2015 ccs. All rights reserved.
//

import Foundation
import Social

class Share {
    
    class func twitter (itemToShare:NewsItem, presenter:UIViewController) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet.setInitialText(itemToShare.summary)
            presenter.presentViewController(tweetSheet, animated: true, completion: nil)
        }else {
            let alertController = UIAlertController(title: "Twitter Account", message:
                "You need to login into twitter in ios settings panel", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            presenter.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}