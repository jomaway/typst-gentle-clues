#import "lib/predefined.typ": *
#import "lib/clues.typ": clue

#let predefined-clues = (idea[],abstract[],question[],info[],example[],experiment[],task[],error[],warning[],success[],tip[],conclusion[],memo[],quotation[],goal[],notify[],code[],danger[]
)

#let clue-grid = grid(
  columns: 4,
  gutter: 12pt,
  ..predefined-clues
)

#clue(title:"Gentle Clues - Overview", header-color: gradient.linear(..color.map.crest))[
  #clue-grid
]
