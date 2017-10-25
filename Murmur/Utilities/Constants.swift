//
//  Constatns.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// Segues
struct Segues {
	static let showLoginVC = "ShowLoginVC"
	static let showCreatAccountVC = "ShowCreateAccountVC"
	static let unwindToChannelVC = "UnwindToChannelVC"
}

// UserDefaults
struct DefaultKeys {
	static let token = "token"
	static let loggedIn = "loggedIn"
	static let userEmail = "userEmail"
}

// URL
struct URLs {
	static let base = "https://murmurchat.herokuapp.com/v1/"
	static let register = URLs.base + "account/register"
}
