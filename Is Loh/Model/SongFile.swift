//
//  SongFileViewController.swift
//  SoundTone
//
//  Created by Jefferson de Oliveira Lalor on 16/11/18.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class SongFile {
    
    var nameFile: String
    var cifra: String
    var chordeName: String

    
    init(nameFile: String, cifra: String, chordeName: String) {
        self.nameFile = nameFile
        self.cifra = cifra
        self.chordeName = chordeName
    }
}


let music: [SongFile] = [
    SongFile.init(nameFile: "A - Clean", cifra: "A", chordeName: NSLocalizedString("A major", comment: "Lá maior")),
    SongFile.init(nameFile: "B - Clean", cifra: "B", chordeName: NSLocalizedString("B major", comment: "Sí maior")),
    SongFile.init(nameFile: "C - Clean", cifra: "C", chordeName: NSLocalizedString("C major", comment: "Dó maior")),
    SongFile.init(nameFile: "D - Clean", cifra: "D", chordeName: NSLocalizedString("D major", comment: "Ré maior")),
    SongFile.init(nameFile: "E - Clean", cifra: "E", chordeName: NSLocalizedString("E major", comment: "Mí maior")),
    SongFile.init(nameFile: "F - Clean", cifra: "F", chordeName: NSLocalizedString("F major", comment: "Fá maior")),
    SongFile.init(nameFile: "G - Clean", cifra: "G", chordeName: NSLocalizedString("G major", comment: "Sol maior")),

    SongFile.init(nameFile: "Am - Clean", cifra: "Am", chordeName: NSLocalizedString("A minor", comment: "Lá menor")),
    SongFile.init(nameFile: "Bm - Clean", cifra: "Bm", chordeName: NSLocalizedString("B minor", comment: "Sí menor")),
    SongFile.init(nameFile: "Cm - Clean", cifra: "Cm", chordeName: NSLocalizedString("C minor", comment: "Dó menor")),
    SongFile.init(nameFile: "Dm - Clean", cifra: "Dm", chordeName: NSLocalizedString("D minor", comment: "Ré menor")),
    SongFile.init(nameFile: "Em - Clean", cifra: "Em", chordeName: NSLocalizedString("E minor", comment: "Mí menor")),
    SongFile.init(nameFile: "Fm - Clean", cifra: "Fm", chordeName: NSLocalizedString("F minor", comment: "Fá menor")),
    SongFile.init(nameFile: "Gm - Clean", cifra: "Gm", chordeName: NSLocalizedString("G minor", comment: "Sol menor")),

    SongFile.init(nameFile: "A# - Clean", cifra: "A#", chordeName: NSLocalizedString("A sharp", comment: "Lá sustenido")),
    SongFile.init(nameFile: "C# - Clean", cifra: "C#", chordeName: NSLocalizedString("C sharp", comment: "Dó sustenido")),
    SongFile.init(nameFile: "D# - Clean", cifra: "D#", chordeName: NSLocalizedString("D sharp", comment: "Ré sustenido")),
    SongFile.init(nameFile: "F# - Clean", cifra: "F#", chordeName: NSLocalizedString("F sharp", comment: "Fá sustenido")),
    SongFile.init(nameFile: "G# - Clean", cifra: "G#", chordeName: NSLocalizedString("G sharp", comment: "Sol sustenido")),

    SongFile.init(nameFile: "A#m - Clean", cifra: "A#m", chordeName: NSLocalizedString("A sharp minor", comment: "Lá sustenido menor")),
    SongFile.init(nameFile: "C#m - Clean", cifra: "C#m", chordeName: NSLocalizedString("C sharp minor", comment: "Dó sustenido menor")),
    SongFile.init(nameFile: "D#m - Clean", cifra: "D#m", chordeName: NSLocalizedString("D sharp minor", comment: "Ré sustenido menor")),
    SongFile.init(nameFile: "F#m - Clean", cifra: "F#m", chordeName: NSLocalizedString("F sharp minor", comment: "Fá sustenido menor")),
    SongFile.init(nameFile: "G#m - Clean", cifra: "G#m", chordeName: NSLocalizedString("G sharp minor", comment: "Sol sustenido menor")),

]
