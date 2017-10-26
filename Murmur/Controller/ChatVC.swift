//
//  ChatVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

	// outlets
	@IBOutlet weak var channelLabel: UILabel!
	@IBOutlet weak var menuButton: UIButton! {
		didSet {
			// SWRevealViewController built-in toggle action for rear and front viewControllers
			menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// SWRevealViewController built-in slide back(pan) and tap back gestures
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
		// listen to the Notification userDatDidChange
		NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NotificationName.userDataDidChange, object: nil)
		// listen to the Notification channelDidSelect
		NotificationCenter.default.addObserver(self, selector: #selector(channelDidSelect(_:)), name: NotificationName.channelDidSelect, object: nil)
		
		// check previous user logged in or not
		if AuthService.instance.isLoggedIn {
			AuthService.instance.findUserByEmail(completion: { (success) in
				if success { print("previous user logged in!"); print("populating user data...")
					NotificationCenter.default.post(name: NotificationName.userDataDidChange, object: nil)
				}
			})
		}
	}
	
	// helper functions
	func onLoginGetMessages() {
		MessageService.instance.findAllChannels { (success) in
			if success { print("loading all channels...")
				
			}
		}
	}
	
	func updateWithSelectedChannel() {
		print("updating channel...")
		channelLabel.text = "#\(MessageService.instance.selectedChannel?.name ?? "")"
	}
	
	// selector functions
	@objc func userDataDidChange(_ notification: Notification) {
		if AuthService.instance.isLoggedIn {
			onLoginGetMessages() // get channels
		} else {
			channelLabel.text = "Please Log In"
		}
	}
	
	@objc func channelDidSelect(_ notification: Notification) {
		updateWithSelectedChannel()
	}
}
