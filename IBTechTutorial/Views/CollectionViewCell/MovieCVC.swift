//
//  MovieCVC.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import UIKit

class MovieCVC: UICollectionViewCell {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var movieTitleLabel: UILabel!

    var movieId: Int!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with movie: Movie) {
        movieId = movie.id
        movieTitleLabel.text = movie.title
        movieTitleLabel.textAlignment = .center
        favoriteButton.setImage(Helper.isFavorite(with: movieId) ? UIImage(named: "starFilled") : UIImage(named: "star"), for: .normal)
        loadPosterImage(with: movie.posterPath)
    }
    
    private func loadPosterImage(with posterPath: String) {
        let roundedWidth = Helper.roundScreenWidth(with: self.frame.width)
        let url = Constants.URLs.posterImageBaseUrl + String(roundedWidth) + posterPath
        
        movieImageView.loadImage(with: url, size: CGSize(width: self.frame.width, height: (self.frame.width * 1.5)))
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        guard let id = movieId else {return}
        
        if Helper.isFavorite(with: id) {
            Helper.removeFromFavorites(with: id)
        }else {
            Helper.addToFavorites(with: id)
        }
    }

}
