//
//  ViewController.swift
//  Tone
//
//  Created by Jefferson de Oliveira Lalor on 13/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


//Variables
    struct Songs{
        let nameFile: String
        let cifra: String
        let chordeName: String
    }
    let music: [Songs] = [
        Songs(nameFile: "A - Clean", cifra: "A", chordeName: "Lá"),
        Songs(nameFile: "B - Clean", cifra: "B", chordeName: "Sí"),
        Songs(nameFile: "C - Clean", cifra: "C", chordeName: "Dó"),
        Songs(nameFile: "D - Clean", cifra: "D", chordeName: "Ré"),
        Songs(nameFile: "E - Clean", cifra: "E", chordeName: "Mí"),
        Songs(nameFile: "F - Clean", cifra: "F", chordeName: "Fá"),
        Songs(nameFile: "G - Clean", cifra: "G", chordeName: "Sol"),
        Songs(nameFile: "A# - Clean", cifra: "A#", chordeName: "Lá sustenido"),
        Songs(nameFile: "C# - Clean", cifra: "C#", chordeName: "Dó sustenido"),
        Songs(nameFile: "D# - Clean", cifra: "D#", chordeName: "Ré sustenido"),
        Songs(nameFile: "F# - Clean", cifra: "F#", chordeName: "Fá sustenido"),
        Songs(nameFile: "G# - Clean", cifra: "G#", chordeName: "Sol sustenido"),
        Songs(nameFile: "Am - Clean", cifra: "Am", chordeName: "Lá menor"),
        Songs(nameFile: "Bm - Clean", cifra: "Bm", chordeName: "Sí menor"),
        Songs(nameFile: "Cm - Clean", cifra: "Cm", chordeName: "Dó menor"),
        Songs(nameFile: "Dm - Clean", cifra: "Dm", chordeName: "Ré menor"),
        Songs(nameFile: "Em - Clean", cifra: "Em", chordeName: "Mí menor"),
        Songs(nameFile: "Fm - Clean", cifra: "Fm", chordeName: "Fá menor"),
        Songs(nameFile: "Gm - Clean", cifra: "Gm", chordeName: "Sol menor"),
        Songs(nameFile: "A#m - Clean", cifra: "A#m", chordeName: "Lá sustenido menor"),
        Songs(nameFile: "C#m - Clean", cifra: "C#m", chordeName: "Dó sustenido menor"),
        Songs(nameFile: "D#m - Clean", cifra: "D#m", chordeName: "Ré sustenido menor"),
        Songs(nameFile: "F#m - Clean", cifra: "F#m", chordeName: "Fá sustenido menor"),
        Songs(nameFile: "G#m - Clean", cifra: "G#m", chordeName: "Sol sustenido menor"),

        
        /*
         
         Songs(nameFile: "Ab - Clean", cifra: "Ab", chordeName: "Lá bemol"),
         Songs(nameFile: "Bb - Clean", cifra: "Bb", chordeName: "Sí bemol"),
         Songs(nameFile: "Db - Clean", cifra: "Db", chordeName: "Ré bemol"),
         Songs(nameFile: "Eb - Clean", cifra: "Eb", chordeName: "Mí bemol"),
         Songs(nameFile: "Gb - Clean", cifra: "Gb", chordeName: "Sol bemol"),
         
         Songs(nameFile: "Abm - Clean", cifra: "Abm", chordeName: "Lá bemol menor"),
         Songs(nameFile: "Bbm - Clean", cifra: "Bbm", chordeName: "Sí bemol menor"),
         Songs(nameFile: "Dbm - Clean", cifra: "Dbm", chordeName: "Ré bemol menor"),
         Songs(nameFile: "Ebm - Clean", cifra: "Ebm", chordeName: "Mí bemol menor"),
         Songs(nameFile: "Gbm - Clean", cifra: "Gbm", chordeName: "Sol bemol menor"),
         
         */
    ]
    
    //Audio control
    var player = AVAudioPlayer()
    var errorAudio: Bool = false
    
    //Voice Siri
    let voice = AVSpeechSynthesisVoice(language: "pt-br")
    let spk = AVSpeechSynthesizer()

    //Time variable
    var timer = Timer()
    var time: Int = 30
    
    //Game variables
    var round = 0
    var ponctuation = 0
    var numberTry = 0
    var numberPassRound = 0
    var numberCancelOptions = 0
    var numberKingMode = 0
    var isKingMode: Bool = false
    var errouKingMode: Bool = false

    //Option variables
    var numberFile: Int = 0
    var indexOptions: [Int] = []
    var copyIndexOptions: [Int] = []
    var isSelectButton: [Bool?] = [false, false, false, false]


