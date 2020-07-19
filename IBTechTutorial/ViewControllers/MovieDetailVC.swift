//
//  MovieDetailVC.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var posterImageViewHeightConstraint: NSLayoutConstraint!

    var movieDetail: MovieDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = movieDetail.originalTitle ?? ""
        
        let roundedWidth = Helper.roundScreenWidth(with: posterImageView.frame.width, .down)
        let constant = CGFloat(roundedWidth) * 1.5
        posterImageViewHeightConstraint.constant = constant
        
        if let posterPath = movieDetail.posterPath {
            let url = Constants.URLs.posterImageBaseUrl + String(roundedWidth) + posterPath

            posterImageView.loadImage(with: url, size: posterImageView.frame.size)
        }
        
        if let popularity = movieDetail.popularity {
            popularityLabel.text = "Popularity: \(popularity)"
        }
        if let voteAverage = movieDetail.voteAverage {
            voteAverageLabel.text = "Vote Average: \(voteAverage)"
        }
        
        if let overview = movieDetail.overview {
            descriptionLabel.text = overview
        }
        
        favoriteButton.image = Helper.isFavorite(with: movieDetail.id) ? UIImage(named: "starFilled") : UIImage(named: "star")

    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        guard let id = movieDetail.id else {return}
        
        if Helper.isFavorite(with: id) {
            Helper.removeFromFavorites(with: id)
        }else {
            Helper.addToFavorites(with: id)
        }
        
        favoriteButton.image = Helper.isFavorite(with: movieDetail.id) ? UIImage(named: "starFilled") : UIImage(named: "star")

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
