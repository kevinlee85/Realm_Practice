//
//  Specimen.swift
//  RWRealmStarterProject
//
//  Created by kevin on 7/7/15.
//  Copyright (c) 2015 Bill Kastanakis. All rights reserved.
//

import UIKit
import RealmSwift

class Specimen: Object {
    dynamic var name = ""
    dynamic var specimenDescription = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var created = NSDate()
    dynamic var category = Category()
}