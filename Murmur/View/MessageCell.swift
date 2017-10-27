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
			// 2017-10-27T13:33:50Z for ISO8601 format
			// 2017-10-27T13:33:50.590Z for coming back timeStamp format
			guard var isoDate = message?.timeStamp else { return }
			let endIndex = isoDate.index(isoDate.endIndex, offsetBy: -5)
			isoDate = String(isoDate[..<endIndex])
			let isoDateFormatter = ISO8601DateFormatter()
			let chatDate = isoDateFormatter.date(from: isoDate.appending("Z"))
			let newFormatter = DateFormatter()
			newFormatter.dateFormat = "MMM d, h:mm a"
			if let finalDate = chatDate {
				let finalDate = newFormatter.string(from: finalDate)
				timeStamp.text = finalDate
			}
		}
	}
}
