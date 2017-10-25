//
//  AuthService.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
	
	static let instance = AuthService()
	
	let defaults = UserDefaults.standard
	
	var isLoggedIn: Bool {
		get { return defaults.bool(forKey: DefaultKeys.loggedIn) }
		set { defaults.set(newValue, forKey: DefaultKeys.loggedIn) }
	}
	
	var authToken: String {
		get { return defaults.value(forKey: DefaultKeys.token) as! String }
		set { defaults.set(newValue, forKey: DefaultKeys.token) }
	}
	
	var userEmail: String {
		get { return defaults.value(forKey: DefaultKeys.userEmail) as! String }
		set { defaults.set(newValue, forKey: DefaultKeys.userEmail) }
	}
	
	func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
		
		// create body
		let body: [String: Any] = ["email": email.lowercased(), "password": password]
		
		// create register web request
		Alamofire.request(URLs.register, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header.normal).responseString { (response) in
			if response.result.error == nil {
				completion(true)
			} else {
				completion(false); debugPrint(response.result.error as Any)
			}
		}
	}
	
	func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
		
		// create body
		let body: [String: Any] = ["email": email.lowercased(), "password": password]

		// create login web request
		Alamofire.request(URLs.login, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header.normal).responseJSON { (response) in
			if response.result.error == nil {
				
				/* parse json with Dictionary
				if let json = response.result.value as? [String: Any] {
					if let email = json["user"] as? String { self.userEmail = email }
					if let token = json["token"] as? String { self.authToken = token }
				} */
				
				// parse json with SwiftyJSON
				guard let data = response.data else { return }
				let json = JSON(data: data)
				self.userEmail = json["user"].stringValue // auto unwrap optional
				self.authToken = json["token"].stringValue // auto unwrap optional
				
				self.isLoggedIn = true
				completion(true)
			} else {
				completion(false); debugPrint(response.result.error as Any)
			}
		}
	}
}
