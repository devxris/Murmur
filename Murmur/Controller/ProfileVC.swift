//
//  ProfileVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

	// outlets
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var userEmail: UILabel!
	@IBOutlet weak var backgoundView: UIView! {
		didSet {
			let tap = UITapGestureRecognizer(target: self, action: #selector(closeTap))
			backgoundView.addGestureRecognizer(tap)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	// helper functions
	func setupView() {
		userName.text = UserDataService.instance.name
		userEmail.text = UserDataService.instance.email
		profileImage.image = UIImage(named: UserDataService.instance.avatarName)
		profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
	}
	
	// selector functions
	@objc func closeTap() { dismiss(animated: true, completion: nil) }
	
	
	// target actions
	@IBAction func logout(_ sender: UIButton) {
		UserDataService.instance.logoutUser()
		NotificationCenter.default.post(name: NotificationName.userDataDidChange, object: nil)
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func close(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
}
