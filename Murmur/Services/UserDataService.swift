//
//  UserDataService.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

class UserDataService {
	
	static let instance = UserDataService()
	
	// corosponding to send back JSON objects
	public private(set) var _id = ""
	public private(set) var avatarColor = ""
	public private(set) var avatarName = ""
	public private(set) var email = ""
	public private(set) var name = ""
	
	func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
		self._id = id
		self.avatarColor = avatarColor
		self.avatarName = avatarName
		self.email = email
		self.name = name
	}

	func setAvatarName(_ to: String) { self.avatarName = to }
}
