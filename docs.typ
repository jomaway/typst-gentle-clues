#import "lib/lib.typ": *
#import "@preview/tidy:0.3.0"
// #import "@local/svg-emoji:0.1.0": *

// extract version from typst.toml package file.
#let pkg-data = toml("typst.toml").package
#let version = pkg-data.at("version")
#let import_statement = raw(block: true, lang: "typ", "#import \"@preview/gentle-clues:" + version +"\": *")

// extract provided language translations
#let lang-data = toml("lib/lang.toml")
#let provided-translations = {
  let languages = lang-data.lang.keys()
  for lang in languages [
    #if lang == languages.first() [] else if lang == languages.last() [and] else [,] "#lang"
  ]
}

// global page settings
#set page(margin: 2cm);
#set text(font: "Rubik", weight: 300, lang: "en")

// #show: setup-emoji

// tidy docs
#let docs-clues = tidy.parse-module(
  read("lib/clues.typ"),
  name: "Gentle Clues API",
  scope: (clues: clues),
  preamble: "import clues: *;",
  label-prefix: "gc"
)


#let ex(a,b) = grid(columns: 2, gutter: 1em)[
    #a
    #align(end)[_Turns into this_ #sym.arrow]
  ][
    #b
  ]

= Gentle clues for typst

Add some beautiful, predefined admonitions or define your own.

== Getting started

#clue(title: "Minimal starting example")[
  #ex[
    #import_statement
    ```typ
    #tip[Check out this cool package]
    ```
  ][
    #tip[Check out this cool package]
  ]
]

#clue(title: "Usage")[
  + Import the package like this:
    #import_statement

  + *Optional:* Change the default settings for all clues if desired. See @gentle-clues-example.
  +
    #ex[
      Use a predefined clue without any options
      ```typ
      #info[You will find a list with all predefined clues at the last page.]
      ```
    ][
      #set align(bottom)
      #info[You will find a list with all predefined clues at the last page.]
    ]
  + #ex[
      Or overwrite the default parameters. e.g. set a custom title
      ```typ
      #example(title: "Custom title")[ Content ...]
      ```
    ][
      #set align(bottom)
      #example(title: "Custom title")[ Content ...]
    ]
    See *all available parameters* at @clue-api.

  + *I18n:*
    - The current language which is set by `#set text(lang: "de")` changes the default header title.
    - Currently supported are #provided-translations. This package uses linguify for language settings. Feel free to contribute more languages.

]

== Features

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

`#clue`
#clue[
  Default clue
]

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





=== Headless Variant

just add `title: none` to any example

#info(title:none)[Just a short information.]

] // columns end


#tidy.show-module(docs-clues, style: tidy.styles.default)
