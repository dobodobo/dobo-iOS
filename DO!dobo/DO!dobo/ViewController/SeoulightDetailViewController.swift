//
//  SeoulightDetailViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher

class SeoulightDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBOutlet weak var placeImageSlide: ImageSlideshow!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    
    @IBOutlet weak var seoulightNameLabel: UILabel!
    @IBOutlet weak var seoulightCompanyLabel: UILabel!

//    let localSource = [ImageSource(imageString: "sad_cloud_dark.png")!, ImageSource(imageString: "sad_cloud.png")!, ImageSource(imageString: "powered-by-google-light.png")!, ImageSource(imageString: "powered-by-google-dark.png")!]
//    let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]

    let kingfisherSource = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self

        //ImageSlideShow
        placeImageSlide.slideshowInterval = 5.0
        placeImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        placeImageSlide.contentScaleMode = UIViewContentMode.scaleToFill
        
        placeImageSlide.currentPageChanged = { page in
            print("current page:", page)
        }
            
        placeImageSlide.setImageInputs(kingfisherSource)
            
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SeoulightDetailViewController.didTap))
            placeImageSlide.addGestureRecognizer(recognizer)
    
    }
    
    //MARK: ImageSlideShow
    @objc func didTap() {
        let fullScreenController = placeImageSlide.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    //TODO: 예약 상태 활성화 / 비활성화
    //MARK: 예약하기
    @IBAction func reservationAction(_ sender: UIButton) {
    }
    
    //TODO: 메일 보내기 연결
    //MARK: 문희하기
    @IBAction func mailAction(_ sender: UIButton) {
        
    }
    
    //TODO: 모달로 띄워서 리뷰 등록
    //MARK: 리뷰 등록하기
    @IBAction func reviewAction(_ sender: UIButton) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeoulightDetailReviewTableViewCell") as! SeoulightDetailReviewTableViewCell
        
        cell.nameLabel.text = "김예은"
        cell.dateLabel.text = "2018.09.20"
        cell.contentLabel.text = "정말 좋은 경험이었습니다."
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
