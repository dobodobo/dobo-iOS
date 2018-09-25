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
import SilentScrolly
import MessageUI


class SeoulightDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, SilentScrollable, MFMailComposeViewControllerDelegate {
    
    //imageslideshow
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //silentscrolly
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle(showStyle: .lightContent, hideStyle: .default)
    }

    var silentScrolly: SilentScrolly?
    
    @IBOutlet weak var placeImageSlide: ImageSlideshow!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minPeopleLabel: UILabel!
    @IBOutlet weak var maxPeopleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var reservationButton: UIButton!
    
    @IBOutlet weak var seoulightImageView: UIImageView!
    @IBOutlet weak var seoulightNameLabel: UILabel!
    @IBOutlet weak var seoulightCompanyLabel: UILabel!
    
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var langLabel: UILabel!
    
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreIconButton: UIButton!
    
    var idx: Int = 0
    var imgCount: Int = 0
    var status: String = ""
    var statusChk: Int = 0
    var resChk: Bool = false
    var seoulightDetails: SeoulightDetail?
    var reviewCnt: Int = 3
    
    var imageArr = [InputSource]()

    override func viewWillAppear(_ animated: Bool) {
        setResBtn()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seoulightDetailInit(idx: idx)
        
        setBackBtn(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
        
        //navigation bar
        tableView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        setNavigationBar()
        
        //imageView Circle
        seoulightImageView.layer.masksToBounds = true
        seoulightImageView.layer.cornerRadius = seoulightImageView.layer.frame.width/2
        seoulightImageView.layer.borderWidth = 2
        seoulightImageView.layer.borderColor = #colorLiteral(red: 0.537254902, green: 0.768627451, blue: 0.7647058824, alpha: 1)
        
        languageImageView.layer.masksToBounds = true
        languageImageView.layer.cornerRadius = 4

        //ImageSlideShow
        placeImageSlide.slideshowInterval = 5.0
        placeImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        placeImageSlide.contentScaleMode = UIViewContentMode.scaleToFill
        
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.4705882353, green: 0.7843137255, blue: 0.7764705882, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        placeImageSlide.pageIndicator = pageControl
        placeImageSlide.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 20), vertical: .bottom)
        
