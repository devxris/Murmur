//
//  CreateAccountVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

	// target actions
	@IBAction func close(_ sender: UIButton) { performSegue(withIdentifier: Segues.unwindToChannelVC, sender: nil) }
}
