//
//  ViewController.swift
//  SoundTone
//
//  Created by Jefferson de Oliveira Lalor on 13/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
// MARK: - Variáveis de controle de áudio
    var player = AVAudioPlayer()
    var errorAudio: Bool = false
    
    
// MARK: - Variáveis de controle da Voice Siri
    let voice = AVSpeechSynthesisVoice(language: NSLocalizedString("en-us", comment: "Traduzir para pt-br"))
    let spk = AVSpeechSynthesizer()

    
// MARK: - Variáveis de tempo
    var timer = Timer()
    var time: Int = 30
    
    
// MARK: - Variáveis de jogabilidade
    var numberTry = 0
    var numberPassRound = 0
    var numberCancelOptions = 0
    var numberKingMode = 0
    var isKingMode: Bool = false
    var errouKingMode: Bool = false
    var isFirstAcess: Bool = true

    
// MARK: - Variáveis de controle de opção
    var numberFile: Int = 0
    var indexOptions: [Int] = []
    var copyIndexOptions: [Int] = []
    var isSelectButton: [Bool?] = [false, false, false, false]

    
// MARK: - Outlets
    @IBOutlet weak var btn_verificar: UIButton!
    @IBOutlet weak var btn_option01: UIButton!
    @IBOutlet weak var btn_option02: UIButton!
    @IBOutlet weak var btn_option03: UIButton!
    @IBOutlet weak var btn_option04: UIButton!
    @IBOutlet weak var numberRounds: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var restartGame: UIButton!
    @IBOutlet weak var btn_sound: UIButton!
    @IBOutlet weak var touch: UILabel!
    @IBOutlet weak var btn_passRound: UIButton!
    @IBOutlet weak var btn_cancelTwoOptions: UIButton!
    @IBOutlet weak var lbl_messageTime: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var btn_kingMode: UIButton!


