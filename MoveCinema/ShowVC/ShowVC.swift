//
//  ShowVC.swift
//  MoveCinema
//
//  Created by Jax on 6/17/17.
//  Copyright © 2017 Jax. All rights reserved.
//

import UIKit

class ShowVC: UIViewController {
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var lbVote: UILabel!
	@IBOutlet weak var lbDateRelease: UILabel!
	
	@IBOutlet weak var lbOverview: UILabel!
	
	@IBOutlet weak var imageBackground: UIImageView!
	@IBOutlet weak var scrollViewOverview: UIScrollView!
	@IBOutlet weak var infoView: UIView!
	
	var urlImgBackground = String()
	var titleMove = String()
	var vote = Int()
	var dateRelease = String()
	var overview = String()
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.isNavigationBarHidden = false
		self.imageBackground.setImageWith(URL(string: APIMove.Default.APIImgMove + urlImgBackground)!)
		
		
		self.scrollViewOverview.contentSize = CGSize(width: self.scrollViewOverview.frame.size.width,height: self.infoView.frame.origin.y + self.infoView.frame.height)
		self.navigationController?.title = "MovieCinema"
		self.lbTitle.text = titleMove
		self.lbVote.text = "Vote : " + String(format : "%i", vote)
		self.lbDateRelease.text = "Release Date : " + dateRelease
		self.lbOverview.text = overview
		self.lbTitle.sizeToFit()
		self.lbVote.sizeToFit()
		self.lbDateRelease.sizeToFit()
		self.lbOverview.sizeToFit()
		self.infoView.sizeToFit()
		self.scrollViewOverview.sizeToFit()
		self.scrollViewOverview.reloadInputViews()
		
        // Do any additional setup after loading the view.
    }
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
