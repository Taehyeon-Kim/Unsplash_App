//
//  DetailViewController.swift
//  Unsplash_API_Test
//
//  Created by taehy.k on 2021/02/14.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var downloadsCount: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var downloadCountLabel: UILabel!
    
    private var API_KEY: String!
    var fullImageURL: URL?
    var fullImageString: String!
    var photoID: String!
    var singlePhotoData: PhotoSingleResponse!
    var colors: [Color] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()

        fullImage.kf.setImage(with: fullImageURL)
        fetchSinglePhoto(photoID: photoID)
//        fetchPhotoColor(photoURL: fullImageString)
    }
    
    // MARK: - Custom Function
    func setupUI() {
        likeCountLabel.layer.cornerRadius = 16
        downloadCountLabel.layer.cornerRadius = 16
    }
    
    func setData(url: URL) {
        fullImageURL = url
    }
    
    // 단일 사진 정보 가져오기
    func fetchSinglePhoto(photoID: String) {
        fetchAPIKey()
        PhotoSingleService.shared.getSinglePhoto(clientID: API_KEY, id: photoID) { (result) -> (Void) in
            switch result {
            case .success(let data):
                if let response = data as? PhotoSingleResponse {
                    self.singlePhotoData = response
                    self.likesCount.text = String(self.singlePhotoData.likes)
                    self.downloadsCount.text = String(self.singlePhotoData.downloads)
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
    
    func fetchPhotoColor(photoURL: String) {
        PhotoColorPickService.shared.getPhotoColor(image_url: photoURL) { (result) -> (Void) in
            switch result {
            case .success(let data):
                if let response = data as? ColorResponse {
                    print("🔥 Color - \(response)")
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
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
        downloadImage(url: self.fullImageURL!)
    }
    
    @IBAction func colorButtonClicked(_ sender: Any) {
        let colorViewController = PhotoColorViewController(nibName: "PhotoColorViewController", bundle: nil)
        colorViewController.photoURLString = fullImageString
        self.present(colorViewController, animated: true, completion: nil)
    }
    
}
