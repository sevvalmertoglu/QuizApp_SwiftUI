//
//  CategoryViewModelTests.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 4.09.2024.
//

@testable import QuizApp_SwiftUI
import Combine
import XCTest

final class CategoryViewModelTests: XCTestCase {
    private var viewModel: CategoryViewModel!
    private var cancellables: Set<AnyCancellable> = []
    private var mockTriviaService: MockTriviaService!

    @MainActor
    override func setUp() {
        super.setUp()
        self.mockTriviaService = MockTriviaService()
        self.viewModel = CategoryViewModel(triviaService: self.mockTriviaService)
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockTriviaService = nil
        self.cancellables.removeAll()
        super.tearDown()
    }

    @MainActor
    func test_initialState() {
        XCTAssertEqual(self.viewModel.selectedCategory, "")
        XCTAssertEqual(self.viewModel.categories, [])
        XCTAssertEqual(self.viewModel.errorMessage, "")
        XCTAssertFalse(self.viewModel.triviaOptionsActive)
        XCTAssertTrue(self.viewModel.rootActive)
    }

    @MainActor
    func test_setupCategories_success() {
        let expectation = XCTestExpectation(description: "Categories should be setup successfully")

        self.mockTriviaService.mockCategories = [TriviaCategory(id: 1, name: "General")]

        self.viewModel.$categories
            .dropFirst()
            .sink { categories in
                XCTAssertEqual(categories.count, 1)
                XCTAssertEqual(categories.first?.name, "General")
                expectation.fulfill()
            }
            .store(in: &self.cancellables)

        Task {
            await self.viewModel.setupCategories()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor
    func test_setupCategories_failure() {
        let expectation = XCTestExpectation(description: "Categories should not be setup due to error")

        self.mockTriviaService.mockError = "Network error"

        self.viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Network error")
                XCTAssertEqual(self.viewModel.categories.count, 0)
                expectation.fulfill()
            }
            .store(in: &self.cancellables)

        Task {
            await self.viewModel.setupCategories()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor
    func test_formatCategoryName() {
        let categoryName = "General Knowledge"
        let formattedName = self.viewModel.formatCategoryName(name: categoryName)
        XCTAssertEqual(formattedName, "General Knowledge")
    }

    @MainActor
    func test_showingAlert_whenErrorOccurs() {
        let expectation = XCTestExpectation(description: "Alert should be shown when an error occurs")

        self.mockTriviaService.mockError = "Network error"

        self.viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if errorMessage == "Network error" {
                    expectation.fulfill()
                }
            }
            .store(in: &self.cancellables)

        Task {
            await self.viewModel.setupCategories()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
