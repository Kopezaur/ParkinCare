//
//  Prescription.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/20/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation

// ----- Specification fonctionelle :
//
// dateTime: Prescription -> DateTime
// La date et l’heure a laquelle l’utilisateur doit prendre ses
// medicaments
//
// medicament: Prescription -> Medicament
// Le medicament que doit prendre l’utilisateur
//
// quantity: Prescription -> Integer
// La quantite de medicament a prendre
//
// validated: Prescription : Boolean
// Indique si l’utilisateur a pris son/ses medicaments
//
// reminder: Prescription -> Reminder
// Le rappel lie a la prescription
//
// isForgotten: Prescription -> Boolean
// Indique si la date de la prescription est depassee et que
// l’utilisateur n’a pas pris ses medicaments
//
// changeDateTime: Prescription x DateTime -> Prescription
// Pre : la date entre doit etre superieur a la date du jour
// Change la date de la description
//
// changeQuantity: Prescription x Integer -> Prescription
// Pre : L’entier entre doit etre superieur a 0
// Change la quantitee de medicament de la prescription
//
// validate: Prescription -> Prescription
// Pre: Il faut que la date de la prescription soit inferieur a la
// date du moment
// Indique que l’utilisateur a bien pris ses medicaments


class Prescription{
    
}
