//
//  DetailViewController.swift
//  RestaurantFinder
//
//  Created by Zert Interactive on 5/13/17.
//  Copyright © 2017 Zert Interactive. All rights reserved.
//

import UIKit
import Cosmos

class DetailViewController: UIViewController {

    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var location: UILabel!
   
    @IBOutlet weak var phone: UILabel!
    
    var viewModel : RestaurantViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
       
            ratingView.settings.fillMode = .half
            ratingView.settings.starSize = 20.0
            ratingView.rating = (viewModel?.rating)!
            ratingView.text = viewModel?.formattedReview
        
            self.title = viewModel?.name
            categories.text = viewModel?.categories
            resName.text = viewModel?.name
            location.text = viewModel?.locatinString
            phone.text = viewModel?.phone
        
        activityIndicator.hidesWhenStopped=true
        activityIndicator.startAnimating()
        
            viewModel?.downloadImageWith(){ [weak self] image in
                
                self?.activityIndicator.stopAnimating()
                UIView.animate(withDuration: 1, animations: { 
                    self?.resImage.image = image

                })
                
            }
       
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

