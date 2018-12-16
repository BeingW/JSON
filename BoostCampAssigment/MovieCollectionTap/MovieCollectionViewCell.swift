//
//  MovieCollectionViewCell.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/7/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
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
            reservationAndRatingLabel.text = "\(reservationGrade)위(\(userRating)) / \(reservationRate)%"
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
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //영화 제목 라벨
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //영화 예매순위,평점 라벨
    let reservationAndRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "예매순위 : "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //영화 예매율 라벨
    let reservationRateLabel: UILabel = {
        let label = UILabel()
        label.text = "예매율 : "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //영화 개봉일 라벨
    let openDateLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉일 : "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMovieCellUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //콜렉션뷰 UI 셋팅
    func setupMovieCellUI() {
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, reservationAndRatingLabel, openDateLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillProportionally
        
        let tumbImageViewHeight = self.frame.height * 7.4/10
        
        addSubview(tumbImageView)
        tumbImageView.addSubview(gradeImageView)
        tumbImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: tumbImageViewHeight)
        gradeImageView.anchor(top: tumbImageView.topAnchor, left: nil, bottom: nil, right: tumbImageView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 30, height: 30)
        
        addSubview(labelStackView)
        labelStackView.anchor(top: tumbImageView.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    
}
