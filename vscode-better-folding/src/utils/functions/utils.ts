import { TextDocument, Range } from "vscode";
import { BetterFoldingRange } from "../../types";
import Bracket from "../../bracket-pair-colorizer-2 src/bracket";
import BracketClose from "../../bracket-pair-colorizer-2 src/bracketClose";
import BracketsRange from "../classes/bracketsRange";

export function groupArrayToMap<T, V>(array: T[], getValue: (element: T) => V, defaultValue?: V): Map<V, T[]> {
  const map: Map<V, T[]> = new Map();

  for (const element of array) {
    const value = getValue(element) ?? defaultValue;
    if (value === undefined || value === null) continue;

    const valueCollection = map.get(value);
    if (!valueCollection) {
      map.set(value, [element]);
    } else {
      valueCollection.push(element);
    }
  }

  return map;
}

export function foldingRangeToRange(document: TextDocument): (foldingRange: BetterFoldingRange) => Range {
  return (foldingRange) =>
    new Range(
      foldingRange.start,
      foldingRange.startColumn ?? document.lineAt(foldingRange.start).text.length,
      foldingRange.end,
      document.lineAt(foldingRange.end).text.length
    );
}

export function rangeToInlineRange(document: TextDocument): (range: Range) => Range {
  return (range) =>
    new Range(range.start.line, range.start.character, range.start.line, document.lineAt(range.start).text.length);
}

export function bracketsToBracketsRanges(brackets: Bracket[], sortBy: "end" | "start" = "end"): BracketsRange[] {
  const ranges: BracketsRange[] = [];

  for (let i = brackets.length - 1; i >= 0; i--) {
    const bracket = brackets[i];
    if (bracket instanceof BracketClose) {
      const openBracket = bracket.openBracket;
      if (openBracket) {
        const bracketsRange = new BracketsRange(openBracket, bracket);
        ranges.push(bracketsRange);
      }
    }
  }

  ranges.sort((a, b) => {
    if (a.end.isAfter(b.end)) {
      if (a.contains(b)) {
        return 1;
      }
      return -1;
    }

    if (b.contains(a)) {
      return -1;
    }
    return 1;
  });

  return sortBy === "start" ? ranges.reverse() : ranges;
}
