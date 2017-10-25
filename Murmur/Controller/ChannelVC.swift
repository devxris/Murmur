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
	@IBOutlet weak var userImage: CircleImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// SWRevealViewController built-in rear view width adjustment
		self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
		
		// listen to the Notification userDatDidChange
		NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NotificationName.userDataDidChange, object: nil)
	}
	
	// selector functions
	@objc func userDataDidChange(_ notification: Notification) {
		if AuthService.instance.isLoggedIn {
			loginButton.setTitle(UserDataService.instance.name, for: .normal)
			userImage.image = UIImage(named: UserDataService.instance.avatarName)
			userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
		} else {
			loginButton.setTitle("Login", for: .normal)
			userImage.image = UIImage(named: "menuProfileIcon")
			userImage.backgroundColor = .clear
		}
	}
	
	// target actions
	@IBAction func login(_ sender: UIButton) { performSegue(withIdentifier: Segues.showLoginVC, sender: nil) }
	
	// navigations
	@IBAction func unwindToChannelVC(segue: UIStoryboardSegue) { }
}
