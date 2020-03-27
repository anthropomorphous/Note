import UIKit.UIColor

let indexKey = "index"
let uidKey = "uid"
let titleKey = "title"
let contentKey = "content"
let colorKey = "color"
let selfDestructDateKey = "selfDestructDate"
let importanceKey = "importance"

extension Note {
    
    var json: [String: Any] {
        var result = [String: Any]()
        result[indexKey] = index
        result[uidKey] = uid
        result[titleKey] = title
        result[contentKey] = content
        
        if color != UIColor.white {
             result[colorKey] = color.htmlRGBaColor
        }
        
        if let date = selfDestructDate {
            let resDate = date.timeIntervalSince1970
            result[selfDestructDateKey] = resDate
        }
        
        if importance != .usual {
            result[importanceKey] = importance.rawValue
        }
        
        return result
    }
    
    static func parse(json: [String: Any]) -> Note? {
        guard let index = json[indexKey] as? Int else {
            return nil
        }
        guard let uid = json[uidKey] as? String else {
            return nil
        }
        guard let title = json[titleKey] as? String else {
            return nil
        }
            
        guard let content = json[contentKey] as? String else {
            return nil
        }
        
        var color : UIColor
        if let strColor = json[colorKey] as? String {
             color = UIColor(hex: strColor) ?? UIColor.white
        } else {
             color = UIColor.white
        }
        
        var selfDestructDate : Date? = nil
        
        if let jsonDate = json[selfDestructDateKey] as? TimeInterval {
            selfDestructDate = Date(timeIntervalSince1970: jsonDate)
        }
        
        var importance : Importance
        if let strImportance = json[importanceKey] as? String {
            importance = Importance(rawValue: strImportance) ?? .usual
        } else {
            importance = .usual
        }
        
        
        let note = Note(index: index,
                        uid: uid,
                        title: title,
                        content: content,
                        color: color,
                        selfDestructDate: selfDestructDate,
                        importance: importance)
        
        return note
    }
}

extension UIColor {
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
           var r:CGFloat = 0
           var g:CGFloat = 0
           var b:CGFloat = 0
           var a:CGFloat = 0
           if getRed(&r, green: &g, blue: &b, alpha: &a) {
               return (r,g,b,a)
           }
           return (0,0,0,0)
       }
    var htmlRGBaColor:String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255), Int(rgbComponents.blue * 255), Int(rgbComponents.alpha * 255))
    }
    
    public convenience init?(hex: String) {
           let r, g, b, a: CGFloat

           if hex.hasPrefix("#") {
               let start = hex.index(hex.startIndex, offsetBy: 1)
               let hexColor = String(hex[start...])

               if hexColor.count == 8 {
                   let scanner = Scanner(string: hexColor)
                   var hexNumber: UInt64 = 0

                   if scanner.scanHexInt64(&hexNumber) {
                       r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                       g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                       b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                       a = CGFloat(hexNumber & 0x000000ff) / 255

                       self.init(red: r, green: g, blue: b, alpha: a)
                       return
                   }
               }
           }

           return nil
       }
}
