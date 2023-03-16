import Foundation

public class Forecastday {
    
	public var date: String?
	public var date_epoch: Int?
	public var day: Day?
	public var astro: Astro?
	public var hour: Array<Hour>?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Forecastday] {
        var models:[Forecastday] = []
        for item in array {
            models.append(Forecastday(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		date = dictionary["date"] as? String
		date_epoch = dictionary["date_epoch"] as? Int
		if (dictionary["day"] != nil) { day = Day(dictionary: dictionary["day"] as! NSDictionary) }
		if (dictionary["astro"] != nil) { astro = Astro(dictionary: dictionary["astro"] as! NSDictionary) }
        if (dictionary["hour"] != nil) { hour = Hour.modelsFromDictionaryArray(array: dictionary["hour"] as! NSArray) }
        
	}

		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.date, forKey: "date")
		dictionary.setValue(self.date_epoch, forKey: "date_epoch")
		dictionary.setValue(self.day?.dictionaryRepresentation(), forKey: "day")
		dictionary.setValue(self.astro?.dictionaryRepresentation(), forKey: "astro")

		return dictionary
	}

}
