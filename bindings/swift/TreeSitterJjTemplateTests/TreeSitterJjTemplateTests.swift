import XCTest
import SwiftTreeSitter
import TreeSitterJjTemplate

final class TreeSitterJjTemplateTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_jj_template())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading JjTemplate grammar")
    }
}
