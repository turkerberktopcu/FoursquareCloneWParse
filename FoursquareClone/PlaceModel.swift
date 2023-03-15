//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 15.03.2023.
//

import Foundation

struct Places {
    let placeName: String?
    let placeType: String?
    let placeDetails: String?
    let imageData: Data?
    
    init(placeName: String?, placeType: String?, placeDetails: String?, imageData: Data?) {
        self.placeName = placeName
        self.placeType = placeType
        self.placeDetails = placeDetails
        self.imageData = imageData
    }
    
}
