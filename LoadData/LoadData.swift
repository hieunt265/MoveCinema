//
//  File.swift
//  MoveCinema
//
//  Created by Jax on 6/17/17.
//  Copyright © 2017 Jax. All rights reserved.
//

import Foundation
class LoadData {
	static let Default = LoadData()
	//var url: URL?
	//var dataMove = [String: String]()
	func fetchData(APIHelp: URL?, Complete: @escaping ([NSDictionary]?) -> () ) {
		if let url = APIHelp {
			let request = URLRequest(
				url: url,
				cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
				timeoutInterval: 100)
			let session = URLSession(
				configuration: URLSessionConfiguration.default,
				delegate: nil,
				delegateQueue: OperationQueue.main)
			let task = session.dataTask(
				with: request,
				completionHandler: { (dataOrNil, response, error) in
					if let data = dataOrNil {
						if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
							print("response: \(responseDictionary)")
							let dataMove = (responseDictionary["results"] as? [NSDictionary])!
							Complete(dataMove)
						}
					}
			})
			task.resume()
		}
	}
}
