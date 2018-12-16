//
//  MovieDetail.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/11/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let image: String?
    let id: String?
    let audience: Int?
    let actor: String?
    let userRating: Double?
    let grade: Int?
    let genre: String?
    let title: String?
    let duration: Int?
    let synopsis: String?
    let director: String?
    let date: String?
    let reservationRate: Double?
    let reservationGrade: Int?
}


