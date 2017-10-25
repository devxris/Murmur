//
//  AvatarCell.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

enum AvatarType {
	case dark
	case light
}

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
	
	func configure(index: Int, type: AvatarType) {
		if type == .dark {
			avatar.image = UIImage(named: "dark\(index)")
			self.layer.backgroundColor = UIColor.lightGray.cgColor
		} else {
			avatar.image = UIImage(named: "light\(index)")
			self.layer.backgroundColor = UIColor.gray.cgColor
		}
	}
}
