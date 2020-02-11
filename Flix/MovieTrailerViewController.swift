//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Cicely Beckford on 2/10/20.
//  Copyright © 2020 Cicely Beckford. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieId = movie["id"] as! Int
        
        let url = URL(string:
           "https://api.themoviedb.org/3/movie/" + String(movieId) + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let result = dataDictionary["results"] as! [[String:Any]]
                let movieKey = result[0]["key"] as! String
                
                let trailerURL = URL(string:"https://www.youtube.com/watch?v=" + movieKey)
                let trailerRequest = URLRequest(url: trailerURL!)
                
                self.webView.load(trailerRequest)
            }
        }
        task.resume()
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