// MARK: - Funcões
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
                alertMessage(title: NSLocalizedString("Error", comment: "Mensagem curta de erro"), message: NSLocalizedString("Error executing audio!", comment: "Mensagem informando erro na execução do áudio."))
            }
        }else{
            errorAudio = true
            alertMessage(title: NSLocalizedString("Error", comment: "Mensagem curta informando erro"), message: NSLocalizedString("Audio file not found!", comment: "Tradução curta informando erro no audio."))
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
        
        btn_option01.setTitle(music[indexOptions[0]].cifra, for: .normal)
        btn_option02.setTitle(music[indexOptions[1]].cifra, for: .normal)
        btn_option03.setTitle(music[indexOptions[2]].cifra, for: .normal)
        btn_option04.setTitle(music[indexOptions[3]].cifra, for: .normal)
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
        if !lbl_time.isHidden {
            lbl_time.isHidden = true
        }
        
        if isKingMode {
            if errouKingMode {
                updateScoreCoreData( value: valueScoreCoreData()! - Int(valueScoreCoreData()!/2) )
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
        
        if valueRoundCoreData() == nil {
            saveRoundCoreData(value: 1)
        }else if !isFirstAcess {
            updateRoundCoreData(value: valueRoundCoreData()! + 1 )
        }
        
        isFirstAcess = false
        numberRounds.text = String(format: NSLocalizedString("Round: %d", comment: "Palavra especificando a label de rodada."), valueRoundCoreData()!)
        
        if valueScoreCoreData() == nil {
            saveScoreCoreData(value: 0)
        }
        
        score.text = String(format: NSLocalizedString("Score: %d", comment: "Palavra especficando a pontuação do jogador."), valueScoreCoreData()!)
        
        
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
                if isKingMode && valueScoreCoreData() != 0 {
                    updateScoreCoreData(value: valueScoreCoreData()! * 2)
                }else{
                    updateScoreCoreData(value: valueScoreCoreData()! + 200)
                }
            case 1:
                if isKingMode && valueScoreCoreData() != 0 {
                    updateScoreCoreData(value: valueScoreCoreData()! * 2)
                }else{
                    updateScoreCoreData(value: valueScoreCoreData()! + 150)
                }
            case 2:
                if isKingMode && valueScoreCoreData() != 0 {
                    updateScoreCoreData(value: valueScoreCoreData()! * 2)
                }else{
                    updateScoreCoreData(value: valueScoreCoreData()! + 100)
            }
            default:
                if isKingMode && valueScoreCoreData() != 0 {
                    updateScoreCoreData(value: valueScoreCoreData()! * 2)
                }else{
                    updateScoreCoreData(value: valueScoreCoreData()! + 50)
                }
        }
    }

    
    func voiceSiri(text: String){
        if !errorAudio {
            player.stop()
            player.currentTime = 0
            let toSay = AVSpeechUtterance(string: text)
            spk.stopSpeaking(at: AVSpeechBoundary.immediate)
            toSay.voice = voice
            spk.speak(toSay)
        }
    }
    
    
    
//MARK: - Actions
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
            
            numberRounds.text = String(format: NSLocalizedString("Round: %d", comment: "Palavra especificando a label de rodada."), valueRoundCoreData()!)
            score.text = String(format: NSLocalizedString("Score: %d", comment: "Palavra especficando a pontuação do jogador."), valueScoreCoreData()!)
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
            if lbl_time.isHidden {
                lbl_time.isHidden = false
            }
            btn_cancelTwoOptions.isEnabled = false
            btn_passRound.isEnabled = false
            btn_kingMode.isEnabled = false
            //função para mudar as cores do layout do kingMode
            numberKingMode += 1
            lbl_messageTime.text = NSLocalizedString("KING MODE", comment: "Frase curta em maiúsculo indicando o modo de jogo rei.")
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
            lbl_messageTime.text = NSLocalizedString("Hit the chord", comment: "Frase curta indicando que o usuário deve acertar o acorde.")
            lbl_time.text = "-"
            lbl_time.isHidden = true
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
            let options: [UIButton?] = [btn_option01, btn_option02, btn_option03, btn_option04]
            var i: Int = 0

            for option in options {
                if isSelectButton[i] != nil {
                    if isSelectButton[i]! {
                        if option?.titleLabel?.text == music[numberFile].cifra {
                            alertMessage(title: NSLocalizedString("Congratulations!", comment: "Mensagem de felicidade, acerto. Tem que ser curta."), message: NSLocalizedString("Right answer.", comment: "Frase curta para resposta correta."))
                            updateScore()
                            startNewRound()
                        }else{
                            alertMessage(title: "Ops!", message: NSLocalizedString("Incorrect answer.", comment: "Frase curta para resposta incorreta."))
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
            alertMessage(title: NSLocalizedString("Error", comment: "Frase curta de erro"), message: NSLocalizedString("Audio file error. \nNo possibility of verification!", comment: "Frases curtas especificando o erro."))
        }
    }

    @IBAction func restartGame(_ sender: Any) {
        updateScoreCoreData(value: 0)
        updateRoundCoreData(value: 0)
        numberTry = 0
        numberPassRound = 0
        numberCancelOptions = 0
        numberKingMode = 0
        startNewRound()
        touch.text = NSLocalizedString("Touch here!", comment: "Frase curta")
        btn_passRound.isEnabled = true
        btn_cancelTwoOptions.isEnabled = true
        btn_kingMode.isEnabled = true
        timer.invalidate()
        time = 30
        lbl_messageTime.text = NSLocalizedString("Hit the chord", comment: "Frase curta")
        lbl_time.text = "-"
    }

    @IBAction func informationGame(_ sender: Any) {
        let phase1 = NSLocalizedString("When listen the chord, select the option corresponding.", comment: "Traduzir para passar instruções")
        let phase2 = NSLocalizedString("Score", comment: "Pontos")
        let phase3 = NSLocalizedString("First attempt: 200 points", comment: "Tentativa 1")
        let phase4 = NSLocalizedString("Second attempt: 150 points", comment: "Tentativa 2")
        let phase5 = NSLocalizedString("Third attempt: 100 points", comment: "Tentativa 3")
        let phase6 = NSLocalizedString("Fourth or more attempts: 50 points", comment: "Tentativa 4")
        
        alertMessage(title: NSLocalizedString("Game informations", comment: "Frase curta / informativo"), message: String(format: "\n%@ \n\n%@ \n%@ \n%@ \n%@ \n%@", phase1, phase2, phase3, phase4, phase5, phase6))
    }


    
    
//MARK: - Default System Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
