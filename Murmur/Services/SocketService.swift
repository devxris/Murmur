//
//  SocketService.swift
//  Murmur
//
//  Created by Chris Huang on 26/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
	
	override init() { super.init() } // for NSObject super.init
	
	static let instance = SocketService()

	// app send message to server API and "socket.emit" to all plateform
	// app listen "socket.on" to receive message from server API
	lazy var socket: SocketIOClient? = {
		guard let baseURL = URL(string: URLs.base) else { return nil }
		return SocketIOClient(socketURL: baseURL)
	}()
	
	// also initiate connection in AppDelegate applicationDidBecomeActive(_ application: UIApplication)
	func establishConnection() { socket?.connect() }
	func closeConnection() { socket?.disconnect() }
	
	// add and get channel
	func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
		socket?.emit("newChannel", name, description) // items must be in order
		completion(true)
	}
	
	func getChannels(completion: @escaping CompletionHandler) {
		socket?.on("channelCreated", callback: { (dataArray, acknowledge) in
			guard let channelName = dataArray[0] as? String else { return }
			guard let channelDesc = dataArray[1] as? String else { return }
			guard let channelId = dataArray[2] as? String else { return }
			let channel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: nil)
			MessageService.instance.channels.append(channel)
			completion(true)
		})
	}
	
	// add and get message
	func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
		let user = UserDataService.instance
		socket?.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
		completion(true)
	}
	
	func getMessage(completion: @escaping CompletionHandler) {
		socket?.on("messageCreated", callback: { (dataArray, acknowledge) in
			guard let messageBody = dataArray[0] as? String else { return }
			guard let _ = dataArray[1] as? String else { return } // "userId" not use this case
			guard let channelId = dataArray[2] as? String else { return }
			guard let userName = dataArray[3] as? String else { return }
			guard let userAvatar = dataArray[4] as? String else { return }
			guard let userAvatarColor = dataArray[5] as? String else { return }
			guard let id = dataArray[6] as? String else { return }
			guard let timeStamp = dataArray[7] as? String else { return }
			if channelId == MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
				let message = Message(_id: id, messageBody: messageBody, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp, __v: nil)
				MessageService.instance.messages.append(message)
				completion(true)
			} else {
				completion(false)
			}
		})
	}
	
	// other typing users indication
	func getOtherTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
		socket?.on("userTypingUpdate", callback: { (dataArray, acknowledge) in
			guard let typingUsers = dataArray[0] as? [String: String] else { return }
			completionHandler(typingUsers)
		})
	}
}
