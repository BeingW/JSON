//
//  Tools.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/16/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class Tools {
    
    static let shared = Tools()
    
    func convertingAudiences(audiences: Int) -> String? {
        
        let audiencesString = String(audiences)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let nsNumberAudiences = numberFormatter.number(from: audiencesString)
        
        let formattedAudiences = numberFormatter.string(from: nsNumberAudiences ?? 0)
        
        return formattedAudiences
    }
    
    func convertingUnixTimesToString(date: Double) -> String? {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    func printMovieGrade(movieGrade: Int) -> UIImage? {
        switch movieGrade {
        case 0 :
            return UIImage(named: "AllMark@2x.png")
        case 12 :
            return UIImage(named: "12Mark@2x.png")
        case 15 :
            return UIImage(named: "15Mark@2x.png")
        case 19 :
            return UIImage(named: "19Mark@2x.png")
        default:
            return UIImage(named: "AllMark@2x.png")
        }
    }
    
    func printRatingStarImage(userRating: Double) -> UIImage? {
        switch userRating {
        case 0.00...1.00 :
            return UIImage(named: "HalfStar@2x.png")
        case 1.01...2.00 :
            return UIImage(named: "OneStar@2x.png")
        case 2.01...3.00 :
            return UIImage(named: "OneStartAndHalf@2x.png")
        case 3.01...4.00 :
            return UIImage(named: "TwoStars@2x.png")
        case 4.01...5.00 :
            return UIImage(named: "TwoStarAndHalf@2x.png")
        case 5.01...6.00 :
            return UIImage(named: "ThreeStars@2x.png")
        case 6.01...7.00 :
            return UIImage(named: "ThreeStarAndHalf@2x.png")
        case 7.01...8.00 :
            return UIImage(named: "FourStars@2x.png")
        case 8.01...9.00 :
            return UIImage(named: "FourStarAndHalf@2x.png")
        case 9.01...10.00 :
            return UIImage(named: "FiveStars@2x.png")
        default:
            return UIImage(named: "ThreeStars@2x.png")
        }
    }
    
    
    
    
}
