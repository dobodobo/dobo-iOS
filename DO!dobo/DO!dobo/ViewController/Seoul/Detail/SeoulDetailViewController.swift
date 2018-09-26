//
//  SeoulDetailViewController.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher
import SilentScrolly

class SeoulDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, SilentScrollable {
    
    //imageslideshow
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //silentscrolly
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle(showStyle: .default, hideStyle: .default)
    }
    
    var silentScrolly: SilentScrolly?
    
    @IBOutlet weak var placeImageSlide: ImageSlideshow!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var reservationButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    @IBOutlet weak var moreIconButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    
    var idx: Int = 0
    var imgCount: Int = 0
    var seoulDetails: SeoulDetail?
    var reviewCnt: Int = 3
    
    var imageArr = [InputSource]()
    
    override func viewWillAppear(_ animated: Bool) {

        self.tableView.reloadData()
        self.courseCollectionView.reloadData()
        self.placeCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(idx)
        
        seoulDetailInit(idx: idx)
        setBackBtn(color: .white)
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self

        //navigation bar
        tableView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        setNavigationBar()
    
        //ImageSlideShow
        placeImageSlide.slideshowInterval = 5.0
        placeImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        placeImageSlide.contentScaleMode = UIViewContentMode.scaleToFill
        
//        let pageControl = UIPageControl()
//        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.4705882353, green: 0.7843137255, blue: 0.7764705882, alpha: 1)
//        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
//        placeImageSlide.pageIndicator = pageControl
//        placeImageSlide.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 20), vertical: .bottom)
        
//        placeImageSlide.currentPageChanged = { page in
//            print("current page:", page)
//        }
//
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SeoulightDetailViewController.didTap))
        placeImageSlide.addGestureRecognizer(recognizer)
        
        //collectionView
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        
    }
    
    //MARK: silentscrolly
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        silentDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSilentScrolly(tableView, followBottomView: tabBarController?.tabBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        silentWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        silentDidDisappear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        silentWillTranstion()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        silentDidScroll()
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        showNavigationBar()
        return true
    }
    
    //MARK: 네비게이션 바 투명하게 하는 함수
    func setNavigationBar() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
        
    }
    
    //MARK: ImageSlideShow
    @objc func didTap() {
        let fullScreenController = placeImageSlide.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    //MARK: 서울 예약하기 액션
    @IBAction func resAction(_ sender: UIButton) {
        
        let webVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulWebViewController") as! SeoulWebViewController
        
        webVC.cosUrl = gsno(seoulDetails?.dobo.cos_url)
        
        self.navigationController?.pushViewController(webVC, animated: true)
        
    }
    
    
    //MARK: TableView method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gino(seoulDetails?.review?.count) >= 3 {
            return reviewCnt
        } else {
            return gino(seoulDetails?.review?.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeoulDetailReviewTableViewCell") as! SeoulDetailReviewTableViewCell
        
        cell.nameLabel.text = seoulDetails?.review![indexPath.row].nick
        cell.dateLabel.text = seoulDetails?.review![indexPath.row].created
        cell.contentTextView.text = seoulDetails?.review![indexPath.row].content
        
        return cell
    }
    
    //MARK: 리뷰 더보기 액션
    @IBAction func moreReviewAcion(_ sender: UIButton) {
        if reviewCnt < gino(seoulDetails?.review?.count) {
            print(reviewCnt)
            let num = gino(seoulDetails?.review?.count) - reviewCnt
            
            if num % 3 >= 0 {
                
                if num >= 3 {
                    reviewCnt += 3
                    self.tableView.reloadData()
                } else {
                    reviewCnt += num
                    self.tableView.reloadData()
                }
            } else  {
                reviewCnt += num
                self.tableView.reloadData()
            }
            
        } else {
            noticeInfo("리뷰 없음", autoClear: true, autoClearTime: 1)
            
        }
    }
    
    //MARK: CollectionView method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == placeCollectionView {
                return gino(seoulDetails?.dobo.tourlist.count)
        } else {
            return gino(seoulDetails?.dobo.course!.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == placeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulPlaceCollectionViewCell", for: indexPath) as! SeoulPlaceCollectionViewCell
            
            cell.placeImageView.kf.setImage(with: URL(string: gsno(seoulDetails?.dobo.tourlist[indexPath.row].image)), placeholder: UIImage())
            cell.nameLabel.text = seoulDetails?.dobo.tourlist[indexPath.row].name
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulCourseCollectionViewCell", for: indexPath) as! SeoulCourseCollectionViewCell
            
            //TODO: 카테고리에 맞춰서 이미지 넣기
            cell.courseImageView.image = #imageLiteral(resourceName: "group16.png")
            cell.nameTextView.text = seoulDetails?.dobo.course![indexPath.row].name
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //TODO: 예약 상태 활성화 / 비활성화
    //MARK: 예약하기
    @IBAction func reservationAction(_ sender: UIButton) {
    }
 
    //MARK: 리뷰 등록하기
    @IBAction func reviewAction(_ sender: UIButton) {
        let reviewPopUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulReviewPopUpViewController") as! SeoulReviewPopUpViewController
        
        reviewPopUp.idx = self.idx
        
        self.addChildViewController(reviewPopUp)
        reviewPopUp.view.frame = self.view.frame
        self.view.addSubview(reviewPopUp.view)
        
        reviewPopUp.didMove(toParentViewController: self)
        
    }
    
    //MARK: 서울 상세보기 - GET
    func seoulDetailInit(idx: Int) {
        SeoulService.seoulDetailInit(idx: idx) { (seoulDetailData) in
            
            if seoulDetailData.review?.count == 0 {
                self.moreIconButton.isHidden = true
                self.moreButton.setTitle("리뷰가 없습니다.", for: .normal)
                self.moreButton.isUserInteractionEnabled = false
            }
        
            self.titleLabel.text = seoulDetailData.dobo.title
            self.contentTextView.text = seoulDetailData.dobo.content
    
            self.imageArr.append(KingfisherSource(urlString: seoulDetailData.dobo.image)!)
            self.placeImageSlide.setImageInputs(self.imageArr)
            
            self.seoulDetails = seoulDetailData
            self.tableView.reloadData()
            self.courseCollectionView.reloadData()
            self.placeCollectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


