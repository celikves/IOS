//
//  BreedModel.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 18.04.2022.
//

import Foundation

struct BreedElement: Codable {
    var image: Image?
    var name: String
    var origin : String
    var life_span : String
    var description : String
    var detailsPageImage : Image?
    //var wikipedia_url : String

    enum CodingKeys: String, CodingKey {
        
        case image = "image"
        case name = "name"
        case origin = "origin"
        case life_span = "life_span"
        case description = "description"
        case detailsPageImage = "detailsImage"
        //case wikipedia_url = "wikipedia_url"
    }
}

// MARK: - Image
struct Image: Codable {
    var height: Int?
    var id: String?
    var url: String?
    var width: Int?
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case id = "id"
        case url = "url"
        case width = "width"
    }
}
/*
struct BreedModel: Codable {
    let altNames: String
    let experimental, hairless, hypoallergenic: Int
    let id, lifeSpan, name: String
    let natural: Int
    let origin: String
    let rare: Int
    let referenceImageID: JSONNull?
    let rex, shortLegs, suppressedTail: Int
    let temperament, weightImperial: String
    let wikipediaURL: String

    enum CodingKeys: String, CodingKey {
        case altNames = "alt_names"
        case experimental, hairless, hypoallergenic, id
        case lifeSpan = "life_span"
        case name, natural, origin, rare
        case referenceImageID = "reference_image_id"
        case rex
        case shortLegs = "short_legs"
        case suppressedTail = "suppressed_tail"
        case temperament
        case weightImperial = "weight_imperial"
        case wikipediaURL = "wikipedia_url"
    }
}

typealias Breed = [BreedModel]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

*/
