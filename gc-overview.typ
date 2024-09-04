#import "lib/predefined.typ": *
#import "lib/clues.typ": clue


#set page(paper: "a5", flipped: true, margin: 1cm)

#let predefined-clues = (
  idea[`#idea[]`],
  abstract[`#abstract[]`],
  question[`#question[]`],
  info[`#info[]`],
  example[`#example[]`],
  experiment[`#experiment[]`],
  task[`#task[]`],
  error[`#error[]`],
  warning[`#warning[]`],
  success[`#success[]`],
  tip[`#tip[]`],
  conclusion[`#conclusion[]`],
  memo[`#memo[]`],
  quotation[`#quotation[]`],
  goal[`#goal[]`],
  notify[`#notify[]`],
  code[`#code[]`],
  danger[`#danger[]`]
)

#let clue-grid = grid(
  columns: 4,
  gutter: 12pt,
  ..predefined-clues
)

#clue(title:"Gentle Clues - Overview", header-color: gradient.linear(..color.map.crest), body-color: color.white)[
  #clue-grid
]
