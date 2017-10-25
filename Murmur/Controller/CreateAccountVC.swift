//
//  CreateAccountVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
	
	// outlets
	@IBOutlet weak var username: UITextField! {
		didSet { setPlaceHolder(of: username, color: Colors.murmurPurplePlaceHolder) }
	}
	@IBOutlet weak var email: UITextField! {
		didSet { setPlaceHolder(of: email, color: Colors.murmurPurplePlaceHolder) }
	}
	@IBOutlet weak var password: UITextField! {
		didSet { setPlaceHolder(of: password, color: Colors.murmurPurplePlaceHolder)}
	}
	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	// helper functions
	private func setPlaceHolder(of textField: UITextField, color: UIColor) {
		textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: color])
	}
	
	// variables
	var avatarName = "profileDefault"
	var avatarColor = "[0.5, 0.5, 0.5, 1]"
	var avatarBackgroundColor: UIColor?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if UserDataService.instance.avatarName != "" {
			userImage.image = UIImage(named: UserDataService.instance.avatarName)
			avatarName = UserDataService.instance.avatarName
			if avatarName.contains("light") && avatarBackgroundColor == nil { userImage.backgroundColor = .lightGray }
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		spinner.isHidden = true
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(endEditTap))
		view.addGestureRecognizer(tap)
	}
	
	// selector functions
	@objc func endEditTap() { self.view.endEditing(true) }
	
	// target actions
	@IBAction func createAccount(_ sender: UIButton) {
		
		spinner.isHidden = false
		spinner.startAnimating()
		
		guard let username = username.text, self.username.text != "" else { return }
		guard let email = email.text, self.email.text != "" else { return }
		guard let password = password.text, self.password.text != "" else { return }
		
		// register -> login -> create user
		AuthService.instance.registerUser(email: email, password: password) { (success) in
			if success { print("User registered!")
				AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
					if success { print("User Logged in!")
						AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
							if success { print("User: \(UserDataService.instance.name) created!")
								// stop spinner
								self.spinner.isHidden = true
								self.spinner.stopAnimating()
								// unwind to channelVC
								self.performSegue(withIdentifier: Segues.unwindToChannelVC, sender: nil)
								// post notification after a new user is created
								NotificationCenter.default.post(name: NotificationName.userDataDidChange, object: nil)
							}
						})
					}
				})
			}
		}
	}
	
	@IBAction func close(_ sender: UIButton) { performSegue(withIdentifier: Segues.unwindToChannelVC, sender: nil) }
	@IBAction func pickAvatar(_ sender: UIButton) { performSegue(withIdentifier: Segues.showAvatarPicker, sender: nil) }
	@IBAction func pickAvatarColor(_ sender: UIButton) {
		let red = CGFloat(arc4random_uniform(255)) / 255
		let green = CGFloat(arc4random_uniform(255)) / 255
		let blue = CGFloat(arc4random_uniform(255)) / 255
		avatarBackgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
		UIView.animate(withDuration: 0.2) { self.userImage.backgroundColor = self.avatarBackgroundColor }
	}
}
