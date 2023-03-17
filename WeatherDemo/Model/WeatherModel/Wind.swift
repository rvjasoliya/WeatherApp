import Foundation

public class Wind {
    
	public var speed: Double?
	public var deg: Int?
	public var gust: Double?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Wind] {
        var models: [Wind] = []
        for item in array {
            models.append(Wind(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		speed = dictionary["speed"] as? Double
		deg = dictionary["deg"] as? Int
		gust = dictionary["gust"] as? Double
	}
		
	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
		dictionary.setValue(self.speed, forKey: "speed")
		dictionary.setValue(self.deg, forKey: "deg")
		dictionary.setValue(self.gust, forKey: "gust")
		return dictionary
	}

}
