import Foundation

public class Hourly {
    
	public var dt: Int?
	public var temp: Double?
	public var feels_like: Double?
	public var pressure: Int?
	public var humidity: Int?
	public var dew_point: Double?
	public var uvi: Int?
	public var clouds: Int?
	public var visibility: Int?
	public var wind_speed: Double?
	public var wind_deg: Int?
	public var wind_gust: Double?
	public var weather: Array<Weather>?
	public var pop: Int?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Hourly] {
        var models: [Hourly] = []
        for item in array {
            models.append(Hourly(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		dt = dictionary["dt"] as? Int
		temp = dictionary["temp"] as? Double
		feels_like = dictionary["feels_like"] as? Double
		pressure = dictionary["pressure"] as? Int
		humidity = dictionary["humidity"] as? Int
		dew_point = dictionary["dew_point"] as? Double
		uvi = dictionary["uvi"] as? Int
		clouds = dictionary["clouds"] as? Int
		visibility = dictionary["visibility"] as? Int
		wind_speed = dictionary["wind_speed"] as? Double
		wind_deg = dictionary["wind_deg"] as? Int
		wind_gust = dictionary["wind_gust"] as? Double
        if (dictionary["weather"] != nil) { weather = Weather.modelsFromDictionaryArray(array: dictionary["weather"] as! NSArray) }
		pop = dictionary["pop"] as? Int
	}

	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
		dictionary.setValue(self.dt, forKey: "dt")
		dictionary.setValue(self.temp, forKey: "temp")
		dictionary.setValue(self.feels_like, forKey: "feels_like")
		dictionary.setValue(self.pressure, forKey: "pressure")
		dictionary.setValue(self.humidity, forKey: "humidity")
		dictionary.setValue(self.dew_point, forKey: "dew_point")
		dictionary.setValue(self.uvi, forKey: "uvi")
		dictionary.setValue(self.clouds, forKey: "clouds")
		dictionary.setValue(self.visibility, forKey: "visibility")
		dictionary.setValue(self.wind_speed, forKey: "wind_speed")
		dictionary.setValue(self.wind_deg, forKey: "wind_deg")
		dictionary.setValue(self.wind_gust, forKey: "wind_gust")
		dictionary.setValue(self.pop, forKey: "pop")
		return dictionary
	}

}
