//
//  MovieComments.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/11/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import Foundation

struct MovieComments: Decodable {
    let movieId: String?
    let comments: [Comments]
}

struct Comments: Decodable {
    let rating: Double?
    let timestamp: Double?
    let writer: String?
    let movieId: String?
    let contents: String?
}
