//
//  MovieDetailsViewController.swift
//  flix
//
//  Created by Tommyyu on 3/4/22.
//

import UIKit
import AlamofireImage
class MovieDetailsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    var movie: [String:Any]!
    
    @IBOutlet weak var backdropView: UIImageView!
//    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        let layout = posterCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let width = posterCollectionView.bounds.width
        let height = posterCollectionView.bounds.height
        layout.itemSize = CGSize(width: width, height: height)
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath )
        backdropView.af_setImage(withURL: backdropUrl!)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCell", for: indexPath ) as! MoviePosterCell
        let baseurl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseurl + posterPath )
        cell.posterView.af_setImage(withURL: posterUrl!)
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = posterCollectionView.indexPath(for: cell)!
        let movie = movie
        // pass the selected movie to the details view controller
        let MovieTrailerViewController = segue.destination as! MovieTrailerViewController
        MovieTrailerViewController.movie = movie
//        tableView.deselectRow(at: indexPath, animated: true)
    }

}
