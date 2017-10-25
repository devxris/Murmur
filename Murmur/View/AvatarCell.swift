//
//  AvatarCell.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
	@IBOutlet weak var avatar: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	private func setupView() {
		self.layer.backgroundColor = UIColor.lightGray.cgColor
		self.layer.cornerRadius = 10
		self.layer.masksToBounds = true
	}
}
