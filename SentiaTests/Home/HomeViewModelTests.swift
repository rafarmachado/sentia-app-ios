//
//  HomeViewModelTests.swift
//  SentiaTests
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockService: MockFeelingService!

    override func setUp() {
        super.setUp()
        mockService = MockFeelingService()
        viewModel = HomeViewModel(feelingService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func test_loadFeelings_successfullyLoadsGroups() {
        XCTAssertEqual(viewModel.emotionGroups.count, 2)
    }

    func test_selectGroup_togglesWhenSameGroupSelectedTwice() {
        let group = mockService.mockGroups.first!
        viewModel.selectGroup(group)
        XCTAssertTrue(viewModel.isShowingFeelings)

        viewModel.selectGroup(group)
        XCTAssertFalse(viewModel.isShowingFeelings)
    }

    func test_selectFeeling_setsSelectedFeeling() {
        let feeling = Feeling(name: "Peaceful", emoji: "🕊️")
        viewModel.selectFeeling(feeling)
        XCTAssertEqual(viewModel.selectedFeeling, feeling)
    }

    func test_goToConversation_setsRoute_whenSelectionIsValid() {
        let group = mockService.mockGroups.first!
        let feeling = group.feelings.first!

        viewModel.selectGroup(group)
        viewModel.selectFeeling(feeling)
        viewModel.goToConversation()

        XCTAssertNotNil(viewModel.route)
    }

    func test_resetSelection_clearsState() {
        viewModel.selectGroup(mockService.mockGroups.first!)
        viewModel.selectFeeling(mockService.mockGroups.first!.feelings.first!)
        viewModel.resetSelection()

        XCTAssertNil(viewModel.selectedGroup)
        XCTAssertNil(viewModel.selectedFeeling)
        XCTAssertFalse(viewModel.isShowingFeelings)
    }
}


