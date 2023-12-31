#import "@local/gentle-clues:0.5.0": *
#gc_header-title-lang.update("en")

#set text(font: "Roboto")

= Gentle clues for typst

Add some beautiful, predefined admonitions or define your own.

#clue(title: "Example")[
```typst
#clue(title: "Example")[Test content.]
```
#sym.arrow The default is a navy colored clue.
]

#info(title: "NEW v0.5.0")[
  - Added option `breakable: true` to make clues breakable. (See below)
  - Added spanish header titles. Use with `#gc_header-title-lang.update("es")`
  - *Breaking:* Removed aliases
]

#info(title: "NEW v0.4.0",_color: gradient.linear(..color.map.crest))[
  * Translations:*
  - French language titles: `gc_header-title-lang.update("fr")`

  *Colors:*
  - Colored borders by default.
  - Added support for gradients: `#clue(_color: gradient.linear(..color.map.crest))`
  - *Breaking:* Removed string color_profiles.

  *Task Counter*
    - Added a Task Counter.
    - Disable with `#gc_enable-task-counter.update(false)`
    #set text(9pt)
  #grid( columns: 4, gutter: 1em,  task[Do], task[Do], task[Do])
]

#info(title: "Options")[ 
  - Changing header title language with: `gc_header-title-lang.update("en")`
    - Accepts `"en", "de"`, `"fr"` or `"es"` for the moment.
  - define header inset: `#clue(header-inset: 0.5em)[]`
  - define header title: `#clue(title: "MyTitle")[]`
  - define custom color: 
    - `#clue(_color: red)[]`
    - `#clue(_color: (stroke: teal, bg: teal.lighten(40%), border: red))[]`
  - define the width: `#clue(width: 4cm)[]`
  - define right border radius: `#clue(radius: 9tp)[]`  #text(9pt, fill: gray)[(`0pt` to disable)]
  - make clues break onto next page -> `breakable: true`
]

#success(title: "Clues can now break onto the next page")[
  #lorem(40)
]

== Predefined
`abstract`
#abstract[Make it short. This is all you need.]

`question`
#question[How do amonishments work?]

`info`
#info[It's as easy as 
```typst 
  #note[Whatever you want to say]
  ```
]

`example`,
#example[Testing ...]

`task`
#task[#box(width: 0.8em, height: 0.8em, stroke: 0.5pt + black, radius: 2pt) Check out this wonderfull admonishments!]

`error`
#error[Something did not work here.]

`warning`
#warning[Still a work in progress.]

`success`
#success[All tests passed. It's worth a try.]

`tip`
#tip[Try it yourself]

`conclusion`
#conclusion[This package makes it easy to add some beatufillness to your documents]

`memorize`
#memo[Leave a #emoji.star on github.]

`quote`
#quote[Keep it simple. Admonish your life.]

== Headless

just add `title: none` to any example

#info(title:none)[Just a short information.]

== Define your own

```typst
// Define it
#let ghost-admon(title: "Buuuuuuh", icon: emoji.ghost , ..args) = clue(color: purple, title: title, icon: icon, ..args)
// Use it
#ghost-admon[Huuuuuuh.]
```
#let ghost-admon(title: "Buuuuuuh.", icon: emoji.ghost , ..args) = clue(_color: gray, title: title, icon: icon, ..args)
#ghost-admon[Huuuuuuh.]
