//
//  CellActions.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 24/09/15.
//  Copyright © 2015 ccs. All rights reserved.
//

import UIKit

class CellActions {
    
    class func favoriteAction (item:NewsItem, presenter:UIViewController) -> UITableViewRowAction {
        let favoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Favorite" , handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            FavoritesManager.addFavorite(item, presenter: presenter)
        })
        favoriteAction.backgroundColor = UIColor(red: 0.200, green: 0.200, blue: 0.600, alpha: 1)
        return favoriteAction
    }
    
    class func shareAction (item:NewsItem,presenter:UIViewController) -> UITableViewRowAction {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Share" , handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            Share.twitter(item, presenter: presenter)
        })
        shareAction.backgroundColor = UIColor(red: 0.200, green: 0.800, blue: 0.200, alpha: 1)
        return shareAction
    }
}
