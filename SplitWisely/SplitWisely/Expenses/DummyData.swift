//
//  DummyData.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 04/10/25.
//

import SwiftUI

public struct DummyData {
    
    var participants : [ParticipantCardView.DisplayItem] = [
        ParticipantCardView.DisplayItem(
            id: 1,
            name: "Alice Johnson",
            description: "Team Lead",
            image: Image(systemName: "person.circle.fill"),
            expense: nil,
            trailingView: .multiSelect(isSelected: true)
        ),
        ParticipantCardView.DisplayItem(
            id: 2,
            name: "Bob Kumar",
            description: "iOS Developer",
            image: Image(systemName: "person.circle.fill"),
            expense: nil,
            trailingView: .multiSelect(isSelected: false)
        ),
        ParticipantCardView.DisplayItem(
            id: 3,
            name: "Catherine Lee",
            description: "Designer",
            image: Image(systemName: "person.circle.fill"),
            expense: nil,
            trailingView: .singleSelect(isSelected: false)
        ),
        ParticipantCardView.DisplayItem(
            id: 4,
            name: "David Tanaka",
            description: "QA Engineer",
            image: Image(systemName: "person.circle.fill"),
            expense: nil,
            trailingView: .singleSelect(isSelected: true)
        ),
        ParticipantCardView.DisplayItem(
            id: 5,
            name: "Evelyn Smith",
            description: "Intern",
            image: Image(systemName: "person.circle"),
            expense: nil,
            trailingView: .none
        )
    ]

    var expenses : [ExpenseCardView.DisplayItem] = [
        ExpenseCardView.DisplayItem(
            id: 0,
            title: "Lunch Bill",
            description: "Day 1 lunch at Taj Coram",
            expense: Amount(value: 1000, currencyCode: "INR"),
            type: .borrowed,
            date: Date()
        ),
        ExpenseCardView.DisplayItem(
            id: 1,
            title: "Cab Fare",
            description: "Airport to hotel ride",
            expense: Amount(value: -750, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 2,
            title: "Dinner",
            description: "Seafood restaurant with team",
            expense: Amount(value: 2200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 3,
            title: "Snacks",
            description: "Cafe coffee and snacks",
            expense: Amount(value: -350, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 4,
            title: "Hotel Stay",
            description: "2 nights at Marriott",
            expense: Amount(value: 7200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 5,
            title: "Lunch Bill",
            description: "Day 1 lunch at Taj Coram",
            expense: Amount(value: 1000, currencyCode: "INR"),
            type: .borrowed,
            date: Date()
        ),
        ExpenseCardView.DisplayItem(
            id: 6,
            title: "Cab Fare",
            description: "Airport to hotel ride",
            expense: Amount(value: -750, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 7,
            title: "Dinner",
            description: "Seafood restaurant with team",
            expense: Amount(value: 2200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 8,
            title: "Snacks",
            description: "Cafe coffee and snacks",
            expense: Amount(value: -350, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 9,
            title: "Hotel Stay",
            description: "2 nights at Marriott",
            expense: Amount(value: 7200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 10,
            title: "Lunch Bill",
            description: "Day 1 lunch at Taj Coram",
            expense: Amount(value: 1000, currencyCode: "INR"),
            type: .borrowed,
            date: Date()
        ),
        ExpenseCardView.DisplayItem(
            id: 11,
            title: "Cab Fare",
            description: "Airport to hotel ride",
            expense: Amount(value: -750, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 12,
            title: "Dinner",
            description: "Seafood restaurant with team",
            expense: Amount(value: 2200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 13,
            title: "Snacks",
            description: "Cafe coffee and snacks",
            expense: Amount(value: -350, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 14,
            title: "Hotel Stay",
            description: "2 nights at Marriott",
            expense: Amount(value: 7200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 15,
            title: "Lunch Bill",
            description: "Day 1 lunch at Taj Coram",
            expense: Amount(value: 1000, currencyCode: "INR"),
            type: .borrowed,
            date: Date()
        ),
        ExpenseCardView.DisplayItem(
            id: 16,
            title: "Cab Fare",
            description: "Airport to hotel ride",
            expense: Amount(value: -750, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 17,
            title: "Dinner",
            description: "Seafood restaurant with team",
            expense: Amount(value: 2200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 18,
            title: "Snacks",
            description: "Cafe coffee and snacks",
            expense: Amount(value: -350, currencyCode: "INR"),
            type: .lent,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        ),
        ExpenseCardView.DisplayItem(
            id: 19,
            title: "Hotel Stay",
            description: "2 nights at Marriott",
            expense: Amount(value: 7200, currencyCode: "INR"),
            type: .borrowed,
            date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        )
    ]
    func getExpenses() -> [ExpenseCardView.DisplayItem] {
        return expenses
    }
}

