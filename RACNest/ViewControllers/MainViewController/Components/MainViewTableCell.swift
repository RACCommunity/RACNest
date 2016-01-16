//
//  MainViewTableCell.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

extension MainViewTableCell: Reusable {}

class MainViewTableCell: UITableViewCell {
    
    private let cellDescriptionLabel = UILabel(frame: CGRectZero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(cellDescriptionLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(presentable: TextPresentable) {
        
        cellDescriptionLabel.text = presentable.text
        cellDescriptionLabel.textColor = presentable.textColor
        accessoryType = .DisclosureIndicator
    }
    
    override func layoutSubviews() {
        let verticalPadding = 5
        let leftPadding = 16
        
        cellDescriptionLabel.frame = CGRect(x: leftPadding, y: verticalPadding, width: Int(CGRectGetWidth(contentView.frame)) - leftPadding, height: Int(CGRectGetHeight(contentView.frame)) - (verticalPadding * 2))
    }
}
