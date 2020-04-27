//
//  StarLordDataModel.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation

struct StarLordDataModel : Codable {
    var sNo : Int?
    var amtPledged : Int?
    var blurb : String?
    var by : String?
    var country : String?
    var currency : String?
    var endTime : String?
    var location : String?
    var percentageFunded : Int?
    var numBackers : String?
    var state : String?
    var title : String?
    var type : String?
    var url : String?

    enum CodingKeys: String, CodingKey {

        case sNo = "s.no"
        case amtPledged = "amt.pledged"
        case blurb = "blurb"
        case by = "by"
        case country = "country"
        case currency = "currency"
        case endTime = "end.time"
        case location = "location"
        case percentageFunded = "percentage.funded"
        case numBackers = "num.backers"
        case state = "state"
        case title = "title"
        case type = "type"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sNo = try values.decodeIfPresent(Int.self, forKey: .sNo)
        amtPledged = try values.decodeIfPresent(Int.self, forKey: .amtPledged)
        blurb = try values.decodeIfPresent(String.self, forKey: .blurb)
        by = try values.decodeIfPresent(String.self, forKey: .by)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        percentageFunded = try values.decodeIfPresent(Int.self, forKey: .percentageFunded)
        numBackers = try values.decodeIfPresent(String.self, forKey: .numBackers)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

    init() {
        sNo = 0
        amtPledged = 0
        blurb = ""
        by = ""
        country = ""
        currency = ""
        endTime = ""
        location = ""
        percentageFunded = 0
        numBackers = ""
        state = ""
        title = ""
        type = ""
        url = ""
    }
}
