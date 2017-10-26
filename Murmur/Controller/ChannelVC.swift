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
	@IBOutlet weak var channelTable: UITableView! {
		didSet {
			channelTable.dataSource = self
			channelTable.delegate = self
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// SWRevealViewController built-in rear view width adjustment
		self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
		
		// listen to the Notification userDatDidChange
		NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NotificationName.userDataDidChange, object: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		setupUserInfo()
	}
	
	// selector functions
	@objc func userDataDidChange(_ notification: Notification) { setupUserInfo() }
	
	// helper functions
	private func setupUserInfo() {
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
	@IBAction func login(_ sender: UIButton) {
		if AuthService.instance.isLoggedIn { // show ProfileVC
			let profileVC = ProfileVC()
			profileVC.modalPresentationStyle = .custom
			present(profileVC, animated: true, completion: nil)
		} else { // show LoginVC
			performSegue(withIdentifier: Segues.showLoginVC, sender: nil)
		}
	}
	
	@IBAction func addChannel(_ sender: UIButton) {
		if AuthService.instance.isLoggedIn {
			let addChannelVC = AddChannelVC()
			addChannelVC.modalPresentationStyle = .custom
			present(addChannelVC, animated: true, completion: nil)
		}
	}
	
	// navigations
	@IBAction func unwindToChannelVC(segue: UIStoryboardSegue) { }
}

extension ChannelVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageService.instance.channels.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChannelCell
		cell.channel = MessageService.instance.channels[indexPath.row]
		return cell
	}
}
