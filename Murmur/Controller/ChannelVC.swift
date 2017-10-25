//
//  ChannelVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// SWRevealViewController built-in rear view width adjustment
		self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
	}
}
