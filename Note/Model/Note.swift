import UIKit

struct Note {
    let index: Int
    let uid : String
    let title : String
    let content : String
    let color : UIColor
    let selfDestructDate : Date?
    let importance : Importance
    
    enum Importance : String {
        case important
        case usual
        case unimportant
    }
    
    init(index: Int,
         uid: String = UUID().uuidString,
         title: String,
         content: String,
         color: UIColor = UIColor.white,
         selfDestructDate : Date?,
         importance : Importance) {
        self.index = index
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.selfDestructDate = selfDestructDate
        self.importance = importance
    }
}

