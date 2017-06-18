//
//  ViewController.swift
//  MoveCinema
//
//  Created by Jax on 6/17/17.
//  Copyright © 2017 Jax. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITabBarDelegate ,UISearchBarDelegate{
	@IBOutlet weak var tbvShowMove: UITableView!
	var url: URL?
	//@IBOutlet weak var btnCancel: UIButton!
	@IBOutlet weak var tabBarShow: UITabBar!
	var dataMove:[NSDictionary]!
	let refreshControl = UIRefreshControl()
	let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
	
	
	@IBOutlet weak var tbrTopRated: UITabBarItem!
	@IBOutlet weak var btnNowplaying: UITabBarItem!
	var searchTitleMove = UISearchBar()
	@IBOutlet weak var btnCancel: UIButton!
	
	let viewColor = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		searchTitleMove = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
		//searchTitleMove.showsCancelButton = true
		self.navigationItem.titleView = searchTitleMove
		searchTitleMove.placeholder = "Enter search your here!"
		tbvShowMove.delegate = self
		tbvShowMove.dataSource = self
		searchTitleMove.delegate = self
		if (self.tabBarController?.selectedIndex == 0)
		{
			self.url = URL(string: APIMove.Default.APIDataMove)
			waitting()
			LoadNetwork()
		}else if(self.tabBarController?.selectedIndex == 1){
			self.url = URL(string: APIMove.Default.APITopRate)
			waitting()
			LoadNetwork()
		}
		WaitingData()
		self.viewColor.backgroundColor = UIColor.darkGray
		//waitting()
		//LoadNetwork()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func WaitingData() {
		refreshControl.addTarget(self, action: #selector(ViewController.LoadNetwork), for: UIControlEvents.valueChanged)
		self.refreshControl.beginRefreshing()
		tbvShowMove.addSubview(refreshControl)
	}
	
	func waitting()  {
		let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
		loadingView.startAnimating()
		loadingView.center = tableFooterView.center
		tableFooterView.addSubview(loadingView)
		tbvShowMove.tableFooterView = tableFooterView
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchTitleMove.text! != "" {
			self.url = URL(string: APIMove.Default.APISearch + searchTitleMove.text!)
		}else{
			self.url = URL(string: APIMove.Default.APIDataMove)
		}
		waitting()
		LoadNetwork()
	}
	
	func LoadNetwork() {
		
		AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status: AFNetworkReachabilityStatus) -> Void in
			switch status {
			case .notReachable:
				let alertView: UIAlertView = UIAlertView(title: "SORRY", message: " Disconnect to internet", delegate: nil, cancelButtonTitle: "OK")
				alertView.show()
				break
			case .reachableViaWiFi, .reachableViaWWAN:
				
					LoadData.Default.fetchData(APIHelp: self.url, Complete:{ (result) in
						self.dataMove = result
						self.tbvShowMove.reloadData()
						self.refreshControl.endRefreshing()
						self.loadingView.stopAnimating()
						
					})
				//}
				break
				
			case .unknown:
				print("ERROR Internet")
			}
			
		}
		AFNetworkReachabilityManager.shared().startMonitoring()
	}
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let showVC = segue.destination as? ShowVC, let indexPath = tbvShowMove.indexPath(for: sender as! UITableViewCell) {
			showVC.urlImgBackground = (dataMove?[indexPath.row].value(forKeyPath: "poster_path") as? String)!
			showVC.titleMove = (dataMove?[indexPath.row].value(forKeyPath: "title") as? String)!
			showVC.vote = (dataMove?[indexPath.row].value(forKeyPath: "vote_count") as? Int)!
			showVC.dateRelease = (dataMove?[indexPath.row].value(forKeyPath: "release_date") as? String)!
			showVC.overview = (dataMove?[indexPath.row].value(forKeyPath: "overview") as? String)!

		}
	}

}






extension ViewController : UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if (dataMove != nil) {
			return dataMove.count
		}
		return 1
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		var imgAPI = String()
		let cell:CellMove = tbvShowMove.dequeueReusableCell(withIdentifier: "CellMove") as! CellMove
		cell.selectedBackgroundView = viewColor
		cell.lbTitle.text = dataMove?[indexPath.row].value(forKeyPath: "title") as? String
		cell.lbOverview.text = dataMove?[indexPath.row].value(forKeyPath: "overview") as? String
		
		if let urlString = dataMove?[indexPath.row].value(forKeyPath: "poster_path") as? String,
		let url = URL(string: imgAPI + urlString) {
			//cell.imgAvatarMove.setImageWith(url)
			
			let smallImageRequest = NSURLRequest(url: URL(string: APIMove.Default.APIImgMoveSlow + urlString)!)
			let largeImageRequest = NSURLRequest(url: URL(string: APIMove.Default.APIImgMoveHigh + urlString)!)
			
			cell.imgAvatarMove.setImageWith(
				smallImageRequest as URLRequest,
				placeholderImage: nil,
				success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
					
					// smallImageResponse will be nil if the smallImage is already available
					// in cache (might want to do something smarter in that case).
					cell.imgAvatarMove.alpha = 0.0
					cell.imgAvatarMove.image = smallImage;
					
					UIView.animate(withDuration: 0.3, animations: { () -> Void in
						
						cell.imgAvatarMove.alpha = 1.0
						
					}, completion: { (sucess) -> Void in
						
						// The AFNetworking ImageView Category only allows one request to be sent at a time
						// per ImageView. This code must be in the completion block.
			cell.imgAvatarMove.setImageWith(
				largeImageRequest as URLRequest,
				placeholderImage: smallImage,
				success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
								
								cell.imgAvatarMove.image = largeImage;
								
						},
							failure: { (request, response, error) -> Void in
								// do something for the failure condition of the large image request
								// possibly setting the ImageView's image to a default image
						})
					})
			},
				failure: { (request, response, error) -> Void in
					// do something for the failure condition
					// possibly try to get the large image
			})
		}
		return cell
	}
	

	
	
}

