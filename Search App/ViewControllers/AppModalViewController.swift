//
//  AppModalViewController.swift
//  Search App
//
//  Created by SE on 10/4/18.
//  Copyright © 2018 IT15049582_IT15060822. All rights reserved.
//

import UIKit

class AppModalViewController: UIViewController {

    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    func  setModal(AppDetails : App )  {
        self.appName.text = AppDetails.trackName
        self.ownerName.text = AppDetails.sellerName
        self.type.text = "App"
        self.genre.text = AppDetails.primaryGenreName
        self.price.layer.borderWidth = 1
        self.price.layer.cornerRadius = 5
        self.price.layer.borderColor = UIColor.green.cgColor
        self.price.text = AppDetails.formattedPrice
        let data = try? Data(contentsOf : URL(string: AppDetails.artworkUrl512)!)
        self.appImage.image = UIImage(data: data!)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalView.layer.cornerRadius = 10;
        self.appImage.layer.cornerRadius = 10
        showAnimate()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        removeAnimate()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view == view {
            removeAnimate()
        }
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParentViewController: nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        })
    }

}
