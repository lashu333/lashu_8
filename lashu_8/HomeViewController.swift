//
//  HomeViewController.swift
//  lashu_8
//
//  Created by Lasha Tavberidze on 24.11.24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameView: UILabel!
    @IBOutlet weak var emailView: UILabel!
    @IBOutlet weak var phoneNumberView: UILabel!
    var user: Person?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setUp(){
        if let user = user{
            usernameView?.text? = user.username
            emailView?.text? = user.email
            phoneNumberView?.text? = user.phoneNumber
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
