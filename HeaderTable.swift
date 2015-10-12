//
//  HeaderTable.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 21/11/14.
//  Copyright (c) 2014 ccs. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON

class HeaderTable: UITableViewController {

    private let kTableHeaderHeight:CGFloat = 200.0
    private let ktableHeaderCutAway:CGFloat = 50.0
    private var headerView:UIView!
    private var headerMaskLayer = CAShapeLayer()
    private var newsArray = [NewsItem]()
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var nowDate:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNews()
        tableSetup()
        setupTableHeader()
        nowDate.text = String(format: "Now")
    }

    private func updateNews () {
    
        Alamofire.request(.GET, apiURL, parameters: nil)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let JSON):
                    let counter:Int = JSON["num_results"] as! Int
                    if counter > 0 {
                        self.parseNews(JSON["results"])
                    }
                case .Failure( _, let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
    
    private func parseNews (data:AnyObject!) {
        let news = (data as? NSArray) as! Array<[String: String]>//Array?
        var receivedNews = [NewsItem]()
        for item in news {
            receivedNews.append(NewsItem(category: .World, summary: item["abstract"]!))
        }
        
        newsArray = receivedNews
    }

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
        return newsArray.count
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        cell.newsItem = newsArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        return [CellActions.favoriteAction(newsArray[indexPath.row], presenter: self),
                CellActions.shareAction(newsArray[indexPath.row], presenter: self)]
    }
}
