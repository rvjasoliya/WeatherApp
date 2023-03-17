import Foundation

public class Main {
    
	public var temp: Double?
	public var feels_like: Double?
	public var temp_min: Double?
	public var temp_max: Double?
	public var pressure: Int?
	public var humidity: Int?
	public var sea_level: Int?
	public var grnd_level: Int?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Main] {
        
        var models: [Main] = []
        for item in array {
            models.append(Main(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		temp = dictionary["temp"] as? Double
		feels_like = dictionary["feels_like"] as? Double
		temp_min = dictionary["temp_min"] as? Double
		temp_max = dictionary["temp_max"] as? Double
		pressure = dictionary["pressure"] as? Int
		humidity = dictionary["humidity"] as? Int
		sea_level = dictionary["sea_level"] as? Int
		grnd_level = dictionary["grnd_level"] as? Int
	}

		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.temp, forKey: "temp")
		dictionary.setValue(self.feels_like, forKey: "feels_like")
		dictionary.setValue(self.temp_min, forKey: "temp_min")
		dictionary.setValue(self.temp_max, forKey: "temp_max")
		dictionary.setValue(self.pressure, forKey: "pressure")
		dictionary.setValue(self.humidity, forKey: "humidity")
		dictionary.setValue(self.sea_level, forKey: "sea_level")
		dictionary.setValue(self.grnd_level, forKey: "grnd_level")

		return dictionary
	}

}
