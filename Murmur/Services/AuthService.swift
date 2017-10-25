//
//  AuthService.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation
import Alamofire

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
		
		// create header and body
		let header = ["Content-Type": "application/json; charset=utf-8"]
		let body: [String: Any] = ["email": email.lowercased(), "password": password]
		
		// create web request
		Alamofire.request(URLs.register, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
			if response.result.error == nil {
				completion(true)
			} else {
				completion(false)
				debugPrint(response.result.error as Any)
			}
		}
	}
}
