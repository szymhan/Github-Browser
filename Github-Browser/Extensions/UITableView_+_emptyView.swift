//
//  UITableView_+_emptyView.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 15/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SnapKit

extension UITableView {
    
    func setEmptyView(title: String, message: String) {
        let emptyImageView: UIImageView = {
           let imageView            = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            imageView.image         = UIImage(named: "empty")
            imageView.contentMode   = .scaleAspectFit
            return imageView
        }()
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel      = UILabel()
        let messageLabel    = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor    = UIColor.black
        titleLabel.font         = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor  = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(emptyImageView)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(emptyView)
        }
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(20)
            make.width.equalTo(emptyView).multipliedBy(0.4)
            make.centerX.equalTo(emptyView)
        }
        emptyImageView.snp.makeConstraints { (make) in
            make.width.equalTo(emptyView).multipliedBy(0.3)
            make.height.equalTo(emptyImageView.snp_width)
            make.bottom.equalTo(titleLabel.snp_top).offset(-10)
            make.centerX.equalTo(titleLabel)
        }
        titleLabel.text             = title
        messageLabel.text           = message
        messageLabel.numberOfLines  = 0
        messageLabel.textAlignment  = .center
        // The only tricky part is here:
        self.backgroundView         = emptyView
        self.separatorStyle         = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

