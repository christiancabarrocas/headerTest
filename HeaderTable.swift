//
//  HeaderTable.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 21/11/14.
//  Copyright (c) 2014 ccs. All rights reserved.
//

import UIKit

class HeaderTable: UITableViewController {

    private let kTableHeaderHeight:CGFloat = 300.0
    private let ktableHeaderCutAway:CGFloat = 50.0
    var headerView:UIView!
    var headerMaskLayer = CAShapeLayer()
    @IBOutlet weak var headerImage: UIImageView!
    
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


    private func tableSetup () {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50;
    }
    
    private func setupTableHeader () {
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        let effectiveHeight = kTableHeaderHeight-ktableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight , left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPointMake(0, -effectiveHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        headerView.layer.mask = headerMaskLayer
        headerImage.blackAndWhite()
        tableView.updateHeaderView(tableView, headerView: headerView, layerMask: headerMaskLayer)
    }

    override  func scrollViewDidScroll(scrollView: UIScrollView) {
        tableView.updateHeaderView(tableView, headerView: headerView, layerMask: headerMaskLayer)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        cell.newsItem = items[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        return [CellActions.favoriteAction(self.items[indexPath.row], presenter: self),
                CellActions.shareAction(self.items[indexPath.row], presenter: self)]
    }
}
