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
	static let showAvatarPicker = "ShowAvatarPicker"
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
	static let login = URLs.base + "account/login"
	static let addUser = URLs.base + "user/add"
	static let findUserByEmail = URLs.base + "user/byEmail/" // + email address
	static let getChannels = URLs.base + "channel"
	static let getMessages = URLs.base + "message/byChannel/" // + channel id
}

// Headers
struct Header {
	static let normal = ["Content-Type": "application/json; charset=utf-8"]
	static let bearer = [ "Authorization": "Bearer " + AuthService.instance.authToken,
	                      "Content-Type": "application/json; charset=utf-8"]
}

// Colors
struct Colors {
	static let murmurPurplePlaceHolder = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)
}

// Notifications
struct NotificationName {
	static let userDataDidChange = Notification.Name("notificationUserDataDidChange")
	static let channelsDidLoad = Notification.Name("notificationChannelsDidLoad")
	static let channelDidSelect = Notification.Name("notificationChannelDidSelect")
}
