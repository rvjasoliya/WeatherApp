import Foundation

public class Coord {
    
	public var lon: Double?
	public var lat: Double?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Coord] {
        var models: [Coord] = []
        for item in array {
            models.append(Coord(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		lon = dictionary["lon"] as? Double
		lat = dictionary["lat"] as? Double
        
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.lon, forKey: "lon")
		dictionary.setValue(self.lat, forKey: "lat")

		return dictionary
        
	}

}
