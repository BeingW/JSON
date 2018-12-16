//
//  Movie.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/9/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

struct MovieList: Decodable {
    let orderType: Int?
    var movies: [Movie]
}

struct Movie: Decodable {
    let reservationGrade: Int?
    let id: String?
    let thumb: String?
    let userRating: Double?
    let reservationRate: Double?
    let title: String?
    let grade: Int?
    let date: String?
}

