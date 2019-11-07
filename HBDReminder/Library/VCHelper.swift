//
//  VCHelper.swift
//  HBDReminder
//
//  Created by armin on 11/7/19.
//  Copyright © 2019 shalchian. All rights reserved.
//

import UIKit

extension Date {
    
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

func calculateAge(birthday: Date) -> Int {
    let now = Date()
    let calendar = Calendar.current

    let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
    let age = ageComponents.year!
    return age
}

func calculateDaysLeft(birthday: Date) -> String {
    let cal = Calendar.current
    let today = cal.startOfDay(for: Date())
    let dayAndMonth = cal.dateComponents([.day, .month], from: birthday)
    let nextBirthDay = cal.nextDate(after: today, matching: dayAndMonth,
                                    matchingPolicy: .nextTimePreservingSmallerComponents)!

    let diff = cal.dateComponents([.day], from: today, to: nextBirthDay)
    return String(diff.day!)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
