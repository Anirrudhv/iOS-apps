//
//  Questions.swift
//  Quizzler
//
//  Created by Anirudh V on 6/8/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Question
{
    let question : String
    let answer : Bool
    
    init(text : String, correctAnswer : Bool) {
        question = text
        answer = correctAnswer
    }
    
}
