//
//  MovieTrailerViewController.swift
//  flix
//
//  Created by Tommyyu on 3/4/22.
//

import UIKit
import WebKit
class MovieTrailerViewController: UIViewController {
    var movie: [String:Any]!
    var videos =  [[String:Any]]()
    @IBOutlet weak var trailerWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let movie_id = movie["id"] as! Int64
        
        let url = URL(string:
                        "https://api.themoviedb.org/3/movie/\(movie_id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        print("https://api.themoviedb.org/3/movie/\(movie_id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                    print(dataDictionary)
                    self.videos = dataDictionary["results"] as! [[String:Any]]
                    for video in self.videos {
                        if ((video["site"] as! String == "YouTube") && video["official"] as! Bool){
                            let video_key = video["key"] as! String
                            let video_URL = URL(string:"https://www.youtube.com/watch?v=\(video_key)")
                            let myRequest = URLRequest(url: video_URL!)
                            self.trailerWebView.load(myRequest)
                            break
                        }
//                        print("\(video["key"] as! String),\(video["site"] as! String),\(video["official"] as! Bool)")
                    }
//                        self.videos =  dataDictionary["results"] as! [[String:Any]]
                 //                    print(self.videos)
//                    self.collectionView.reloadData()
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
        
        // Do any additional setup after loading the view.
             }
            
        }
        task.resume()
    

    }
    
}
