//
//  ProfileViewController.swift
//  iOS-api-test
//
//  Created by taehy.k on 2021/02/13.
//

import UIKit

import Kingfisher

class ProfileViewController: UIViewController {
    // MARK: Variables
    
    private var API_KEY: String = ""
    var userInfo: UserResponse!
    
    // MARK: - IBOutlets

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var totalPhotos: UILabel!
    @IBOutlet weak var totalLikes: UILabel!

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        getUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInfo()
    }
    
    // MARK: - Custom Function
    
    func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.profileImage.layer.cornerRadius = self.profileImage.layer.frame.width/2
    }
    
    func getUserInfo() {
        fetchAPIKey()
        UserInfoService.shared.getUserInfo(clientID: API_KEY, username: "taeeehyeon") { (result) -> (Void) in
            switch result {
            case .success(let data):
                if let response = data as? UserResponse {
                    self.userInfo = response
                }
                let url = URL(string: self.userInfo.profile_image.large)
                DispatchQueue.main.async {
                    self.profileImage.kf.setImage(with: url)
                    self.username.text = self.userInfo.username
                    self.bio.text = self.userInfo.bio
                    self.followersCount.text = String(self.userInfo.followers_count)
                    self.totalPhotos.text = String(self.userInfo.total_photos)
                    self.totalLikes.text = String(self.userInfo.total_likes)
                }
            case .requestErr(let msg):
                print(msg)
            case .pathErr:
                print("path Err")
            case .serverErr:
                print("server Err")
            case .networkFail:
                print("network Fail")
            }
        }
    }
    
    /// Info.plist에 있는 API_KEY값 가져오기
    func fetchAPIKey(){
        if let infoDic: [String:Any] = Bundle.main.infoDictionary {
            if let UNSPLASH_API_KEY = infoDic["UNSPLASH_API_KEY"] as? String {
                API_KEY = UNSPLASH_API_KEY
            }
        }
    }
}
