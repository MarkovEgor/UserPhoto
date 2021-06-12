//
//  PhotoCollectionViewController.swift
//  UserPhoto
//
//  Created by Egor Markov on 6/11/21.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    // MARK: - Property
    
    var idUser: Int?
    var albumUser: [AlbumUser] = []
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fechLodingData()
    }
    
    
    // MARK: - Func
    func fechLodingData() {
        guard let id = idUser else { return }
        NetWorkService.shared.fetchApiUserAlbum(idUser: id, completion: { albumResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let album = albumResult else {return}
            
            DispatchQueue.main.async {
                
                f1: for photo in album {
                    self.albumUser.append(photo)
                    if self.albumUser.count == 5 {
                        break f1
                    }
                }
                self.collectionView.reloadData()
            }
        })
    }
    
    
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return albumUser.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        cell.album = albumUser[indexPath.row]
        
        return cell
    }
    
}

// MARK: - Extension

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20 , height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 30, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}



