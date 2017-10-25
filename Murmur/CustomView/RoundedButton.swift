//
//  RoundedButton.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

	@IBInspectable var cornerRadius: CGFloat = 3.0 { didSet { self.layer.cornerRadius = cornerRadius } }
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	private func setupView() {
		self.layer.cornerRadius = cornerRadius
	}
}
