//
//  Meal.swift
//  FoodTracker
//
//  Created by Josip Glasovac on 12/10/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit
import os.log
import Storable

struct Meal: Storable {

    var name: String
    var photo: UIImage?
    var rating: Int

    enum CodingKeys: String, CodingKey {
        case name
        case photo
        case rating
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        rating = try values.decode(Int.self, forKey: .rating)
        let data = try values.decode(Data.self, forKey: .photo)
        photo = UIImage(data: data)

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(rating, forKey: .rating)

        let data = photo?.pngData()
        try container.encode(data, forKey: .photo)
    }

    init?(name: String, photo: UIImage?, rating: Int) {
        guard !name.isEmpty else {
            return nil
        }

        guard rating >= 0 && rating <= 5 else {
            return nil
        }

        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
