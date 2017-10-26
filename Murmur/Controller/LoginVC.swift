//
//  LoginVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
	
	// outlets
	@IBOutlet weak var email: UITextField! {
		didSet { setPlaceHolder(of: email, color: Colors.murmurPurplePlaceHolder) }
	}
	@IBOutlet weak var password: UITextField! {
		didSet { setPlaceHolder(of: password, color: Colors.murmurPurplePlaceHolder) }
	}
	@IBOutlet weak var spinner: UIActivityIndicatorView!

	// helper functions
	private func setPlaceHolder(of textField: UITextField, color: UIColor) {
		textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: color])
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		spinner.isHidden = true
	}

	// taget actions
	@IBAction func close(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
	@IBAction func signUp(_ sender: UIButton) { performSegue(withIdentifier: Segues.showCreatAccountVC, sender: nil) }
	
	@IBAction func login(_ sender: RoundedButton) {
		
		spinner.isHidden = false
		spinner.startAnimating()
		
		guard let email = email.text, self.email.text != "" else { return }
		guard let password = password.text, self.password.text != "" else { return }
		
		AuthService.instance.loginUser(email: email, password: password) { (success) in
			if success { print("user logged in!")
				AuthService.instance.findUserByEmail(completion: { (success) in
					if success { print("populating user data info...")
						NotificationCenter.default.post(name: NotificationName.userDataDidChange, object: nil)
						self.spinner.isHidden = true
						self.spinner.stopAnimating()
						self.dismiss(animated: true, completion: nil)
					}
				})
			}
		}
	}
}
