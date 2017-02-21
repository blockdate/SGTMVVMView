//
//  SGTMVVMSwipeTableCellViewModel.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/16.
//  Copyright © 2017年 sgt. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import ReactiveSwift
import ReactiveCocoa

public class SGTSwipeButtonTitleConfig : NSObject{
    var title: String
    var backColor: UIColor
    var image: UIImage?
    var command: CocoaAction<IndexPath>?
    public init(title: String, backColor: UIColor, image: UIImage?, command: CocoaAction<IndexPath>?) {
        self.title = title;
        self.backColor = backColor
        super.init()
        self.image = image
        self.command = command
    }
}

open class SGTMVVMSwipeTableCellViewModel: SGTMVVMTableCellViewModel {
    
    override open func viewClass() -> AnyClass {
        return SGTMVVMSwipeTableViewCell.self
    }
    
    var leftSwipeTitles: Array<SGTSwipeButtonTitleConfig> = Array()
    
    var rightSwipeTitles: Array<SGTSwipeButtonTitleConfig> = Array()
    
    open override func initialize() {
        super.initialize()
    }
}

extension SGTMVVMSwipeTableCellViewModel: MGSwipeTableCellDelegate {
    
    public func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection, from point: CGPoint) -> Bool {
        switch direction {
        case .leftToRight:
            return leftSwipeTitles.count > 0
        case .rightToLeft:
            return rightSwipeTitles.count > 0
        }
    }
    
    public func swipeTableCell(_ cell: MGSwipeTableCell, swipeButtonsFor direction: MGSwipeDirection, swipeSettings: MGSwipeSettings, expansionSettings: MGSwipeExpansionSettings) -> [UIView]? {
        
        expansionSettings.buttonIndex = 0
        expansionSettings.fillOnTrigger = true
        
        let titleConfig = direction == .leftToRight ? self.leftSwipeTitles : self.rightSwipeTitles
        var buttons: Array<MGSwipeButton> = Array()
        for config in titleConfig {
            if config.image != nil {
                let button = MGSwipeButton(title: config.title, icon: config.image, backgroundColor: config.backColor)
                buttons.append(button)
            }else {
                let button = MGSwipeButton(title: config.title, backgroundColor: config.backColor)
                buttons.append(button)
            }
        }
        
        return buttons
    }
    
    public func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let config = direction == .leftToRight ? self.leftSwipeTitles[index] : self.rightSwipeTitles[index]
        if let tableView = self.tableViewForCell(cell: cell) {
            if let indexPath = tableView.indexPath(for: cell) {
                config.command?.execute(indexPath)
            }
        }else {
            DDLogError("swipe button taped at index: \(index), but cell index not found")
//            config.command?.execute(nil)
        }
        return true;
    }
    
    public func swipeTableCell(_ cell: MGSwipeTableCell, didChange state: MGSwipeState, gestureIsActive: Bool) {
        
    }
    
    func tableViewForCell(cell: UITableViewCell) -> UITableView? {
        if cell.superview != nil {
            if cell.superview!.superview != nil && cell.superview!.superview is UITableView {
                return (cell.superview!.superview as! UITableView)
            }else {
                DDLogWarn("cell's super super view was not a tableview check it")
            }
        }else {
            DDLogWarn("cell's super view was nil")
        }
        return nil
    }
    
}
