//
//  Separates array into three.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/22/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

func arrayDivider(inputArray: [Picture]) -> [[Picture]] {
    var outputArray: [[Picture]] = [[], [], []]
    
    for number in 0..<inputArray.count {
        if (number%3) == 0 {
            outputArray[0].append(inputArray[number])
        }
        else if (number%3) == 1 {
            outputArray[1].append(inputArray[number])
        }
        else {
            outputArray[2].append(inputArray[number])
        }
    }
    
    return outputArray
}
