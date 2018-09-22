//
//  MyPageTableViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 20..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import Kingfisher

class MyPageTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myPages: MyPage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Initialization code
    }
    
    //MARK: 마이페이지 조회 - GET
    func myPageInit() {
        MyPageService.myPageInit{ (myPage) in
            self.myPages = myPage
            self.collectionView.reloadData()

        }
    }
    
    //MARK: CollectionView method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if tag == 0 { //신청 리스트
            
            if gino(myPages?.askTourList.count) == 0 {
                return 1
            } else {
                return gino(myPages?.askTourList.count)
            }
        } else { //개설 리스트
            if gino(myPages?.askTourList.count) == 0 {
                return 1
            } else {
                return gino(myPages?.madeTourList.count)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if tag == 0 { //신청 리스트
            
            if let cell : MyPageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCollectionViewCell", for: indexPath) as? MyPageCollectionViewCell {
                
                if gino(myPages?.askTourList.count) == 0 { //기본 이미지 설정
                    cell.placeImageView.image = #imageLiteral(resourceName: "loginFullGraphic")
                    cell.nameLabel.text = ""
                } else {
                    cell.placeImageView.kf.setImage(with: URL(string: gsno(myPages?.askTourList[indexPath.row].image)), placeholder: UIImage())
                    cell.nameLabel.text = myPages?.askTourList[indexPath.row].title
                }

                return cell
            }
            return UICollectionViewCell()
        } else { //개설 리스트
            
            if let cell : MyPageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCollectionViewCell", for: indexPath) as? MyPageCollectionViewCell {
            
                
                if gino(myPages?.madeTourList.count) == 0 { //기본 이미지 설정
                    cell.placeImageView.image = #imageLiteral(resourceName: "loginFullGraphic")
                    cell.nameLabel.text = ""
                } else {
                    cell.placeImageView.kf.setImage(with: URL(string: gsno(myPages?.madeTourList[indexPath.row].image)), placeholder: UIImage())
                    cell.nameLabel.text = myPages?.madeTourList[indexPath.row].title
                }
                
                return cell
            }
            return UICollectionViewCell()
        }
    }
}
