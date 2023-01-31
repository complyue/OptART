
"""
Universal (yet minimal) parts of lexical structure, for all languages those `OptART` based

  - Literal
    Convey immutable value semantics, i.e. rather than referential semantics

    - Number
      Usually expressed in decimal format for human readers,
      or of computer oriented format e.g. `0xCAFE`

    - Text
      The so called String in programming languages

    - Quantity
      A number followed immediately by a UoM (Unit of Measure) symbol

    - UUID
      Per some standard definition TBD

  - Identifier
    Convey referential semantics, i.e. refer to another thing from lexical context

    - Alphanumeric Identifer
      Human names etc.

    - Symbolic Identifier
      Math operators etc.

    - Indirect Identifier
      A value resolved from the 1st level identifier, used as the 2nd level identifier
      Typically the resolved value is a (freeform) `Text`, or `UUID`


  - Sentence
    A piece of text code separated from other sentences by single line-breaks

  - Paragraph
    One or more sentences separated from other paragraphs by multiple consecutive line-breaks

  - Module
    One or more paragraphs provided as a code unit (e.g. source file)

"""
module Lexicon

end # module Lexicon
