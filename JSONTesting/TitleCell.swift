//
//  Cell.swift
//  JSONTesting
//
//  Created by Nicholas Kearns on 4/13/20.
//  Copyright © 2020 Nicholas Kearns. All rights reserved.
//

import UIKit


class TitleCell: UITableViewCell {
    
    static var identifier = "TitleCell"
    
    var title: String?
    
    var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        label.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        addSubview(label)
        
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
