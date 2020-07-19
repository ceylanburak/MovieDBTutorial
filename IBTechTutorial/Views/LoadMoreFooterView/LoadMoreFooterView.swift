//
//  LoadMoreFooterView.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 19.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import UIKit

class LoadMoreFooterView: UICollectionReusableView {

    typealias LoadMoreActionHandler = () -> Void
    @IBOutlet var loadMoreButton: UIButton!
    private var actionHandler: LoadMoreActionHandler!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setLoadMoreAction(with handler: @escaping LoadMoreActionHandler) {
        self.actionHandler = handler
    }
    
    @IBAction func loadMoreAction(sender: AnyObject) {
        self.actionHandler()
    }

}
