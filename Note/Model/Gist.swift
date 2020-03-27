import UIKit

struct Gist: Codable {
    let description: String
    let files: [String: GistFile]
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(description, forKey: .description)
//        var files = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .files)
//    }
}

struct GistFile: Codable {
    let filename: String
    let content: String
    let rawUrl: String

    enum CodingKeys: String, CodingKey {
        case filename
        case content
        case rawUrl = "raw_url"
    }
    
//    func encode(to encoder: Encoder) throws {
//        var file = encoder.container(keyedBy: CodingKeys.self)
//        try file.encode(filename, forKey: .filename)
//    }
//
//    func decode(from decoder: Decoder) throws {
//
//    }
}
