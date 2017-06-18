//
//  File.swift
//  MoveCinema
//
//  Created by Jax on 6/17/17.
//  Copyright © 2017 Jax. All rights reserved.
//

import Foundation
struct APIMove {
	static let Default = APIMove()
	let APIDataMove = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
	let APIImgMove = "https://image.tmdb.org/t/p/w342/"
	let APIImgMoveSlow = "https://image.tmdb.org/t/p/w45"
	let APIImgMoveHigh = "https://image.tmdb.org/t/p/original"
	let APITopRate = "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
	let APISearch = "https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1&include_adult=false&query="
	
	
}
