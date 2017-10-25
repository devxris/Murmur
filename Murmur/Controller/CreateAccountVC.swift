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
	
	// target actions
	@IBAction func createAccount(_ sender: UIButton) {
		
		guard let email = email.text, self.email.text != "" else { return }
		guard let password = password.text, self.password.text != "" else { return }
		
		AuthService.instance.registerUser(email: email, password: password) { (success) in
			if success { print("User registered!") }
		}
	}
	
	@IBAction func pickAvatar(_ sender: UIButton) {
	}
	
	@IBAction func pickAvatarColor(_ sender: UIButton) {
	}
	
	@IBAction func close(_ sender: UIButton) { performSegue(withIdentifier: Segues.unwindToChannelVC, sender: nil) }
}
