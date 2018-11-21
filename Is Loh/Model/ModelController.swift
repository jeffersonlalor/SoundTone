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
    print("Salva valor de round")
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
    print("Salva valor de score")
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
    print("Retorna valor de round")
    let ordenacaoCrescente = NSSortDescriptor(key: "round", ascending: true)

    requisicao.sortDescriptors = [ordenacaoCrescente]

    do {
        let rounds = try context.fetch(requisicao)
        
        if rounds.count > 0 {
            for valor in rounds as! [NSManagedObject] {
                if let valueRound = valor.value(forKey: "round"){
                    print(valueRound)
                    return valueRound as! Int
                }
            }
        } else {
            print("Nenhum valor de round encontrado")
        }
        
    } catch {
        print("Erro ao recuperar valor do round")
    }
    
    
    return 0
}


func valueScoreCoreData() -> Int {
    print("Retorna valor de Score")
    let ordenacaoCrescente = NSSortDescriptor(key: "score", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let scores = try context.fetch(requisicao)
        
        if scores.count > 0 {
            for score in scores as! [NSManagedObject] {
                if let valueScore = score.value(forKey: "score"){
                    print(valueScore)
                    return valueScore as! Int
                }
            }
        } else {
            print("Nenhum valor de score encontrado")
        }
        
    } catch {
        print("Erro ao recuperar valor do score")
    }
    

    return 0
}



// MARK: - Update

func updateRoundCoreData( value: Int ) {
    print("Atualiza todos os rounds")
    let ordenacaoCrescente = NSSortDescriptor(key: "round", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let rounds = try context.fetch(requisicao)
        
        if rounds.count > 0 {
            for valor in rounds as! [NSManagedObject] {
                if let valueRound = valor.value(forKey: "round"){
                    print(valueRound)
                    valor.setValue(value, forKey: "round")
                    
                    do{
                        try context.save()
                        print("Sucesso ao atualizar round")
                    }catch{
                        print("Erro ao atualizar round")
                    }
                }
            }
        } else {
            print("Nenhum valor de round encontrado")
        }
        
    } catch {
        print("Erro ao recuperar valor do round")
    }
}


func updateScoreCoreData( value: Int ) {
    print("Atualizar todos os score")
    let ordenacaoCrescente = NSSortDescriptor(key: "score", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let scores = try context.fetch(requisicao)
        
        if scores.count > 0 {
            for score in scores as! [NSManagedObject] {
                if let valueScore = score.value(forKey: "score"){
                    print(valueScore)
                    score.setValue(value, forKey: "score")
                    
                    do{
                        try context.save()
                        print("Sucesso ao atualizar score")
                    }catch{
                        print("Erro ao atualizar score")
                    }
                }
            }
        } else {
            print("Nenhum valor de score encontrado")
        }
    } catch {
        print("Erro ao recuperar valor do score")
    }

}



// MARK: - Delete

func deleteAllRoundsCoreData() {
    print("Deletar Todos os Rounds")
    let ordenacaoCrescente = NSSortDescriptor(key: "round", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let rounds = try context.fetch(requisicao)
        
        if rounds.count > 0 {
            for valor in rounds as! [NSManagedObject] {
                context.delete(valor)
                
                do{
                    try context.save()
                    print("Sucesso ao remover round(s)")
                }catch{
                    print("Erro ao deletar round(s)")
                }
            }
        } else {
            print("Nenhum valor de round encontrado")
        }
        
    } catch {
        print("Erro ao recuperar valor do round")
    }
}


func deleteAllScoresCoreData() {
    print("Deletar Todos os Score")
    let ordenacaoCrescente = NSSortDescriptor(key: "score", ascending: true)
    
    requisicao.sortDescriptors = [ordenacaoCrescente]
    
    do {
        let scores = try context.fetch(requisicao)
        
        if scores.count > 0 {
            for score in scores as! [NSManagedObject] {
                context.delete(score)
                
                do{
                    try context.save()
                    print("Sucesso ao remover score(s)")
                }catch{
                    print("Erro ao deletar score(s)")
                }
            }
        } else {
            print("Nenhum valor de score encontrado")
        }
        
    } catch {
        print("Erro ao recuperar valor do score")
    }
}
