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
	@IBOutlet weak var username: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var userImage: UIImageView!
	
	// variables
	var avatarName = "profileDefault"
	var avatarColor = "[0.5, 0.5, 0.5, 1]"
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if UserDataService.instance.avatarName != "" {
			userImage.image = UIImage(named: UserDataService.instance.avatarName)
			avatarName = UserDataService.instance.avatarName
		}
	}
	
	// target actions
	@IBAction func createAccount(_ sender: UIButton) {
		
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
								self.performSegue(withIdentifier: Segues.unwindToChannelVC, sender: nil)
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
	}
}
