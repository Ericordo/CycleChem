//
//  MoleculeBank.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 30/01/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import Foundation
import UIKit

class MoleculeBank {
    var list = [Molecule]()
    
    init() {
        let pyridine = Molecule(moleculeName: "Pyridine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pyridine")!)
        let pyridazine = Molecule(moleculeName: "Pyridazine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pyridazine")!)
        let indole = Molecule(moleculeName: "Indole", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "indole")!)
        let benzofuran = Molecule(moleculeName: "Benzofuran", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 1, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "benzofuran")!)
        let morpholine = Molecule(moleculeName: "Morpholine", ringSize: 6, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "morpholine")!)
        let piperazine = Molecule(moleculeName: "Piperazine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "piperazine")!)
        let piperidine = Molecule(moleculeName: "Piperidine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "piperidine")!)
        let pyran = Molecule(moleculeName: "Pyran", ringSize: 6, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pyran")!)
        let benzimidazole = Molecule(moleculeName: "Benzimidazole", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "benzimidazole")!)
        let triazole = Molecule(moleculeName: "1,2,4-Triazole", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 3, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "1,2,4-triazole")!)
        let tetrazine = Molecule(moleculeName: "1,2,4,5-Tetrazine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 4, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "1,2,4,5-tetrazine")!)
        let dioxolane = Molecule(moleculeName: "1,3-Dioxolane", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 2, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "1,3-dioxolane")!)
        let triazine = Molecule(moleculeName: "1,3,5-Triazine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 3, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "1,3,5-triazine")!)
        let dithiane = Molecule(moleculeName: "1,4-Dithiane", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: false, nitrogenCount: 0, hasSulfur: true, sulfurCount: 2, isSaturated: true, image: UIImage(named: "1,4-dithiane")!)
        let chromone = Molecule(moleculeName: "4-Chromone", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 2, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "4-chromone")!)
        let azetidine = Molecule(moleculeName: "Azetidine", ringSize: 4, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "azetidine")!)
        let aziridine = Molecule(moleculeName: "Aziridine", ringSize: 3, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "aziridine")!)
        let benzoxazole = Molecule(moleculeName: "Benzoxazole", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 1, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "benzoxazole")!)
        let benzoxazolone = Molecule(moleculeName: "Benzoxazolone", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 2, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "benzoxazolone")!)
        let furazan = Molecule(moleculeName: "Furazan", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "furazan")!)
        let chromene = Molecule(moleculeName: "Chromene", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 1, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "chromene")!)
        let cinnoline = Molecule(moleculeName: "Cinnoline", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "cinnoline")!)
        let coumarin = Molecule(moleculeName: "Coumarin", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 2, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "coumarin")!)
        let dbu = Molecule(moleculeName: "DBU", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "dbu")!)
        let dioxane = Molecule(moleculeName: "Dioxane", ringSize: 6, ringCount: 1, hasOxygen: true, oxygenCount: 2, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "dioxane")!)
        let flavone = Molecule(moleculeName: "Flavone", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 2, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "flavone")!)
        let furan = Molecule(moleculeName: "Furan", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "furan")!)
        let imidazole = Molecule(moleculeName: "Imidazole", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "imidazole")!)
        let indazole = Molecule(moleculeName: "Indazole", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "indazole")!)
        let indoline = Molecule(moleculeName: "Indoline", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 1, isSaturated: false, image: UIImage(named: "indoline")!)
        let indolizine = Molecule(moleculeName: "Indolizine", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "indolizine")!)
        let isatin = Molecule(moleculeName: "Isatin", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 2, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "isatin")!)
        let isoindole = Molecule(moleculeName: "Isoindole", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "isoindole")!)
        let isoindoline = Molecule(moleculeName: "Isoindoline", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "isoindoline")!)
        let isoquinoline = Molecule(moleculeName: "Isoquinoline", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "isoquinoline")!)
       let isoxazole = Molecule(moleculeName: "Isoxazole", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "isoxazole")!)
        let naphthyridine = Molecule(moleculeName: "Naphthyridine", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "naphthyridine")!)
        let oxazole = Molecule(moleculeName: "Oxazole", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "oxazole")!)
        let oxazolidinone = Molecule(moleculeName: "Oxazolidinone", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 2, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "oxazolidinone")!)
        let oxazoline = Molecule(moleculeName: "Oxazoline", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "oxazoline")!)
        let oxazolone = Molecule(moleculeName: "Oxazolone", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 2, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "oxazolone")!)
        let oxetane = Molecule(moleculeName: "Oxetane", ringSize: 4, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "oxetane")!)
        
        let oxindole = Molecule(moleculeName: "Oxindole", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 1, hasNitrogen: false, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "oxindole")!)
        let oxirane = Molecule(moleculeName: "Oxirane", ringSize: 3, ringCount: 1, hasOxygen: true, oxygenCount: 1, hasNitrogen: false, nitrogenCount: 0, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "oxirane")!)
        let phthalazine = Molecule(moleculeName: "Phthalazine", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "phthalazine")!)
        let phthalimide = Molecule(moleculeName: "Phthalimide", ringSize: 0, ringCount: 2, hasOxygen: true, oxygenCount: 2, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "phthalimide")!)
        let pteridine = Molecule(moleculeName: "Pteridine", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 4, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pteridine")!)
        let pyrazine = Molecule(moleculeName: "Pyrazine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pyrazine")!)
        let pyrazole = Molecule(moleculeName: "Pyrazole", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pyrazole")!)
        let pyrimidine = Molecule(moleculeName: "Pyrimidine", ringSize: 6, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pyrimidine")!)
        let pyrrole = Molecule(moleculeName: "Pyrrole", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "pyrrole")!)
        let pyrrolidine = Molecule(moleculeName: "Pyrrolidine", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "pyrrolidine")!)
        let quinazoline = Molecule(moleculeName: "Quinazoline", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "quinazoline")!)
        let quinoline = Molecule(moleculeName: "Quinoline", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "quinoline")!)
        let quinoxaline = Molecule(moleculeName: "Quinoxaline", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 2, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "quinoxaline")!)
        let quinuclidine = Molecule(moleculeName: "Quinuclidine", ringSize: 0, ringCount: 2, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "quinuclidine")!)
        let tetrazole = Molecule(moleculeName: "Tetrazole", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 4, hasSulfur: false, sulfurCount: 0, isSaturated: false, image: UIImage(named: "tetrazole")!)
        let thiazole = Molecule(moleculeName: "Thiazole", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: true, nitrogenCount: 1, hasSulfur: true, sulfurCount: 1, isSaturated: false, image: UIImage(named: "thiazole")!)
        let thiazolidinedione = Molecule(moleculeName: "Thiazolidinedione", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 2, hasNitrogen: true, nitrogenCount: 1, hasSulfur: true, sulfurCount: 1, isSaturated: true, image: UIImage(named: "thiazolidinedione")!)
        let thiophene = Molecule(moleculeName: "Thiophene", ringSize: 5, ringCount: 1, hasOxygen: false, oxygenCount: 0, hasNitrogen: false, nitrogenCount: 0, hasSulfur: true, sulfurCount: 1, isSaturated: false, image: UIImage(named: "thiophene")!)
        let urazole = Molecule(moleculeName: "Urazole", ringSize: 5, ringCount: 1, hasOxygen: true, oxygenCount: 2, hasNitrogen: true, nitrogenCount: 3, hasSulfur: false, sulfurCount: 0, isSaturated: true, image: UIImage(named: "urazole")!)
        
        list.append(pyridine)
        list.append(pyridazine)
        list.append(indole)
        list.append(benzofuran)
        list.append(morpholine)
        list.append(piperazine)
        list.append(piperidine)
        list.append(pyran)
        list.append(benzimidazole)
        list.append(triazole)
        list.append(tetrazine)
        list.append(dioxolane)
        list.append(triazine)
        list.append(dithiane)
        list.append(chromone)
        list.append(azetidine)
        list.append(aziridine)
        list.append(benzoxazole)
        list.append(benzoxazolone)
        list.append(furazan)
        list.append(chromene)
        list.append(cinnoline)
        list.append(coumarin)
        list.append(dbu)
        list.append(dioxane)
        list.append(flavone)
        list.append(furan)
        list.append(imidazole)
        list.append(indazole)
        list.append(indoline)
        list.append(indolizine)
        list.append(isatin)
        list.append(isoindole)
        list.append(isoindoline)
        list.append(isoquinoline)
        list.append(isoxazole)
        list.append(naphthyridine)
        list.append(oxazole)
        list.append(oxazolidinone)
        list.append(oxazoline)
        list.append(oxazolone)
        list.append(oxetane)
        list.append(oxindole)
        list.append(oxirane)
        list.append(phthalazine)
        list.append(phthalimide)
        list.append(pteridine)
        list.append(pyrazine)
        list.append(pyrazole)
        list.append(pyrimidine)
        list.append(pyrrole)
        list.append(pyrrolidine)
        list.append(quinazoline)
        list.append(quinoline)
        list.append(quinoxaline)
        list.append(quinuclidine)
        list.append(tetrazole)
        list.append(thiazole)
        list.append(thiazolidinedione)
        list.append(thiophene)
        list.append(urazole)
    
    }

}


