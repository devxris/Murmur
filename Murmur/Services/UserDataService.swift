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
	
	func returnUIColor(components: String) -> UIColor {
		
		// convert string to numbers with Scanner
		let scanner = Scanner(string: components)
		// set skipped characters
		let skipped = CharacterSet(charactersIn: "[], ") // 4 characters
		let comma = CharacterSet(charactersIn: ",")
		// apply the rule to scanner
		scanner.charactersToBeSkipped = skipped
		
		// start to scan
		var r, g, b, a: NSString?
		scanner.scanUpToCharacters(from: comma, into: &r)
		scanner.scanUpToCharacters(from: comma, into: &g)
		scanner.scanUpToCharacters(from: comma, into: &b)
		scanner.scanUpToCharacters(from: comma, into: &a)
		
		// convert NSString -> Double -> CGFloat
		guard let red = r, let green = g, let blue = b, let alpha = a else { return .lightGray }
		let rFloat = CGFloat(red.doubleValue)
		let gFloat = CGFloat(green.doubleValue)
		let bFloat = CGFloat(blue.doubleValue)
		let aFloat = CGFloat(alpha.doubleValue)
		
		return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
	}
	
	func logoutUser() {
		_id = ""
		avatarColor = ""
		avatarName = ""
		name = ""
		email = ""
		AuthService.instance.isLoggedIn = false
		AuthService.instance.userEmail = ""
		AuthService.instance.authToken = ""
		MessageService.instance.clearChannels()
	}
}
