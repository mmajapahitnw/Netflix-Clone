//
//  TVShow.swift
//  Netflix Clone
//
//  Created by Majapahit Wisisono on 23/07/25.
//

import Foundation

struct TrendingTVResponse: Codable {
    let results: [TVShow]
}

struct TVShow: Codable {
    let id: Int
    let media_type: String?
    let name: String?
    let original_name: String?
    let original_language: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let vote_average: Double
    let first_air_date: String?
}
