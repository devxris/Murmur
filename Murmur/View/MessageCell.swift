//
//  MessageCell.swift
//  Murmur
//
//  Created by Chris Huang on 26/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

	@IBOutlet weak var userImage: CircleImageView!
	@IBOutlet weak var username: UILabel!
	@IBOutlet weak var timeStamp: UILabel!
	@IBOutlet weak var messageBody: UILabel!
	
	var message: Message? {
		didSet {
			messageBody.text = message?.messageBody
			username.text = message?.userName
			userImage.image = UIImage(named: message?.userAvatar ?? "")
			userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message?.userAvatarColor ?? "")
			// left timestapm here
		}
	}
}
