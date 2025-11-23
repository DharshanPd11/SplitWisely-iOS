//
//  DummyData.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 04/10/25.
//

import SwiftUI

public struct DummyData {
    
        static let SplitParticipanta: [Participant] = [
            Participant(id: UUID(), name: "Priya", amountOwed: 0),
            Participant(id: UUID(), name: "Akash", amountOwed: 1500),
            Participant(id: UUID(), name: "Naveen", amountOwed: -800),
            Participant(id: UUID(), name: "Harini", amountOwed: 250),
            Participant(id: UUID(), name: "Sakura", amountOwed: -1200),
            Participant(id: UUID(), name: "Dinesh", amountOwed: 0),
            Participant(id: UUID(), name: "Meera", amountOwed: 500),
            Participant(id: UUID(), name: "Sanjay", amountOwed: -300)
        ]

    static var participants : [ParticipantCardView.DisplayItem] = [
        ParticipantCardView.DisplayItem(
            id: 1,
            name: "Alice Johnson",
            description: "Team Lead",
            image: Image(systemName: "person.circle.fill"),
            expense: nil,
            trailingView: .multiSelect(isSelected: true),
            type: .individual
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
            trailingView: .multiSelect(isSelected: false)
        ),
        ParticipantCardView.DisplayItem(
            id: 4,
            name: "David Tanaka",
            description: "QA Engineer",
            image: Image(systemName: "person.circle.fill"),
            expense: nil,
            trailingView: .multiSelect(isSelected: false)
        ),
        ParticipantCardView.DisplayItem(
            id: 5,
            name: "Evelyn Smith",
            description: "Intern",
            image: Image(systemName: "person.circle"),
            expense: nil,
            trailingView: .multiSelect(isSelected: false)
        )
    ]

    static var expenses : [ExpenseCardView.DisplayItem] = [
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
    
    static var groups: [GroupDisplayItem] = [ GroupDisplayItem(id: 10, icon: "", name: "Munnar", status: .settled), GroupDisplayItem(id: 11, icon: "", name: "New Delhi", expense: Amount(value: 100, currencyCode: "USD"), status: .pending), GroupDisplayItem(id: 12, icon: "", name: "Jammu and Kashmir", expense: Amount(value: -100, currencyCode: "USD"), status: .incoming), GroupDisplayItem(id: 14, icon: "", name: "Andaman and Nicobar", status: .noExpense), GroupDisplayItem(id: 13, icon: "", name: "Munnar", status: .settled), GroupDisplayItem(id: 15, icon: "", name: "New Delhi", expense: Amount(value: 100, currencyCode: "USD"), status: .pending), GroupDisplayItem(id: 16, icon: "", name: "Jammu and Kashmir", expense: Amount(value: -100, currencyCode: "USD"), status: .incoming), GroupDisplayItem(id: 17, icon: "", name: "Andaman and Nicobar", status: .noExpense)]
    
    func getExpenses() -> [ExpenseCardView.DisplayItem] {
        return DummyData.expenses
    }
}

