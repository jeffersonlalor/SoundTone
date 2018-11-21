//
//  ModelController.swift
//  SoundTone
//
//  Created by Jefferson de Oliveira Lalor on 16/11/18.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext


// MARK: - Save

func saveRoundCoreData( value: Int ) {
    let round = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context)
    
    round.setValue(Int32( value ), forKey: "round")
    do {
        try context.save()
        print("Valor do round salvo")
    } catch {
        print("Valor do round não salvo")
    }
}


func saveScoreCoreData( value: Int ) {
    let score = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context)
    
    score.setValue(Int32( value ), forKey: "score")
    do {
        try context.save()
        print("Valor do score salvo")
    } catch {
        print("Valor do score não salvo")
    }

}


// MARK: - List

func valueRoundCoreData() -> Int {
    
    
    return 0
}


func valueScoreCoreData() -> Int {
    
    
    return 0
}


// MARK: - Delete

func deleteRoundCoreData(){
    
}

func deleteScoreCoreData(){
    
}
