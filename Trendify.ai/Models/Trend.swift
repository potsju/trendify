//
//  Trend.swift
//  Trendify.ai
//
//  Created by Darren Choe on 12/31/24.
//

import Foundation
struct Trend: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    let imageUrl: String
    let popularityScore: Double
    let genre: String
    let statistics: TrendStatistics
    
    private enum CodingKeys: String, CodingKey {
        case title, description, imageUrl, popularityScore, genre, statistics
    }
}

struct TrendStatistics: Codable {
    var id = UUID()
    let hashtags: [HashtagData]
    let keywords: [KeywordData]
    let engagement: EngagementMetrics
    
    private enum CodingKeys: String, CodingKey {
        case hashtags, keywords, engagement
    }
}


struct HashtagData: Codable, Identifiable {
    var id = UUID()
    let name: String
    let count: Int
    let viewCount: Int64
    
    private enum CodingKeys: String, CodingKey {
        case name, count, viewCount
    }
}

struct KeywordData: Codable, Identifiable {
    var id = UUID()
    let term: String
    let searchVolume: Int
    let growthRate: Double
    
    private enum CodingKeys: String, CodingKey {
        case term, searchVolume, growthRate
    }
}
struct EngagementMetrics: Codable {
    let totalViews: Int64
    let totalWatchTimeMinutes: Int64
    let averageWatchDuration: Double
    let engagementRate: Double
}


