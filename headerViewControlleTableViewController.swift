//
//  headerViewControlleTableViewController.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 21/11/14.
//  Copyright (c) 2014 ccs. All rights reserved.
//

import UIKit

class headerViewControlleTableViewController: UITableViewController,UIScrollViewDelegate {

    private let kTableHeaderHeight:CGFloat = 300.0
    private let ktableHeaderCutAway:CGFloat = 80.0
    var headerView:UIView!
    var headerMaskLayer:CAShapeLayer
    
    let items = [
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50;
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        headerView.layer.mask = headerMaskLayer
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0)
        tableView.contentOffset = CGPointMake(0, -kTableHeaderHeight)
        updateHeaderView()
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        var headerRect = CGRectMake(0, -kTableHeaderHeight, tableView.bounds.width, kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(headerRect.width, 0))
        path.addLineToPoint(CGPointMake(headerRect.width, headerRect.height))
        path.addLineToPoint(CGPointMake(0, headerRect.height-ktableHeaderCutAway))
        headerMaskLayer.path = path.CGPath
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

}
