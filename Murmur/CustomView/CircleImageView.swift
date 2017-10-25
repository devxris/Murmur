//
//  CircleImageView.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {

	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	private func setupView() {
		self.layer.cornerRadius = self.frame.width / 2
		self.layer.masksToBounds = true
	}
}
