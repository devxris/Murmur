//
//  AddChannelVC.swift
//  Murmur
//
//  Created by Chris Huang on 26/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

	// outlets
	@IBOutlet weak var name: UITextField! {
		didSet { setPlaceHolder(of: name, color: Colors.murmurPurplePlaceHolder) }
	}
	@IBOutlet weak var desc: UITextField! {
		didSet { setPlaceHolder(of: desc, color: Colors.murmurPurplePlaceHolder) }
	}
	@IBOutlet weak var backgroundView: UIView! {
		didSet {
			let tap = UITapGestureRecognizer(target: self, action: #selector(closeTap))
			backgroundView.addGestureRecognizer(tap)
		}
	}
	
	// helper functions
	private func setPlaceHolder(of textField: UITextField, color: UIColor) {
		textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: color])
	}
	
	// selector functions
	@objc func closeTap() { dismiss(animated: true, completion: nil) }
	
	// taget actions
	@IBAction func close(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
	
	@IBAction func create(_ sender: RoundedButton) {
		
		guard let channelName = name.text, name.text != nil else { return }
		guard let channelDesc = desc.text, desc.text != nil else { return }
		
		// emit newChannel to SocketService
		SocketService.instance.addChannel(name: channelName, description: channelDesc) { (success) in
			if success { print("creating and emitting new channel...")
				self.dismiss(animated: true, completion: nil)
			}
		}
	}
}
