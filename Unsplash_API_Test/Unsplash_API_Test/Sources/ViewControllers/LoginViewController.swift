//
//  LoginViewController.swift
//  Unsplash_API_Test
//
//  Created by taehy.k on 2021/02/15.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupUI() {
        loginButton.layer.cornerRadius = 12
    }
    
    // Ref: - https://javaexpert.tistory.com/671 / http://seorenn.blogspot.com/2015/12/ios.html
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print("Login Button Clicked")
        
        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
           else {
            print("loginWithKakaoAccount() success.")
            
            //do something
            _ = oauthToken
            
            //화면 전환
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let nextView = mainStoryboard.instantiateViewController(identifier: "TabBarController")
            self.navigationController?.pushViewController(nextView, animated: true)
            //self.present(nextView, animated: true, completion: nil)
           }
        }
    }

    
}
