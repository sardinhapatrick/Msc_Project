import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Msc_ProjectTests.allTests),
    ]
}
#endif