//Functions
    func loadNumberFile(){
        let qtMusics: Int = music.count
        numberFile = Int( arc4random_uniform(UInt32(qtMusics)) )
    }

    func prepareMusic(){
        let path = Bundle.main.path(forResource: music[numberFile].nameFile, ofType: "mp3")
        if path != nil {
            let url = URL(fileURLWithPath: path!)
            
            do{
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }catch{
                errorAudio = true
                alertMessage(title: "Error", message: "Error executing audio!")
            }
        }else{
            errorAudio = true
            alertMessage(title: "Error", message: "Audio file not found!")
        }
    }

    func prepareOptions(){
        indexOptions = []
        copyIndexOptions = []
        var existNumberRepeated: Bool
        
        indexOptions.append(numberFile)
        while indexOptions.count != 4 {
            existNumberRepeated = false
            let value: Int = Int( arc4random_uniform(UInt32(music.count)) )
            for index in indexOptions {
                if index == value {
                    existNumberRepeated  = true
                }
            }
            
            if !existNumberRepeated {
                indexOptions.append(value)
            }
        }
        copyIndexOptions = indexOptions
        indexOptions.sort()
        option01.text = music[indexOptions[0]].cifra
        option02.text = music[indexOptions[1]].cifra
        option03.text = music[indexOptions[2]].cifra
        option04.text = music[indexOptions[3]].cifra
    }

    func alertMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func applyDesignButtonDefault(button: UIButton!){
        button.backgroundColor = UIColor.buttonGreen
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = true
    }

    func applyDesignButtonSelected(button: UIButton!){
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.white, for: .normal)
    }

    func applyDesignButtonDesabled(button: UIButton!){
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.disableGray
        button.setTitleColor(UIColor.letterDisableGray, for: .normal)
        button.isEnabled = false
    }

    func updateButtons(numberButton: Int){
        if numberButton == 1 {
            applyDesignButtonSelected(button: btn_option01)
            if isSelectButton[1] != nil {
                applyDesignButtonDefault(button: btn_option02)
            }
            if isSelectButton[2] != nil {
                applyDesignButtonDefault(button: btn_option03)
            }
            if isSelectButton[3] != nil {
                applyDesignButtonDefault(button: btn_option04)
            }
        }else if numberButton == 2 {
            applyDesignButtonSelected(button: btn_option02)
            if isSelectButton[0] != nil {
                applyDesignButtonDefault(button: btn_option01)
            }
            if isSelectButton[2] != nil {
                applyDesignButtonDefault(button: btn_option03)
            }
            if isSelectButton[3] != nil {
                applyDesignButtonDefault(button: btn_option04)
            }
        }else if numberButton == 3 {
            applyDesignButtonSelected(button: btn_option03)
            if isSelectButton[0] != nil {
                applyDesignButtonDefault(button: btn_option01)
            }
            if isSelectButton[1] != nil {
                applyDesignButtonDefault(button: btn_option02)
            }
            if isSelectButton[3] != nil {
                applyDesignButtonDefault(button: btn_option04)
            }
        }else if numberButton == 4 {
            applyDesignButtonSelected(button: btn_option04)
            if isSelectButton[0] != nil {
                applyDesignButtonDefault(button: btn_option01)
            }
            if isSelectButton[1] != nil {
                applyDesignButtonDefault(button: btn_option02)
            }
            if isSelectButton[2] != nil {
                applyDesignButtonDefault(button: btn_option03)
            }
        }
        
        if !btn_verificar.isEnabled {
            btn_verificar.isEnabled = true
            applyDesignButtonDefault(button: btn_verificar)
        }
 
    }

    func startNewRound(){
        if isKingMode {
            if errouKingMode {
                ponctuation = ponctuation - Int(ponctuation/2)
            }
        }
        
        loadNumberFile()
        prepareOptions()
        prepareMusic()
        
        applyDesignButtonDesabled(button: btn_verificar)
        applyDesignButtonDefault(button: btn_option01)
        applyDesignButtonDefault(button: btn_option02)
        applyDesignButtonDefault(button: btn_option03)
        applyDesignButtonDefault(button: btn_option04)
        
        round += 1
        numberRounds.text = "Round: \(round)"
        score.text = "Score: \(ponctuation)"
        numberTry = 0
        errorAudio = false
        errouKingMode = false
        isSelectButton[0] = false
        isSelectButton[1] = false
        isSelectButton[2] = false
        isSelectButton[3] = false
    }

    func updateScore(){
        switch numberTry {
            case 0:
                if isKingMode && ponctuation != 0 {
                    ponctuation *= 2
                }else{
                    ponctuation += 200
                }
            case 1:
                if isKingMode && ponctuation != 0 {
                    ponctuation *= 2
                }else{
                    ponctuation += 150
                }
            case 2:
                if isKingMode && ponctuation != 0 {
                    ponctuation *= 2
                }else{
                    ponctuation += 100
            }
            default:
                if isKingMode && ponctuation != 0 {
                    ponctuation *= 2
                }else{
                    ponctuation += 50
                }
        }
    }

    func voiceSiri(text: String){
        if !errorAudio {
            player.stop()
            player.currentTime = 0
            let toSay = AVSpeechUtterance(string: text)
            toSay.voice = voice
            spk.speak(toSay)
        }
    }


