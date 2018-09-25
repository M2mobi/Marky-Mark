//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

open class MarkyMark {

    /// Mark down flavor to use for parsing markdown
    var flavor:Flavor?

    /// Array of rules to apply on top of the rules of the Flavor
    var additionalRules:[Rule] = []

    /// Default rule to use if no other rule can be applied
    var defaultRule:Rule?

    /// Default inline rule to use if no other rule can be applied
    var defaultInlineRule:InlineRule?

    var inlineMarkDownItemFactory:InlineMarkDownItemFactory {
        return InlineMarkDownItemFactory(inlineRules: allInlineRules(), defaultRule: getDefaultInlineRule()!)
    }

    var listRules:[ListRule] {
        return allRules().compactMap { $0 as? ListRule }
    }
    var listMarkdownItemFactory:ListMarkDownItemFactory = ListMarkDownItemFactory()

    /**
     Initializer for building used for configuring MarkyMark
     defaultRule must be set in the build

     - returns: MarkyMark
     */

    public init(build:(MarkyMark) -> Void) {
        build(self)

        if getDefaultRule() == nil {
            fatalError("\(String(describing: self)): defaultRule is not set")
        }
        if getDefaultInlineRule() == nil {
            fatalError("\(String(describing: self)): defaultInlineRule is not set")
        }
    }

    /**
     Sets a default markdown rule that will be applied if none of the other rules can be applied
     default Rule is often used for markdown paragraph's

     - parameter rule: The fallback markdown rule
     */

    open func setDefaultRule(_ rule:Rule) {
        self.defaultRule = rule
    }

    /**
     Retrieves the default rule either by looking at the default rule in the flavor
     Or by the default rule that has been set manually
    */
    
    open func getDefaultRule() -> Rule? {
        if let defaultRule = defaultRule {
            return defaultRule
        } else {
            return flavor?.defaultRule
        }
    }

    /**
     Sets a default inline markdown rule that will be applied if none of the other inline rules can be applied
     This will be a simple TextItem in most cases
     
     - parameter rule: The fallback markdown rule
     */
    
    open func setDefaultInlineRule(_ rule:InlineRule) {
        self.defaultInlineRule = rule
    }

    /**
     Retrieves the default inline rule either by looking at the default rule in the flavor
     Or by the default rule that has been set manually
     */
    
    open func getDefaultInlineRule() -> InlineRule? {
        if let defaultInlineRule = defaultInlineRule {
            return defaultInlineRule
        } else {
            return flavor?.defaultInlineRule
        }
    }

    /**
     Adds a Markdown rule that will be used to recognize Markdown syntax

     - parameter rule: Rule that can recoginize markdown syntax
     */
    
    open func addRule(_ rule:Rule) {
        additionalRules.append(rule)
    }

    /**
     Set's a MarkDown Flavor containing a set of Rules
     Only one flavor can be used at a time and will overwrite the existing flavor

     - parameter flavor: Mark Down Flavor to use for parsing Markdown
     */

    open func setFlavor(_ flavor:Flavor) {
        self.flavor = flavor
    }

    /**
     Parse markdown with the configured rules

     - parameter markDown: A string containing markdown

     - returns: Array of MarkDownItem created by the given Rules
     */

    open func parseMarkDown(_ markDown:String) -> [MarkDownItem] {

        let markDownLines = MarkDownLines(markDown)
        var markDownItems:[MarkDownItem] = []
        
        while !markDownLines.isEmpty() {
            let lines = markDownLines.lines
            let rule = getRuleForLines(lines)

            let linesForRule:[String] = Array(lines[0..<rule.linesConsumed()])

            let markDownItem:MarkDownItem

            if let rule = rule as? ListRule {
                markDownItem = getListMarkDownItemWithLines(linesForRule, rule: rule)
            } else {
                markDownItem = rule.createMarkDownItemWithLines(linesForRule)

                if markDownItem.allowsChildMarkDownItems() {
                    markDownItem.markDownItems = inlineMarkDownItemFactory.getInlineMarkDownItemsForLines(markDownItem.content)
                }
            }

            markDownItems.append(markDownItem)
            markDownLines.removeLinesForMarkDownItem(markDownItem)
        }

        return markDownItems
    }

    /**
     Create a ListMarkDown items that contains all nested list items

     - parameter lines: Lines to create MarkDownItem with

     - returns: ListMarkDownItem
     */

    func getListMarkDownItemWithLines(_ lines:[String], rule:ListRule) -> MarkDownItem {

        let markDownItem = rule.createMarkDownItemWithLines(lines)

        parseListItems(markDownItem, lines: lines, rule: rule)

        return markDownItem
    }

    /**
     Populates given MarkDownItem with listItems if needed

     - parameter markDownItem: MarkDownItem to add list items to
     - parameter lines:        Lines to parse
     */

    func parseListItems(_ markDownItem:MarkDownItem, lines:[String], rule:ListRule) {
        guard let listMarkDownItem = markDownItem as? ListMarkDownItem else { return }
        
        let listItems = listMarkdownItemFactory.getListItemForLines(markDownItem.lines, rule: rule)
        listMarkDownItem.listItems = listItems

        for listItem in getFlattenedListItems(listMarkDownItem) {
            listItem.markDownItems = inlineMarkDownItemFactory.getInlineMarkDownItemsForLines(listItem.content)
        }
    }

    /**
     Returns the rules of the flavor and all additional rules

     - returns: List of all Rules that can be used to recognize markdown
     */

    func allRules() -> [Rule] {
        var rules = self.additionalRules

        if let flavor = flavor {
            rules += flavor.rules
        }

        return rules
    }

    func allInlineRules() -> [InlineRule] {
        return flavor?.inlineRules ?? []
    }

    /**
     Retrieves the first Rule that recognizes the syntax of the given lines

     - parameter lines: Array of strings containing markdown syntax

     - returns: A rule that recognizes the markdown syntax of the first line(s)
     */

    func getRuleForLines(_ lines:[String]) -> Rule {

        for rule in allRules() {

            if(rule.recognizesLines(lines)) {

                return rule
            }
        }

        return getDefaultRule()!
    }

    /**
     Loops recursively through all given MarkDown Items and finds all listItems

     - parameter listItem:           listItem to loop thourgh
     - parameter flattenedListItems: Property used internally for recursive reasons

     - returns: Flattend list of ListMarkDownItem's
     */
    func getFlattenedListItems(_ listItem:ListMarkDownItem, flattenedListItems:[ListMarkDownItem] = []) -> [ListMarkDownItem] {
        var flattenedListItems = flattenedListItems

        for listItem in listItem.listItems ?? [] {
            flattenedListItems.append(listItem)
            flattenedListItems = getFlattenedListItems(listItem, flattenedListItems: flattenedListItems)
        }

        return flattenedListItems
    }
}
