#import "lib/lib.typ": *
#import "@local/svg-emoji:0.1.0": *

#let pkg-data = toml("typst.toml").package
#let version = pkg-data.at("version")
#let import_statement = raw(block: true, lang: "typ", "#import \"@preview/gentle-clues:" + version +"\": *")

#set page(margin: 2cm);

#show: setup-emoji

#show: gentle-clues.with(
  headless: false,
  breakable: false,
  // header-inset: 0.4em,
  // content-inset: 1.3em,
  // border-radius: 12pt,
  // border-width: 1pt,
  // stroke-width: 5pt,
)

#set text(font: "Rubik", weight: 300, lang: "en")

= Gentle clues for typst

Add some beautiful, predefined admonitions or define your own.

#info(title: "Test")[Test]

#clue(title: "Getting Started")[
  A minimal starting example
  #import_statement
  ```typ
  #tip[Check out this cool package]
  ```
  #tip[Check out this cool package]
]

#clue(title: "Usage")[
  + Import the package like this:
    #import_statement

  + Change the default settings for a clue.
    ```typ
    #show: gentle-clues.with(
      headless: false,  // never show any headers
      breakable: false, // default breaking behavior
      header-inset: 0.5em, // default header-inset
      content-inset: 1em, // default content-inset
      stroke-width: 2pt, // default left stroke-width
      border-radius: 2pt, // default border-radius
      border-width: 0.5pt,  // default boarder-width
    )
    ```
  +
    #grid(columns: 2, gutter: 1em)[
      Use a predefined clue without any options
      ```typ
      #info[You will find a list with all predefined clues at the last page.]
      ```
      #align(end)[_Turns into this_ #sym.arrow]

    ][
      #set align(bottom)
      #info[You will find a list with all predefined clues at the last page.]
    ]
  + #grid(columns: 2, gutter: 1em)[
      Or add some options like a custom title
      ```typ
      #example(title: "Custom title")[ Content ...]
      ```
      #align(end)[_Turns into this_ #sym.arrow]
    ][
      #set align(bottom)
      #example(title: "Custom title")[ Content ...]
    ]

  + *I18n:*
    - The current language which is set by `#set text(lang: "de")` changes the default header title.
    - Currently supported are `en`, `de`, `fr`, `es` and `zh`. This package uses linguify for language settings. Feel free to contribute more languages.

]

#clue(title: "All Options for a clue")[
  All default settings can also be applied to a single clue through passing it as an named argument. Here is a list of accepted arguments:
  ```typ
  title: auto, // [string] or [none] (none will print headless)
  icon: emoji.magnify.l, // [file] or [symbol] or [none]
  accent-color: navy, // left accent color [color], [gradient] or [pattern]
  border-color: auto, // bottom and right border color [color], [gradient] or [pattern]
  header-color: auto, // [color], [gradient] or [pattern]
  body-color: none, // [color], [gradient] or [pattern]
  width: auto, // total width [length]
  radius: auto, // radius of the right border [length]
  border-width: auto, // width of the right and down border [length]
  content-inset: auto, // [length]
  header-inset: auto, // [length]
  breakable: auto, // if clue can break onto next page [bool]
  ```
]

#box(
  height: 4.5cm,
  stroke: gray.lighten(40%),
  radius: 2pt,
  inset: 2mm,
  columns(2)[
    #notify(title: "Breaking news", breakable: true)[
      Clues can now break onto the next page with option: `breakable: true`

      #lorem(30)
    ]
    This is a two columns layout.
])


// Color options
#clue(
  title: "Color management",
  accent-color: gradient.linear(red, blue, dir: ttb),
  header-color: gradient.linear(red, yellow, blue),
  border-color: blue.darken(40%),
  body-color: pattern(text(fill:fuchsia.lighten(40%),"\n           ."))
)[
  Clues can be styled in your liking.

  The simplest way is to change the `accent-color` which will be the thick border stroke on the left side. Header and border color will then automatically derived from this color.

  But you can set the `header-color`,`border-color` and `body-color` independently with a `color`, `gradient` or `pattern`.

  *Example:*
  ```typ
  #clue(
    title: "Color management",
    accent-color: gradient.linear(red, blue, dir:ttb),
    header-color: gradient.linear(red, yellow, blue),
    border-color: blue.darken(40%),
    body-color: pattern(text(fill:fuchsia.lighten(40%),"\n           ."))
  )[...]
  ```
]

#clue(title: "Define your own clue")[
  ```typst
  // Define a clue called ghost
  #let ghost(title: "Buuuuuuh", icon: emoji.ghost , ..args) = clue(
    accent-color: purple, // Define a base color
    title: title,   // Define the default title
    icon: icon,     // Define the default icon
    ..args          // Pass along all other arguments
  )
  // Use it
  #ghost[Huuuuuuh.]
  ```
  The result looks like this.
  #let ghost(
    title: "Buuuuuuh.",
    accent-color: purple,
    icon: emoji.ghost ,
    ..args
  ) = clue(title: title, icon: icon, ..args)
  #ghost[Huuuuuuh.]
  #set text(9pt)
  #tip[Use the `svg-emoji` package until emoji support is fully supported in typst ]
]


== List of all predefined clues <predefined>

#columns(2)[

`idea`
#idea[Lets make something beautifull.]

`#abstract`
#abstract[Make it short. This is all you need.]

`#question`
#question[How do amonishments work?]

`#info`
#info[It's as easy as
```typst
  #info[Whatever you want to say]
  ```
]

`#example`,
#example[Testing ...]

`#experiment`
#experiment[Testing ...]

`#task`
#task[
  #box(width: 0.8em, height: 0.8em, stroke: 0.5pt + black, radius: 2pt)
  Check out this wonderful typst package!
]

`#error`
#error[Something did not work here.]

`#warning`
#warning[Still a work in progress.]

`#success`
#success[All tests passed. It's worth a try.]

`#tip`
#tip[Try it yourself]

`#conclusion`
#conclusion[This package makes it easy to add some beatufillness to your documents]

`#memo`
#memo[Leave a #emoji.star on github.]

`#quotation`
#quotation(attribution: "The maintainer")[Keep it simple. Admonish your life.]

`#goal`
#goal[Beatuify your document!]

`#notify`
#notify[ In version 0.9 some new predefined clues where added.]

`#code`
#code[```typ
  #let x = "secret"
```]

`#danger`
#danger[
  Nothing here ...
]

`#clue`
#clue[
  Default clue
]



=== Headless Variant

just add `title: none` to any example

#info(title:none)[Just a short information.]

] // columns end
