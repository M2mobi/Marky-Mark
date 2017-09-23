//
//  Created by Jim van Zummeren on 29/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class InlineMarkDownItemFactory {

    let inlineRules:[InlineRule]

    let defaultRule:InlineRule

    init(inlineRules:[InlineRule], defaultRule:InlineRule) {
        self.inlineRules = inlineRules
        self.defaultRule = defaultRule
    }

    /**
     Recursive method to generate inline markdown items

     - parameter content:        MarkDown Syntax to split into MarkDownItem pieces
     - parameter ruleRangePairs: Rules And Range to use to split the content

     - returns: MarkDownItem that contains markDownItems
     */

    func getInlineMarkDownItemsForLines(_ content:String, ruleRangePairs:[RuleRangePair]? = nil) -> [MarkDownItem]? {
        let ruleRangePairs = ruleRangePairs ?? getRuleRangePairsForLines(content)

        if !containsInlineFormattingRules(ruleRangePairs) {
            return [defaultRule.createMarkDownItemWithLines([content])]
        }

        var markDownItems:[MarkDownItem] = []

        for ruleRangePair in ruleRangePairs {
            let range = ruleRangePair.range
            let rule = ruleRangePair.rule

            let string = content.subString(range)
            let markDownItem = rule.createMarkDownItemWithLines([string])

            if markDownItem.allowsChildMarkDownItems() {
                markDownItem.markDownItems = getInlineMarkDownItemsForLines(markDownItem.content)
            } else {
                markDownItem.markDownItems = [defaultRule.createMarkDownItemWithLines([markDownItem.content])]
            }

            markDownItems.append(markDownItem)
        }

        return markDownItems.count > 0 ? markDownItems : nil;
    }

    //MARK: Private

    fileprivate func getMarkDownStringToMarkDownItem(_ markDownItem:MarkDownItem) -> [MarkDownItem]? {

        let inlineRules = getRuleRangePairsForLines(markDownItem.content)

        if inlineRules.count == 0 {
            return nil
        }

        return getInlineMarkDownItemsForLines(markDownItem.content, ruleRangePairs: inlineRules)
    }

    fileprivate func getInlineTextItem(_ previousRange:NSRange, currentRange:NSRange, content:String) -> [MarkDownItem] {

        if currentRange.location != 0 {
            let start = previousRange.getLocationEnd()
            let end = currentRange.location
            let string = content.subString(start, end)
            
            let markDownItem:MarkDownItem = defaultRule.createMarkDownItemWithLines([string])
            markDownItem.markDownItems = getMarkDownStringToMarkDownItem(markDownItem)
            
            return [markDownItem]
        }

        return []
    }

    fileprivate func getRuleRangePairsForLines(_ content:String) -> [RuleRangePair] {
        var ruleRangePairs:[RuleRangePair] = []

        for rule in self.inlineRules {

            let matches = rule.getAllMatches([content])
            for range in matches {
                ruleRangePairs.append(RuleRangePair(rule:rule, range:range))
            }
        }

        ruleRangePairs = ruleRangePairs.sorted {
            $0.range.location < $1.range.location
        }

        ruleRangePairs = removedNestedRules(ruleRangePairs)
        ruleRangePairs = addMissingRuleRangePairs(ruleRangePairs, contentLength:content.length())

        return ruleRangePairs
    }

    fileprivate func removedNestedRules(_ ruleRangePairs:[RuleRangePair]) -> [RuleRangePair] {

        var filteredRuleRangePairs:[RuleRangePair] = []

        var previousRange:NSRange?

        for ruleRangePair in ruleRangePairs {

            if !ruleRangePair.range.isOverlappingWithRange(previousRange) || previousRange == nil {
                filteredRuleRangePairs.append(ruleRangePair)
            }

            previousRange = ruleRangePair.range
        }

        return filteredRuleRangePairs
    }

    fileprivate func addMissingRuleRangePairs(_ ruleRangePairs:[RuleRangePair], contentLength:Int) -> [RuleRangePair] {

        var result:[RuleRangePair] = []
        var previousRange:NSRange = NSRange(location: 0, length: 0)

        for ruleRangePair in ruleRangePairs {
            let range = ruleRangePair.range

            if let defaultRuleRangePair = getDefaultRuleRangePairBetween(previousRange, currentRange: range) {
                result.append(defaultRuleRangePair)
            }

            result.append(ruleRangePair)

            previousRange = ruleRangePair.range
        }

        let range = NSRange(location: contentLength, length: 0)

        if let defaultRuleRangePair = getDefaultRuleRangePairBetween(previousRange, currentRange: range) {
            result.append(defaultRuleRangePair)
        }

        return result
    }

    fileprivate func getDefaultRuleRangePairBetween(_ previousRange:NSRange, currentRange:NSRange) -> RuleRangePair? {
        if currentRange.location > previousRange.getLocationEnd() {
            let location = previousRange.getLocationEnd()
            let length = currentRange.location - location
            return RuleRangePair(rule: defaultRule, range: NSRange(location:location, length: length))
        } else {
            return nil
        }
    }

    fileprivate func containsInlineFormattingRules(_ ruleRangePairs:[RuleRangePair]) -> Bool {
        guard let rule = ruleRangePairs.first?.rule else { return false }
        return !(ruleRangePairs.count == 1 && type(of: rule) == type(of: defaultRule))
    }
}

private extension NSRange {
    func isOverlappingWithRange(_ previousRange:NSRange?) -> Bool{
        guard let previousRange = previousRange else { return false }

        if self.location > previousRange.location {
            return self.location < previousRange.getLocationEnd()
        }else {
            return previousRange.location < self.getLocationEnd()
        }
    }
}
