//
//  CHTCollectionViewWaterfallCell.swift
//  PatientManagement
//
//  Created by TuoTuo on 2017/8/26.
//  Copyright © 2017年 TuoTuo. All rights reserved.
//

import UIKit

class CHTCollectionViewWaterfallCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(self.imageView)
    }
}
