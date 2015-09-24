//
//  TableHeader.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 23/09/15.
//  Copyright (c) 2015 ccs. All rights reserved.
//

import UIKit

enum Header:CGFloat {
    case NegativeHeight = -270
    case EfectiveHeight = 275
    case TableHeaderHeight = 300
    case TableHeaderCutAway = 50
    case TableHeaderMargin = 25
}

extension UITableView {

    func updateHeaderView (table:UITableView,headerView:UIView,layerMask:CAShapeLayer) {
        let kTableHeaderHeight:CGFloat = 300.0
        let ktableHeaderCutAway:CGFloat = 50.0
        let effectiveHeight = kTableHeaderHeight-ktableHeaderCutAway/2
        var headerRect = CGRectMake(0, -effectiveHeight, table.bounds.width, kTableHeaderHeight)
        if table.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = table.contentOffset.y
            headerRect.size.height = -table.contentOffset.y + ktableHeaderCutAway/2
        }
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, 0))
        path.addLineToPoint(CGPointMake(headerRect.width, 0))
        path.addLineToPoint(CGPointMake(headerRect.width, headerRect.height))
        path.addLineToPoint(CGPointMake(0, headerRect.height-ktableHeaderCutAway))
        layerMask.path = path.CGPath
    }

}
