import Foundation

public class Condition {
	public var text: String?
	public var icon: String?
	public var code: Int?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Condition] {
        var models: [Condition] = []
        for item in array {
            models.append(Condition(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		text = dictionary["text"] as? String
		icon = dictionary["icon"] as? String
		code = dictionary["code"] as? Int
        
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.text, forKey: "text")
		dictionary.setValue(self.icon, forKey: "icon")
		dictionary.setValue(self.code, forKey: "code")

		return dictionary
	}

}
