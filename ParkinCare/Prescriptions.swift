//
//  Prescriptions.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/20/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation

// ----- Specification fonctionelle
//
// addPrescription: Prescriptions x Prescription -> Prescriptions
// Ajoute la prescription entrée aux autres prescription
//
// delPrescription: Prescriptions x Prescription -> Prescriptions
// Pre : Ne fonctionne que si la prescription est presente dans la
// collection sinon ne fait rien du tout.
// Res : Retourne les prescriptions sans la prescription mise en
// parametre
//
// getLastPrescriptions: Prescriptions x Date -> Prescriptions
// Pre : La date entrée doit être inférieur à la date du jour.
// Res: Toute les prescriptions entre la date entree et la date du
// jour
//
// getFuturePrescriptions: Prescriptions -> Prescriptions
// Res : Toute les prescriptions qui ont une date supérieur à
// celle du jour
//
// makeIterator : Prescription -> ItPrescriptions
// Res : Cree un iterateur pour Prescription
//
// reminder: Activity -> Boolean
// Indique si l’activite doit etre rappele


class Prescriptions {
    
}
