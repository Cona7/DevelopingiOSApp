//
//  MealsArray.swift
//  FoodTracker
//
//  Created by Josip Glasovac on 18/10/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import Foundation
import Storable

struct MealsArray: Storable {
    var meals = [Meal]()
}
