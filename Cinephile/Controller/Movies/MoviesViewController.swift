//
//  MoviesViewController.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieCollectionView.register(R.nib.movieCollectionViewCell(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier())
        
        APIClient.sharedInstance.getUserDetails()
        APIClient.sharedInstance.getWeekBoxOfficeMovies(successBlock: { (movies) in
            self.movies = movies
            self.movieCollectionView.reloadData()
            
            }) { (error) in
                // TODO: display error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier(),
                                                      for: indexPath) as! MovieCollectionViewCell
        cell.config(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
}
