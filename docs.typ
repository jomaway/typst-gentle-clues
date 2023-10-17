
#import "@local/gentle-clues:0.2.1": *
#gc_header-title-lang.update("en")

#set text(font: "Roboto")

= Gentle clues for typst

Add some beautiful, predefined admonitions or define your own.

#clue(title: "Example")[
```typst
#clue(title: "Example")[Test content.]
```
]
#h(1fr)
#clue(title: none)[
  The default is a gray clue.
]

#info(title: "NEW v0.2.1")[
  - Default `header-inset` is `0.5em` now.
  - Added `gc_header-title-lang` state. Update with: `#gc_header-title-lang.update("de")`
    - Accepts `"de"` or `"en"` for the moment
  - 
]

#clue(title: "NEW v0.2.0", _color: (stroke: teal, bg: teal.lighten(40%)), header-inset: 0.6em)[ 
  - smaller header. `#clue(header-inset: 0.5em)`
  - custom color: `#clue(color: (stroke: teal, bg: teal.lighten(40%)))`
  - example admonition: `#example[Testing]`
  #example[Testing]
]

== Predefined

`example`,
#example[Testing ...]

`question`, `faq`, `help` 
#faq[How do amonishments work?]

`note`, `info`
#note[It's as easy as 
```typst 
  #note[Whatever you want to say]
  ```
]

`task`, `todo`
#task[#box(width: 0.8em, height: 0.8em, stroke: 0.5pt + black, radius: 2pt) Check out this wonderfull admonishments!]

`error`, `failure`, `missing`
#error[Something did not work here.]

`warning`, `attention`, `caution`, 
#warning[Still a work in progress.]

`success`, `check`, `done`
#success[All tests passed. It's worth a try.]

`tip`, `hint`, `important`
#tip[Try it yourself]

`abstract`, `summary`, `tldr`
#abstract[Make it short. This is all you need.]

`conclusion`,`idea`
#conclusion[This package makes it easy to add some beatufillness to your documents]

`reminder`
#memo[Leave a #emoji.star on github.]

`quote`
#quote[Keep it simple. Admonish your life.]

== Headless

just add `title: none` to any example

#info(title:none)[Just a short information.]

#pagebreak()
== Define your own

```typst
// Define it
#let ghost-admon(title: "Buuuuuuh", icon: emoji.ghost , ..args) = clue(color: "purple", title: title, icon: icon, ..args)
// Use it
#ghost-admon[Huuuuuuh.]
```
#let ghost-admon(title: "Buuuuuuh.", icon: emoji.ghost , ..args) = clue(_color: "purple", title: title, icon: icon, ..args)
#ghost-admon[Huuuuuuh.]


== Reference

```typst
#clue(
  body, 
  title: none, // Default: none, or string 
  icon: "assets/flag.svg", // can be a file or an symbol|emoji
  color: "gray", 
  width: auto, 
  radius: 2pt, // radius of the right side. For no radius set to 0pt.
  inset: 1em, // inset of the content, header-inset not yet supported
  header-inset: 1em // make the header smaller or wider
)
```



#table( 
    columns: (6cm, auto, auto, auto), 
    align: horizon + center,
    "Admonishment", "Stroke color", "Background color", "Aliases",
    abstract[...content], "", "", [`abstract`, `summary`, `tldr`],
    info[...content], "", "", [`info`, `note`],
    question[...content], "", "", [`question`],
    memo[...content], "", "", [`memo`, `remember`],
    task[...content], "", "", [`task`, `todo`],
    idea[...content], "", "", [`conclusion`, `idea`],
    tip[...content], "", "", [`tip`, `hint`],
    quote[...content], "", "", [`quote`],
    success[...content], "", "", [`success`, `done`],
    warning[...content], "", "", [`warning`, `attention`, `caution`],
    error[...content], "", "", [`error`, `failing`, `missing`],
    example[...content], "", "", [],
)
