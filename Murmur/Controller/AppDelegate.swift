//
//  AppDelegate.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		SocketService.instance.establishConnection()
	}

	func applicationWillTerminate(_ application: UIApplication) {
		SocketService.instance.closeConnection()
	}
}
