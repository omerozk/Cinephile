//
//  MovieCollectionViewCell.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(movie: Movie) -> Void {
        movieImageView.image = nil
        movieImageView.kf.setImage(with: URL(string: movie.images.poster.thumb))
        movieTitleLabel.text = movie.title

    }
    
    class func identifier() -> String {
        return "MovieCVCell"
    }

}
