import Foundation

public class Clouds {
    
	public var all: Int?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Clouds] {
        var models: [Clouds] = []
        for item in array {
            models.append(Clouds(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		all = dictionary["all"] as? Int
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.all, forKey: "all")

		return dictionary
	}

}
