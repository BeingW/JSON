//
//  MovieTableViewCell.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/7/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            guard let tumbImageUrl = movie?.thumb else {return}
            guard let title = movie?.title else {return}
            guard let userRating = movie?.userRating else {return}
            guard let reservationGrade = movie?.reservationGrade else {return}
            guard let reservationRate = movie?.reservationRate else {return}
            guard let date = movie?.date else {return}
            guard let ageMark = movie?.grade else {return}
            
            guard let ageMarkImage = Tools.shared.printMovieGrade(movieGrade: ageMark) else {return}
            
            tumbImageView.loadImage(urlString: tumbImageUrl)
            titleLabel.text = title
            userRatingLabel.text = "평점 : \(userRating) "
            reservationGradeLabel.text = "예매순위 : \(reservationGrade)"
            reservationRateLabel.text = "예매율 : \(reservationRate)"
            openDateLabel.text = date
            gradeImageView.image = ageMarkImage
        }
    }
    
    //영화 포스터 tumb 이미지
    let tumbImageView: CustomImageView = {
        let imageview = CustomImageView()
        imageview.image = UIImage(named: "movie_JusticeLeague.jpg")
        imageview.clipsToBounds = true
        return imageview
    }()
    
    //영화 연령제한표시 이미지
    let gradeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AllMark@2x.png")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //영화 제목 라벨
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //영화 평점 라벨
    let userRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "평점 : "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //영화 예매순위 라벨
    let reservationGradeLabel: UILabel = {
        let label = UILabel()
        label.text = "예매순위 : "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //영화 예매율 라벨
    let reservationRateLabel: UILabel = {
        let label = UILabel()
        label.text = "예매율 : "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //영화 개봉일 라벨
    let openDateLabel: UILabel = {
       let label = UILabel()
        label.text = "개봉일 : "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //테이블뷰 UI 셋팅
    func setupCell() {
        
        let ratingLabelStackView = UIStackView(arrangedSubviews: [userRatingLabel, reservationGradeLabel, reservationRateLabel])
        ratingLabelStackView.axis = .horizontal
        ratingLabelStackView.distribution = .fillProportionally
        ratingLabelStackView.spacing = 5
        
        let movieInfoStackView = UIStackView(arrangedSubviews: [ratingLabelStackView, openDateLabel])
        movieInfoStackView.axis = .vertical
        movieInfoStackView.distribution = .fillProportionally
        movieInfoStackView.spacing = 10
        
        let tumbImageviewWidth = self.frame.width * 3/10
        addSubview(tumbImageView)
        addSubview(titleLabel)
        addSubview(gradeImageView)
        addSubview(movieInfoStackView)
        
        tumbImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 20, paddingBottom: 3, paddingRight: 0, width: tumbImageviewWidth, height: 0)
        titleLabel.anchor(top: topAnchor, left: tumbImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        gradeImageView.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        gradeImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        movieInfoStackView.anchor(top: titleLabel.bottomAnchor, left: tumbImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 12, paddingRight: 10, width: 0, height: 0)
        
    }
    
}
