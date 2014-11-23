//
//  HeaderTable.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 21/11/14.
//  Copyright (c) 2014 ccs. All rights reserved.
//

import UIKit

class HeaderTable: UITableViewController,UIScrollViewDelegate {

    private let kTableHeaderHeight:CGFloat = 300.0
    private let ktableHeaderCutAway:CGFloat = 50.0
    var headerView:UIView!
    var headerMaskLayer:CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetup()
        setupTableHeader()
    }
    
    let items = [
        
        NewsItem(category: .World, summary:"Climate changes protests"),
        NewsItem(category: .Europe, summary:"Sctoland's Yes to independence shakes Europe"),
        NewsItem(category: .MiddleEast, summary:"Next we use the if let control structure"),
        NewsItem(category: .Africa, summary:"Making it optional will allow a value of nil when the cell is first created"),
        NewsItem(category: .Americas, summary:"We will need to change the table view data source methods"),
        NewsItem(category: .Asia, summary:"UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, we have to retrieve the NewsItem value from items corresponding to the row number of the table view cell to display"),
        NewsItem(category: .Europe, summary:"Sctoland's Yes to independence shakes Europe"),
        NewsItem(category: .World, summary:"Climate changes protests"),
        NewsItem(category: .Americas, summary:"We will need to change the table view data source methods"),
        NewsItem(category: .World, summary:"Climate changes protests"),
        NewsItem(category: .Europe, summary:"Sctoland's Yes to independence shakes Europe"),
        NewsItem(category: .MiddleEast, summary:"Next we use the if let control structure"),
        NewsItem(category: .Africa, summary:"Making it optional will allow a value of nil when the cell is first created"),
        NewsItem(category: .Americas, summary:"We will need to change the table view data source methods"),
        NewsItem(category: .Asia, summary:"UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, we have to retrieve the NewsItem value from items corresponding to the row number of the table view cell to display"),
        NewsItem(category: .Europe, summary:"Sctoland's Yes to independence shakes Europe"),
        NewsItem(category: .World, summary:"Climate changes protests"),
        NewsItem(category: .Americas, summary:"We will need to change the table view data source methods")
        
    ]


    func tableSetup () {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50;
    }
    
    func setupTableHeader () {
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        let effectiveHeight = kTableHeaderHeight-ktableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight , left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPointMake(0, -effectiveHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        headerView.layer.mask = headerMaskLayer
        
        updateHeaderView()

    }
    
    override  func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        let effectiveHeight = kTableHeaderHeight-ktableHeaderCutAway/2
        var headerRect = CGRectMake(0, -effectiveHeight, tableView.bounds.width, kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + ktableHeaderCutAway/2
        }
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(headerRect.width, 0))
        path.addLineToPoint(CGPointMake(headerRect.width, headerRect.height))
        path.addLineToPoint(CGPointMake(0, headerRect.height-ktableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // MARK: - TABLE VIEW

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as CustomCell

        let item = items[indexPath.row]
        cell.newsItem = item

        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {

        var favoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Favorite" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.markAsFavorite()
        })

        favoriteAction.backgroundColor = UIColor.brownColor()
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Share" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.share()
        })

        favoriteAction.backgroundColor = UIColor(red: 0.200, green: 0.200, blue: 0.600, alpha: 1)
        
        return [favoriteAction,shareAction]
    }
    
    func markAsFavorite () {
        
    }
    
    func share () {
        
        let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)

        let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)

        shareMenu.addAction(twitterAction)
        shareMenu.addAction(cancelAction)

        self.presentViewController(shareMenu, animated: true, completion: nil)
    }
}