//Outlets
    @IBOutlet weak var option01: UILabel!
    @IBOutlet weak var option02: UILabel!
    @IBOutlet weak var option03: UILabel!
    @IBOutlet weak var option04: UILabel!
    @IBOutlet weak var btn_verificar: UIButton!
    @IBOutlet weak var btn_option01: UIButton!
    @IBOutlet weak var btn_option02: UIButton!
    @IBOutlet weak var btn_option03: UIButton!
    @IBOutlet weak var btn_option04: UIButton!
    @IBOutlet weak var numberRounds: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var restartGame: UIButton!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var btn_sound: UIButton!
    @IBOutlet weak var touch: UILabel!
    @IBOutlet weak var btn_passRound: UIButton!
    @IBOutlet weak var btn_cancelTwoOptions: UIButton!
    @IBOutlet weak var lbl_messageTime: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var btn_kingMode: UIButton!
    
    
//Actions
    @IBAction func playSound(_ sender: Any) {
        prepareMusic()
        if !errorAudio {
            player.stop()
            player.currentTime = 0
            player.play()
            touch.text = nil
        }
    }

    @IBAction func selectButton01(_ sender: Any) {
        if btn_option01.isEnabled {
            isSelectButton[0] = true
            
            if isSelectButton[1] != nil {
                isSelectButton[1] = false
            }
            if isSelectButton[2] != nil {
                isSelectButton[2] = false
            }
            if isSelectButton[3] != nil {
                isSelectButton[3] = false
            }
            updateButtons(numberButton: 1)
            voiceSiri(text: music[indexOptions[0]].chordeName)
        }
    }

    @IBAction func selectButton02(_ sender: Any) {
        if btn_option02.isEnabled {
            isSelectButton[1] = true
            
            if isSelectButton[0] != nil {
                isSelectButton[0] = false
            }
            if isSelectButton[2] != nil {
                isSelectButton[2] = false
            }
            if isSelectButton[3] != nil {
                isSelectButton[3] = false
            }
            updateButtons(numberButton: 2)
            voiceSiri(text: music[indexOptions[1]].chordeName)
        }
    }

    @IBAction func selectButton03(_ sender: Any) {
        if btn_option03.isEnabled {
            isSelectButton[2] = true
            
            if isSelectButton[0] != nil {
                isSelectButton[0] = false
            }
            if isSelectButton[1] != nil {
                isSelectButton[1] = false
            }
            if isSelectButton[3] != nil {
                isSelectButton[3] = false
            }
            updateButtons(numberButton: 3)
            voiceSiri(text: music[indexOptions[2]].chordeName)
        }
    }

    @IBAction func selectButton04(_ sender: Any) {
        if btn_option04.isEnabled {
            isSelectButton[3] = true
            
            if isSelectButton[0] != nil {
                isSelectButton[0] = false
            }
            if isSelectButton[1] != nil {
                isSelectButton[1] = false
            }
            if isSelectButton[2] != nil {
                isSelectButton[2] = false
            }
            updateButtons(numberButton: 4)
            voiceSiri(text: music[indexOptions[3]].chordeName)
        }
    }

    @IBAction func passSound(_ sender: Any) {
        if numberPassRound <= 3 {
            loadNumberFile()
            prepareOptions()
            prepareMusic()
            
            applyDesignButtonDesabled(button: btn_verificar)
            applyDesignButtonDefault(button: btn_option01)
            applyDesignButtonDefault(button: btn_option02)
            applyDesignButtonDefault(button: btn_option03)
            applyDesignButtonDefault(button: btn_option04)
            
            numberRounds.text = "Round: \(round)"
            score.text = "Score: \(ponctuation)"
            numberTry = 0
            errorAudio = false
            numberPassRound += 1
            
            if numberPassRound == 3 {
                btn_passRound.isEnabled = false
            }
        }
    }
    
    @IBAction func cancelTwoOptions(_ sender: Any) {
        if numberCancelOptions <= 3 && copyIndexOptions.count != 2{
            copyIndexOptions.remove(at: 1)
            copyIndexOptions.remove(at: 1)
            
            for index in indexOptions {
                if index != copyIndexOptions[0] && index != copyIndexOptions[1] {
                    if indexOptions[0] == index {
                        applyDesignButtonDesabled(button: btn_option01)
                        isSelectButton[0] = nil
                    } else if indexOptions[1] == index {
                        applyDesignButtonDesabled(button: btn_option02)
                        isSelectButton[1] = nil
                    } else if indexOptions[2] == index {
                        applyDesignButtonDesabled(button: btn_option03)
                        isSelectButton[2] = nil
                    } else if indexOptions[3] == index {
                        applyDesignButtonDesabled(button: btn_option04)
                        isSelectButton[3] = nil
                    }
                }
            }
            numberCancelOptions += 1
            
            if numberCancelOptions == 3 {
                btn_cancelTwoOptions.isEnabled = false
            }
        }
    }
    
    @IBAction func kingMode(_ sender: Any) {
        if numberKingMode < 2 {
            isKingMode = true
            btn_cancelTwoOptions.isEnabled = false
            btn_passRound.isEnabled = false
            btn_kingMode.isEnabled = false
            //função para mudar as cores do layout do kingMode
            numberKingMode += 1
            lbl_messageTime.text = "KING MODE"
            lbl_time.text = "\(time)"
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                         selector: #selector(ViewController.action), userInfo: nil, repeats: true)
        }
    }
    @objc func action() {
        if time >= 0 {
            lbl_time.text = String(time)
            time -= 1
        }else{
            //voltar layout para cores default
            timer.invalidate()
            lbl_messageTime.text = "Hit the chord"
            lbl_time.text = "-"
            btn_cancelTwoOptions.isEnabled = false
            if numberCancelOptions != 3 {
                btn_cancelTwoOptions.isEnabled = true
            }
            if numberPassRound != 3 {
                btn_passRound.isEnabled = true
            }
            time = 30
            isKingMode = false
            if numberKingMode == 2 {
                btn_kingMode.isEnabled = false
            }else{
                btn_kingMode.isEnabled = true
            }

        }
    }
    
    @IBAction func checkAnswer(_ sender: Any) {
        if !errorAudio {
            let options: [UILabel?] = [option01, option02, option03, option04]
            var i: Int = 0
            
            for option in options {
                if isSelectButton[i] != nil {
                    if isSelectButton[i]! {
                        if option!.text == music[numberFile].cifra {
                            alertMessage(title: "Congratulations!", message: "Right answer.")
                            updateScore()
                            startNewRound()
                        }else{
                            alertMessage(title: "Ops!", message: "Incorrect answer.")
                            numberTry += 1
                            if isKingMode {
                                errouKingMode = true
                                startNewRound()
                            }
                        }
                    }
                }
                i+=1
            }
            
        }else{
            alertMessage(title: "Error", message: "Audio file error. \nNo possibility of verification!")
        }
    }

    @IBAction func restartGame(_ sender: Any) {
        ponctuation = 0
        round = 0
        numberTry = 0
        numberPassRound = 0
        numberCancelOptions = 0
        numberKingMode = 0
        startNewRound()
        touch.text = "Touch here!"
        btn_passRound.isEnabled = true
        btn_cancelTwoOptions.isEnabled = true
        btn_kingMode.isEnabled = true
        timer.invalidate()
        time = 30
        lbl_messageTime.text = "Hit the chord"
        lbl_time.text = "-"
    }

    @IBAction func informationGame(_ sender: Any) {
        alertMessage(title: "Game informations", message: "\nWhen listen the chord, select the option corresponding. \n\nScore \nFirst attempt: 200 points \nSecond attempt: 150 pontos \nThird attempt: 100 points \nFourth or more attempts: 50 points")
    }


//Default
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent //status bar branca
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


/*
    Correções
 
    Adicionar som dos bemois e preparar o código para não haver conflitos
    Mudar layout no King Mode
    Indicar quantas tentativas o jogador tem
    Mudar fontes
    Indicar buttons de ajuda
 */

/*
    For future
 
    Repensar nas telas junto aos planos para o futuro
    Auto layout
    Ranking
    Conexão com redes sociais
    Níveis
 */













