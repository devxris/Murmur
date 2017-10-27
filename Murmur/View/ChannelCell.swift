//
//  ChannelCell.swift
//  Murmur
//
//  Created by Chris Huang on 26/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

	@IBOutlet weak var name: UILabel!
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		self.layer.backgroundColor = selected ? UIColor(white: 1, alpha: 0.2).cgColor : UIColor.clear.cgColor
	}
	
	var channel: Channel? {
		didSet {
			name.text = "#\(channel?.name ?? "")"
			name.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
			
			for id in MessageService.instance.unreadChannels {
				if id == channel?._id {
					name.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
				}
			}
		}
	}
}
