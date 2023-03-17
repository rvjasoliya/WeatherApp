import Foundation

public class WeatherCity {
    
	public var coord: Coord?
	public var weather: Array<Weather>?
	public var base: String?
	public var main: Main?
	public var visibility: Int?
	public var wind: Wind?
	public var clouds: Clouds?
	public var dt: Int?
	public var sys: Sys?
	public var timezone: Int?
	public var id: Int?
	public var name: String?
	public var cod: Int?

    public class func modelsFromDictionaryArray(array: NSArray) -> [WeatherCity] {
        var models: [WeatherCity] = []
        for item in array {
            models.append(WeatherCity(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		if (dictionary["coord"] != nil) { coord = Coord(dictionary: dictionary["coord"] as! NSDictionary) }
        if (dictionary["weather"] != nil) { weather = Weather.modelsFromDictionaryArray(array: dictionary["weather"] as! NSArray) }
		base = dictionary["base"] as? String
		if (dictionary["main"] != nil) { main = Main(dictionary: dictionary["main"] as! NSDictionary) }
		visibility = dictionary["visibility"] as? Int
		if (dictionary["wind"] != nil) { wind = Wind(dictionary: dictionary["wind"] as! NSDictionary) }
		if (dictionary["clouds"] != nil) { clouds = Clouds(dictionary: dictionary["clouds"] as! NSDictionary) }
		dt = dictionary["dt"] as? Int
		if (dictionary["sys"] != nil) { sys = Sys(dictionary: dictionary["sys"] as! NSDictionary) }
		timezone = dictionary["timezone"] as? Int
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		cod = dictionary["cod"] as? Int
        
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.coord?.dictionaryRepresentation(), forKey: "coord")
		dictionary.setValue(self.base, forKey: "base")
		dictionary.setValue(self.main?.dictionaryRepresentation(), forKey: "main")
		dictionary.setValue(self.visibility, forKey: "visibility")
		dictionary.setValue(self.wind?.dictionaryRepresentation(), forKey: "wind")
		dictionary.setValue(self.clouds?.dictionaryRepresentation(), forKey: "clouds")
		dictionary.setValue(self.dt, forKey: "dt")
		dictionary.setValue(self.sys?.dictionaryRepresentation(), forKey: "sys")
		dictionary.setValue(self.timezone, forKey: "timezone")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.cod, forKey: "cod")

		return dictionary
	}

}
