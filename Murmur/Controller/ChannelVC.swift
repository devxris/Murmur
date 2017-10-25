//
//  ChannelVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
	
	// outlets
	@IBOutlet weak var loginButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// SWRevealViewController built-in rear view width adjustment
		self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
	}
	
	// target actions
	@IBAction func login(_ sender: UIButton) {
		performSegue(withIdentifier: Segues.showLoginVC, sender: nil)
	}
	
	// navigations
	@IBAction func unwindToChannelVC(segue: UIStoryboardSegue) {
		
	}
}