//        placeImageSlide.currentPageChanged = { page in
//            print("current page:", page)
//        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SeoulightDetailViewController.didTap))
            placeImageSlide.addGestureRecognizer(recognizer)
        
        //CollectionView
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
    
    //MARK: mail
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true)
    }
    
    //TODO: 해설자 이메일 넣기
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([gsno(seoulightDetails?.dobo.seoulite.email)]) //해설자 이메일 받기
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    //MARK: 예약 상태 활성화 / 비활성화 체크 함수
    func setResBtn() {
        print(status)
        print("dd\(resChk)")
        
        if status == "WAITING" { //진행 중
            
            if resChk == true { //예약함
                reservationButton.setImage(#imageLiteral(resourceName: "reservationBtn") ,for: .normal)
                statusChk = 3
            } else {
                reservationButton.setImage(#imageLiteral(resourceName: "rrr") ,for: .normal)
                statusChk = 1
            }
            
        } else { //마감
            
            if resChk == true { //예약함
                reservationButton.setImage(#imageLiteral(resourceName: "reservationBtn") ,for: .normal)
                statusChk = 3
            } else {
                reservationButton.setImage(#imageLiteral(resourceName: "finishedBtn") ,for: .normal)
                statusChk = 0
            }
        }
    }
    
    //MARK: 예약하기
    @IBAction func reservationAction(_ sender: UIButton) {
        if statusChk == 0 {
            noticeInfo("예약 마감", autoClear: true, autoClearTime: 1)
            
        } else if statusChk == 3{
            cancelSeoulight(idx: idx)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            bookSeoulight(idx: idx)
        }
    }
    
    //MARK: 서울라이트 예약하기 - POST
    func bookSeoulight(idx: Int) {
        SeoulightService.bookSeoulight(idx: idx) { (message) in
            
            if message == "success" {
                self.noticeSuccess("예약 완료", autoClear: true, autoClearTime: 1)
            } else {
                self.simpleAlert(title: "예약 실패", message: "다시 시도해주세요.")
            }
        }
    }
    
    //MARK: 서울라이트 예약 취소 - DELETE
    func cancelSeoulight(idx: Int) {
        SeoulightService.cancelSeoulight(idx: idx) { (message) in
            
            if message == "success" {
                self.noticeSuccess("예약 취소", autoClear: true, autoClearTime: 1)
            } else {
                self.simpleAlert(title: "취소 실패", message: "다시 시도해주세요.")
            }
        }
    }

    //MARK: 문의하기
    @IBAction func mailAction(_ sender: UIButton) {
        
        sendEmail()
        
    }
    
    //MARK: 서울라이트 리뷰 등록하기 팝업
    @IBAction func reviewAction(_ sender: UIButton) {
        let reviewPopUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeoulightReviewPopUpViewController") as! SeoulightReviewPopUpViewController
        
        reviewPopUp.idx = self.idx
        
        self.addChildViewController(reviewPopUp)
        reviewPopUp.view.frame = self.view.frame
        self.view.addSubview(reviewPopUp.view)
        
        reviewPopUp.didMove(toParentViewController: self)
    }
    
    //MARK: 서울라이트 상세보기 - GET
    func seoulightDetailInit(idx: Int) {
        SeoulightService.seoulightDetailInit(idx: idx) { (seoulightDetailData) in
            
            if seoulightDetailData.review?.count == 0 {
                self.moreIconButton.isHidden = true
                self.moreButton.setTitle("리뷰가 없습니다.", for: .normal)
                self.moreButton.isUserInteractionEnabled = false
            }
            
            self.status = seoulightDetailData.dobo.status
            self.resChk = seoulightDetailData.dobo.isReserved
            self.imgCount = seoulightDetailData.dobo.bgi.count
            self.titleLabel.text = seoulightDetailData.dobo.title
            self.dateLabel.text = seoulightDetailData.dobo.due_date
            self.timeLabel.text = seoulightDetailData.dobo.end_date
            self.minPeopleLabel.text = String(seoulightDetailData.dobo.min_people)
            self.maxPeopleLabel.text = String(seoulightDetailData.dobo.max_people)
            self.contentLabel.text = seoulightDetailData.dobo.content
            self.seoulightImageView.kf.setImage(with: URL(string: self.gsno(seoulightDetailData.dobo.seoulite.avatar)), placeholder: UIImage())
            self.seoulightNameLabel.text = seoulightDetailData.dobo.seoulite.name
            self.seoulightCompanyLabel.text = seoulightDetailData.dobo.seoulite.organization
            self.langLabel.text = seoulightDetailData.dobo.lang
            
            for i in 0 ..< self.imgCount {
                self.imageArr.append(KingfisherSource(urlString: seoulightDetailData.dobo.bgi[i])!)
                print(seoulightDetailData.dobo.bgi[i])
                
            }
            
            self.placeImageSlide.setImageInputs(self.imageArr)
            
            self.setResBtn()
            
            self.seoulightDetails = seoulightDetailData
            self.tableView.reloadData()
            self.courseCollectionView.reloadData()
        }
    }
    
    //MARK: TableView method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if gino(seoulightDetails?.review?.count) >= 3 {
            return reviewCnt
        } else {
            return gino(seoulightDetails?.review?.count)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeoulightDetailReviewTableViewCell") as! SeoulightDetailReviewTableViewCell
        
        cell.nameLabel.text = seoulightDetails?.review![indexPath.row].nick
        cell.dateLabel.text = seoulightDetails?.review![indexPath.row].created
        cell.contentLabel.text = seoulightDetails?.review![indexPath.row].content
        
        return cell
    }
    
    //MARK: 리뷰 더보기 액션
    @IBAction func moreReviewAcion(_ sender: UIButton) {
        if reviewCnt < gino(seoulightDetails?.review?.count) {
            print(reviewCnt)
            let num = gino(seoulightDetails?.review?.count) - reviewCnt
            
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
    
    //MARK: collectionView method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return gino(seoulightDetails?.dobo.course.count)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeoulightCourseCollectionViewCell", for: indexPath) as! SeoulightCourseCollectionViewCell
        
            //카테고리로 이미지 넣기
            cell.courseImageView.image = #imageLiteral(resourceName: "group16.png")
            cell.nameTextView.text = seoulightDetails?.dobo.course[indexPath.row].name
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

