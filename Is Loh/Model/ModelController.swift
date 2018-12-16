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
let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")



// MARK: - Save

func saveRoundCoreData( value: Int ) {
    let round = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context)
    
    round.setValue(Int32( value ), forKey: "round")
    do {
        try context.save()
    } catch {
        print("Valor do round não salvo")
    }
}


func saveScoreCoreData( value: Int ) {
    let score = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context)
    
    score.setValue(Int32( value ), forKey: "score")
    do {
        try context.save()
    } catch {
        print("Valor do score não salvo")
    }

}



// MARK: - List

func valueRoundCoreData() -> Int? {
    let ordenacaoCrescente = NSSortDescriptor(key: "round", ascending: true)

    requisicao.sortDescriptors = [ordenacaoCrescente]

    do {
        let rounds = try context.fetch(requisicao)
        
        if rounds.count > 0 {
            for valor in rounds as! [NSManagedObject] {
                if let valueRound = valor.value(forKey: "round"){
                    return valueRound as? Int
                }
            }
        }
    } catch {
        print("Erro ao recuperar valor do round")
    }
    
    return nil
}


func valueScoreCoreData() -> Int? {
    let ordenacaoCrescente = NSSortDescriptor(key: "score", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let scores = try context.fetch(requisicao)
        
        if scores.count > 0 {
            for score in scores as! [NSManagedObject] {
                if let valueScore = score.value(forKey: "score"){
                    return valueScore as? Int
                }
            }
        }
    } catch {
        print("Erro ao recuperar valor do score")
    }
    
    return nil
}



// MARK: - Update

func updateRoundCoreData( value: Int ) {
    let ordenacaoCrescente = NSSortDescriptor(key: "round", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let rounds = try context.fetch(requisicao)
        
        if rounds.count > 0 {
            for valor in rounds as! [NSManagedObject] {
                if valor.value(forKey: "round") != nil {
                    valor.setValue(value, forKey: "round")
                    
                    do{
                        try context.save()
                    }catch{
                        print("Erro ao atualizar round")
                    }
                }
            }
        }
    } catch {
        print("Erro ao recuperar valor do round")
    }
}


func updateScoreCoreData( value: Int ) {
    let ordenacaoCrescente = NSSortDescriptor(key: "score", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let scores = try context.fetch(requisicao)
        
        if scores.count > 0 {
            for score in scores as! [NSManagedObject] {
                if score.value(forKey: "score") != nil {
                    score.setValue(value, forKey: "score")
                    
                    do{
                        try context.save()
                    }catch{
                        print("Erro ao atualizar score")
                    }
                }
            }
        }
    } catch {
        print("Erro ao recuperar valor do score")
    }

}



// MARK: - Delete

func deleteAllRoundsCoreData() {
    let ordenacaoCrescente = NSSortDescriptor(key: "round", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let rounds = try context.fetch(requisicao)
        
        if rounds.count > 0 {
            for valor in rounds as! [NSManagedObject] {
                context.delete(valor)
                
                do{
                    try context.save()
                }catch{
                    print("Erro ao deletar round(s)")
                }
            }
        }
    } catch {
        print("Erro ao recuperar valor do round")
    }
}


func deleteAllScoresCoreData() {
    let ordenacaoCrescente = NSSortDescriptor(key: "score", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let scores = try context.fetch(requisicao)
        
        if scores.count > 0 {
            for score in scores as! [NSManagedObject] {
                context.delete(score)
                
                do{
                    try context.save()
                }catch{
                    print("Erro ao deletar score(s)")
                }
            }
        }
    } catch {
        print("Erro ao recuperar valor do score")
    }
}
