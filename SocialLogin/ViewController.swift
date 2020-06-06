//
//  ViewController.swift
//  SocialLogin
//
//  Created by Cong Le on 6/5/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit
import OAuthSwift
//import FBSDKCoreKit
import FBSDKLoginKit // for FBLoginButton()


class ViewController: UIViewController {
    
    // create an instance and retain it
    let oauthswift = OAuth2Swift(
        consumerKey:    "269708180900028",
        consumerSecret: "324846e234596518cc5450f57dc71582",
        authorizeUrl:   "https://api.instagram.com/oauth/authorize",
        responseType:   "token"
    )
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        // Facebook login button
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.permissions = ["public_profile", "email"]
        
        // get assess token from Facebook and check the current status
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        print("Toke to access Facebook is \(token)")
        }
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        oauthswift.allowMissingStateCheck = true
        // open the Safari inside the app
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
        let handle = oauthswift.authorize(
            withCallbackURL: "oauth-swift://oauth-callback/instagram",
            scope: "likes+comments", state:"INSTAGRAM") { result in
                switch result {
                case .success(let (credential, response, parameters)):
                    print(credential.oauthToken)
                    // Do your request
                    print("Printitng the parameters: \(parameters)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
        
    }
}

