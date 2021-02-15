//
//  PhotoColorViewController.swift
//  Unsplash_API_Test
//
//  Created by taehy.k on 2021/02/15.
//

import UIKit

class PhotoColorViewController: UIViewController {
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    var photoURLString: String!
    var photoColors: [Color] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("😃 -- \(photoURLString)")
        setupCollectionView()
        fetchPhotoColor(photoURL: photoURLString)
        
    }
    
    func fetchPhotoColor(photoURL: String) {
        PhotoColorPickService.shared.getPhotoColor(image_url: photoURL) { (result) -> (Void) in
            switch result {
            case .success(let data):
                if let response = data as? ColorResponse {
//                    print("🔥 Color - \(response)")
                    self.photoColors = response.result.colors.image_colors
                    self.colorCollectionView.reloadData()
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
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PhotoColorViewController {
    func setupCollectionView() {
        colorCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        
        // 셀 등록
        colorCollectionView.register(UINib(nibName: "PhotoColorCVC", bundle: nil), forCellWithReuseIdentifier: PhotoColorCVC.identifier)
        
        // 콤포지셔널 레이아웃 등록
        colorCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 5, bottom: 5, trailing: 5)
            
            // 그룹 사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/8))
            
            // 그룹 사이즈로 그룹 만들기
            /// count는 subitem의 개수이다
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 15, leading: 10, bottom: 15, trailing: 10)
            return section
        }
        return layout
    }
}

extension PhotoColorViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoColors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoColorCVC.identifier, for: indexPath) as? PhotoColorCVC else { return UICollectionViewCell() }
        
        let r_val = CGFloat(self.photoColors[indexPath.row].r)
        let g_val = CGFloat(self.photoColors[indexPath.row].g)
        let b_val = CGFloat(self.photoColors[indexPath.row].b)
        let colorName = self.photoColors[indexPath.row].closest_palette_color
        
        cell.view.layer.cornerRadius = 14
        cell.view.backgroundColor = UIColor.rgb(red: r_val, green: g_val, blue: b_val)
        cell.colorName.text = "\(colorName) (R:\(r_val)·G:\(g_val)·B:\(b_val))"
        
        return cell
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
      }
}
