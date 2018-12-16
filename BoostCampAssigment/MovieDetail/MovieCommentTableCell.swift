//
//  MovieCommentTableCell.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/13/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class MovieCommentTableCell: UITableViewCell {
    
    var comments: Comments? {
        didSet{
            guard let userId = comments?.writer else {return}
            guard let commentsDate = comments?.timestamp else {return}
            guard let userComments = comments?.contents else {return}
            guard let userRating = comments?.rating else {return}
            
            guard let ratingStarImage = Tools.shared.printRatingStarImage(userRating: userRating) else {return}
            
            if let convertedCommentsDate = Tools.shared.convertingUnixTimesToString(date: commentsDate) {
                commentsDateLabel.text = "\(convertedCommentsDate)"
            }
            userIdLabel.text = userId
            commentsTextView.text = "\(userComments)"
            ratingStarsImageView.image = ratingStarImage
        }
    }
    
    //유저 프로파일뷰
    let profileImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.backgroundColor = .lightGray
        uiImageView.layer.masksToBounds = false
        uiImageView.layer.cornerRadius = uiImageView.frame.width / 2
        uiImageView.layer.borderColor = UIColor.lightGray.cgColor
        uiImageView.layer.borderWidth = 3
        
        return uiImageView
    }()
    
    //유저 아이디
    let userIdLabel: UILabel = {
        let label = UILabel()
        label.text = "userID"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //유저 별점이미지뷰
    let ratingStarsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ThreeStars@2x.png")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //유저 댓글 남긴 시간 라벨
    let commentsDateLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.text = "2017-11-23 00:01:00"
        idLabel.font = UIFont.systemFont(ofSize: 15)
        idLabel.textColor = .lightGray
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        return idLabel
    }()
    
    //유저 댓글 뷰
    let commentsTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = "인류의 수호자인 슈퍼맨이 사라진 틈을 노리고 ‘마더박스’를 차지하기 위해 빌런."
        textView.textColor = .black
        textView.becomeFirstResponder()
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        self.setupCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //유아이 셋팅
    func setupCellUI() {
        self.addSubview(profileImageView)
        self.addSubview(userIdLabel)
        self.addSubview(ratingStarsImageView)
        self.addSubview(commentsDateLabel)
        self.addSubview(commentsTextView)
        
        let width = self.frame.width
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: width * 1.5/5, height: width * 1.5/5)
        userIdLabel.anchor(top: self.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        ratingStarsImageView.anchor(top: self.topAnchor, left: userIdLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 100, height: 15)
        commentsDateLabel.anchor(top: userIdLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        commentsTextView.anchor(top: commentsDateLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
    }
    
}
