//
//  MovieDetailControllerA.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/10/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class MovieDetailControllerA: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var movie: Movie?
    var movieDetail: MovieDetail? {
        didSet {
            guard let movieImage = movieDetail?.image else {return}
            guard let audiences = movieDetail?.audience else {return}
            guard let actor = movieDetail?.actor else {return}
            guard let userRating = movieDetail?.userRating else {return}
            guard let grade = movieDetail?.grade else {return}
            guard let genre = movieDetail?.genre else {return}
            guard let movieTitle = movieDetail?.title else {return}
            guard let movieDuration = movieDetail?.duration else {return}
            guard let movieSynopsis = movieDetail?.synopsis else {return}
            guard let director = movieDetail?.director else {return}
            guard let openDate = movieDetail?.date else {return}
            guard let reservationRate = movieDetail?.reservationRate else {return}
            guard let reservationGrade = movieDetail?.reservationGrade else {return}
            
            guard let formattedAduiendces = Tools.shared.convertingAudiences(audiences: audiences) else {return}
            guard let ratingStarImage = Tools.shared.printRatingStarImage(userRating: userRating) else {return}
            guard let numberMarkImage = Tools.shared.printMovieGrade(movieGrade: grade) else {return}
            
            DispatchQueue.main.async {
                self.movieTumbImageView.loadImage(urlString: movieImage)
                self.movieTitleLabel.text = "\(movieTitle)"
                self.openDateLabel.text = "\(openDate) 개봉"
                self.genreAndDurationLabel.text = "\(genre)/\(movieDuration)분"
                self.reservationRateAndGradeLabel.text = "\(reservationGrade)위 \(reservationRate)%"
                self.userRatingLabel.text = "\(userRating)"
                self.ratingStarsImageView.image = ratingStarImage
                self.audienceLabel.text = "\(formattedAduiendces)"
                
                self.synopsisTextView.text = "\(movieSynopsis)"
                self.actorLabel.text = "\(actor)"
                self.directorLabel.text = "\(director)"
                
                self.gradeImageView.image = numberMarkImage
            }
            
        }
    }
    var movieComments: MovieComments?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    //MARK: 영화상세보기 뷰
    let movieDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let reservationRateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "예매율"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reservationRateAndGradeLabel: UILabel = {
        let label = UILabel()
        label.text = "1위 35.5&"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userRatingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "7.98"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingStarsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FourStarAndHalf@2x.png")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let audienceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "누적관객수"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.text = "11,878,823"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieTumbImageView: CustomImageView = {
        let imageview = CustomImageView()
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gradeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let openDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2017-12-20 개봉"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreAndDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "판타지, 드라마/139분"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftEvaluateSperateView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        return uiView
    }()
    
    let rightEvaluateSperateView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        return uiView
    }()
    
    //MARK: - 영화상세보기 뷰 와 줄거리뷰 나눔 뷰
    let seperateViewSynopsis: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        return uiView
    }()
    
    //MARK: - 줄거리뷰
    let synopsisView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let synopsisTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "줄거리"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let synopsisTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = "인류의 수호자인 슈퍼맨이 사라진 틈을 노리고 ‘마더박스’를 차지하기 위해 빌런 스테픈울프가 악마군단을 이끌고 지구에 온다. 마더박스는 시간과 공간, 에너지, 중력을 통제하는 범우주적인 능력으로 행성의 파괴마저도 초래하는 물체로 이 강력한 힘을 통제하기 위해 고대부터 총 3개로 분리되어 보관되고 있던 "
        textView.textColor = .black
        textView.becomeFirstResponder()
        return textView
    }()
    
    //MARK: - 줄거리 뷰와 감독/배우 뷰 분리 뷰
    let seperateViewDirectorAndActorLabel: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        return uiView
    }()
    
    //MARK: - 감독/배우 뷰
    let directorAndActorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let directorAndActorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "감독/출연"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "감독"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.text = "마동석(마석도)"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출연"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.text = "마동석(마석도), 윤계상(장첸)"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - 감독/배우 뷰 와 댓글 테이블 뷰 분리뷰
    let seperateViewCommentTable: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        return uiView
    }()
    
    let cellId = "CommentCell"
    
    //MARK: - 댓글 테이블 뷰
    let coverTableView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var commentsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.isScrollEnabled = false
        tv.bounces = false
        tv.register(MovieCommentTableCell.self, forCellReuseIdentifier: self.cellId)
        return tv
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupScrollView()
        fetchMovieDetailFromJSON()
        fetchMovieCommentsJSON()
        
        //1.영화 상세정보 뷰
        setupMovieDetailView()
        //영화 상세정보 뷰와 줄거리 뷰와 분리 뷰
        contentView.addSubview(seperateViewSynopsis)
        seperateViewSynopsis.anchor(top: movieDetailView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 10)
        
        //2.영화 줄거리 뷰
        setupSynopsisView()
        //영화 줄거리 뷰 와 감독/출연 소개 분리 뷰
        contentView.addSubview(seperateViewDirectorAndActorLabel)
        seperateViewDirectorAndActorLabel.anchor(top: synopsisView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 10)
        
        //3.영화 감독/출연 소개 뷰
        setupDirectorAndActorView()
        //감독/출연 소개 뷰 와 테이블 뷰 분리 뷰
        contentView.addSubview(seperateViewCommentTable)
        seperateViewCommentTable.anchor(top: directorAndActorView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 10)
        
        //4.댓글 테이블 뷰
        setupTableView()
    }
    
    //MARK: - MovieDetail JSON 통신
    fileprivate func fetchMovieDetailFromJSON() {
        guard let movieId = movie?.id else {return}
        
        let urlString = "http://connect-boxoffice.run.goorm.io/movie?id=\(movieId)"
        
        guard let url = URL(string: urlString) else {return}
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                self.movieDetail = try decoder.decode(MovieDetail.self, from: data)
            } catch let jsonErr {
                print("Failed to parsing json \(jsonErr)")
                self.movieDetailJsonErrAlet()
            }
            
            }.resume()
    }
    
    //MovieDetail JSON 통신 실패 알람
    func movieDetailJsonErrAlet() {
        let alert = UIAlertController(title: "JSON Error", message: "데이터를 수신하지 못하였습니다. 인터넷 연결을 확인후 다시 시도해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "재연결", style: .default, handler: { (_) in
            self.fetchMovieDetailFromJSON()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - MovieComments JSON 통신
    fileprivate func fetchMovieCommentsJSON() {
        guard let movieId = movie?.id else {return}
        
        let urlString = "http://connect-boxoffice.run.goorm.io/comments?movie?id=\(movieId)"
        
        guard let url = URL(string: urlString) else {return}
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                self.movieComments = try decoder.decode(MovieComments.self, from: data)
                DispatchQueue.main.async {
                    self.commentsTableView.reloadData()
                }
            } catch let jsonErr {
                print("Failed to parsing MovieDetail JSON \(jsonErr)")
            }
            
            }.resume()
        
    }
    
    //MovieDetail JSON 통신 실패 알람
    func movieCommentsJsonErrAlet() {
        let alert = UIAlertController(title: "JSON Errro", message: "데이터를 수신하지 못하였습니다. 인터넷 연결을 확인후 다시 시도해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "재연결", style: .default, handler: { (_) in
            self.fetchMovieCommentsJSON()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - 스크롤뷰 셋팅
    fileprivate func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.bounces = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    //MARK: - 영화상세뷰 셋팅
    func setupMovieDetailView(){
        let height = view.frame.width * 2.3/3
        
        let movieInfoLabelStakView = UIStackView(arrangedSubviews: [openDateLabel, genreAndDurationLabel])
        movieInfoLabelStakView.axis = .vertical
        movieInfoLabelStakView.spacing = 7
        movieInfoLabelStakView.distribution = .fillEqually
        
        let reservationLabelStakView = UIStackView(arrangedSubviews: [reservationRateTitleLabel, reservationRateAndGradeLabel])
        reservationLabelStakView.axis = .vertical
        reservationLabelStakView.distribution = .fillEqually
        
        let ratingLabelStackView = UIStackView(arrangedSubviews: [userRatingTitleLabel,userRatingLabel,ratingStarsImageView])
        ratingLabelStackView.axis = .vertical
        ratingLabelStackView.distribution = .fillEqually
        
        let audienceLabelStackView = UIStackView(arrangedSubviews: [audienceTitleLabel, audienceLabel])
        audienceLabelStackView.axis = .vertical
        audienceLabelStackView.distribution = .fillEqually
        
        let movieEvaluationStakView = UIStackView(arrangedSubviews: [reservationLabelStakView, ratingLabelStackView, audienceLabelStackView])
        movieEvaluationStakView.axis = .horizontal
        movieEvaluationStakView.distribution = .fillEqually
        
        contentView.addSubview(movieDetailView)
        movieDetailView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height)
        
        movieDetailView.addSubview(movieTumbImageView)
        movieDetailView.addSubview(movieEvaluationStakView)
        movieDetailView.addSubview(movieInfoLabelStakView)
        movieDetailView.addSubview(movieTitleLabel)
        movieTitleLabel.addSubview(gradeImageView)
        
        movieTumbImageView.anchor(top: movieDetailView.topAnchor, left: movieDetailView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: view.frame.width * 1/3, height: 0)
        
        movieEvaluationStakView.anchor(top: movieTumbImageView.bottomAnchor, left: movieDetailView.leftAnchor, bottom: movieDetailView.bottomAnchor, right: movieDetailView.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        movieInfoLabelStakView.anchor(top: nil, left: movieTumbImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        movieInfoLabelStakView.centerYAnchor.constraint(equalTo: movieTumbImageView.centerYAnchor).isActive = true
        
        movieTitleLabel.anchor(top: nil, left: movieTumbImageView.rightAnchor, bottom: movieInfoLabelStakView.topAnchor, right: nil, paddingTop: 7, paddingLeft: 10, paddingBottom: 7, paddingRight: 0, width: 0, height: 0)
        
        gradeImageView.anchor(top: movieTitleLabel.topAnchor, left: movieTitleLabel.rightAnchor, bottom: movieTitleLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        
        ratingLabelStackView.addSubview(leftEvaluateSperateView)
        ratingLabelStackView.addSubview(rightEvaluateSperateView)
        
        leftEvaluateSperateView.anchor(top: ratingLabelStackView.topAnchor, left: ratingLabelStackView.leftAnchor, bottom: ratingLabelStackView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: -10, paddingBottom: 0, paddingRight: 0, width: 0.5, height: 0)
        rightEvaluateSperateView.anchor(top: ratingLabelStackView.topAnchor, left: nil, bottom: ratingLabelStackView.bottomAnchor, right: ratingLabelStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -10, width: 0.5, height: 0)
        
    }
    
    //MARK: - 줄거리뷰 셋팅
    func setupSynopsisView() {
        contentView.addSubview(synopsisView)
        synopsisView.anchor(top: seperateViewSynopsis.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        synopsisView.addSubview(synopsisTitleLabel)
        synopsisTitleLabel.anchor(top: synopsisView.topAnchor, left: synopsisView.leftAnchor, bottom: nil, right: synopsisView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        synopsisView.addSubview(synopsisTextView)
        synopsisTextView.anchor(top: synopsisTitleLabel.bottomAnchor, left: synopsisView.leftAnchor, bottom: synopsisView.bottomAnchor, right: synopsisView.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 10, paddingRight: 30, width: 0, height: 0)
    }
    
    //MARK: - 감독/배우 뷰 셋팅
    func setupDirectorAndActorView() {
        contentView.addSubview(directorAndActorView)
        directorAndActorView.anchor(top: seperateViewDirectorAndActorLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        directorAndActorView.addSubview(directorAndActorTitleLabel)
        directorAndActorView.addSubview(directorTitleLabel)
        directorAndActorView.addSubview(directorLabel)
        directorAndActorView.addSubview(actorTitleLabel)
        directorAndActorView.addSubview(actorLabel)
        
        directorAndActorTitleLabel.anchor(top: directorAndActorView.topAnchor, left: directorAndActorView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        directorTitleLabel.anchor(top: directorAndActorTitleLabel.bottomAnchor, left: directorAndActorView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 40, height: 0)
        directorLabel.anchor(top: directorAndActorTitleLabel.bottomAnchor, left: directorTitleLabel.rightAnchor, bottom: nil, right: directorAndActorView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        actorTitleLabel.anchor(top: directorTitleLabel.bottomAnchor, left: directorAndActorView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 40, height: 0)
        actorLabel.anchor(top: directorLabel.bottomAnchor, left: actorTitleLabel.rightAnchor, bottom: directorAndActorView.bottomAnchor, right: directorAndActorView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
        
    }
    
    //MARK: - 테이블뷰 셋팅
    func setupTableView() {
        
        contentView.addSubview(coverTableView)
        coverTableView.anchor(top: seperateViewCommentTable.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 800)
        coverTableView.addSubview(commentsTableView)
        commentsTableView.anchor(top: coverTableView.topAnchor, left: coverTableView.leftAnchor, bottom: coverTableView.bottomAnchor, right: coverTableView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieComments?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieCommentTableCell
        
        cell.comments = movieComments?.comments[indexPath.row]
        
        return cell
    }
    
    //UIScrollView 가 맨 끝에 왔을때 CommentsTableView 스크롤 작동
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if decelerate == true {
            commentsTableView.isScrollEnabled = true
        } else {
            commentsTableView.isScrollEnabled = false
        }
        
    }

}
