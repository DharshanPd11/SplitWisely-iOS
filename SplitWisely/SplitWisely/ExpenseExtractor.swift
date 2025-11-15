//
//  ExpenseExtractor.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 15/11/25.
//

final class ExpenseExtractor{
    private let session: LanguageModelSession
    private(set) var expense: TextExtractedExpense?
    private let model = SystemLanguageModel.default

    let sampleExpense = TextExtractedExpense(title: "Shopping", description: "groceries shopping from XYZ store"/*, currency: AllCurrencies().currentCurrency*/, amount: 2000.00)
    
    init() {
        self.session = LanguageModelSession {
            "You are a expense extracting agent, you need to extract an expense information like title, amount and the currency from the text extracted from an image most probably a bill or receipt"
            """
            """
        }
    }
    
    func isDeviceAICompatible() -> Bool{
        switch model.availability {
        case .available:
            return true
        default:
            return false
        }
    }
    
    func extractExpense(from text: String) async throws -> TextExtractedExpense? {
        let response = try await session.respond(generating: TextExtractedExpense.self){
            "Extract expense amount and the currency from the text. Give the expense an apporpriate title based on the text"
        }
        
        self.expense = response.content
        return response.content
    }
}

@Generable()
struct TextExtractedExpense{
    let title, description : String
//    let currency: Currency
    let amount: Decimal
}
