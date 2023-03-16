import Foundation

public class Forecast {

    public var forecastday: Array<Forecastday>?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Forecast] {
        var models: [Forecast] = []
        for item in array {
            models.append(Forecast(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

        if (dictionary["forecastday"] != nil) { forecastday = Forecastday.modelsFromDictionaryArray(array: dictionary["forecastday"] as! NSArray) }
        
	}

		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		return dictionary
	}

}
