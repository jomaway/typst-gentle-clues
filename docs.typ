#import "lib/lib.typ": *
#import "@preview/tidy:0.4.1"

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

#let pkg-info = (
  author: link("<https://github.com/jomaway>", "jomaway"),
  repo: link(pkg-data.at("repository")),
  version: version
)

// global page settings
#set page(
  margin: 2cm,
  header: align(start,text(font:"Noto Sans Mono")[Docs for #link("https://typst.app/universe/package/gentle-clues",[gentle-clues:#version])]),
  footer: [Author: #link("https://github.com/jomaway","jomaway"), License: MIT #h(1fr) #context {counter(page).display("1/1", both: true)}]
);
#set text(font: "Rubik", weight: 300, lang: "en")
#set heading(
  numbering: (..numbers) =>
    if numbers.pos().len() >= 2 and numbers.pos().len() <= 3 {
      return numbering("1.", ..numbers.pos().slice(1))
    }
)
#show link: set text(blue)


// tidy docs
#let docs-clues = tidy.parse-module(
  read("lib/clues.typ"),
  name: "Gentle Clues API",
  scope: (clues: clues),
  preamble: "#import clues: *; #show: gentle-clues.with(width: 8cm);",
  label-prefix: "gc"
)

/// docs-helper function
#let predefined-docs-info-table(id) = {
  import predefined: * // _get-accent-color-for, _get-icon-for, _get-title-for
  box(radius:3pt, clip:true, stroke: 1pt + black, table(
    columns: (auto,auto,auto, 1fr),
    inset: 0.6em,
    fill: (col,row) => if row == 0 {gray.lighten(60%)},
    align: (col,row) => if row >= 1 {center + horizon} else {auto},
    table.header([*Color*],[*Icon*],[*Title*], [*Note*]),
    [#circle(fill:_get-accent-color-for(id)); #raw(_get-accent-color-for(id).to-hex())],
    [#box(width: 2em, _get-icon-for(id))],
    [#_get-title-for(id)],
    // raw(lang: "example", example)
  ))
}

#let docs-predefined = tidy.parse-module(
  read("lib/predefined.typ"),
  name: "Predefined Clues",
  scope: (
    predefined: predefined,
    clues: clues,
    docs-info: predefined-docs-info-table,
  ),
  preamble: "#import predefined: *; #import clues: gentle-clues; #show: gentle-clues.with(width: 8cm, title-font: \"Rubik\");",
  label-prefix: "gc"
)

#show: tidy.render-examples.with(
  scope: (clues:clues),
  layout: (code,preview) => grid(columns: 2, gutter: 1em, box(inset: 0.5em,code), align(horizon, box(preview)))
)


#let ex(a,b) = grid(columns: 2, gutter: 1em)[
    #a
    #align(end)[_Turns into this_ #sym.arrow]
  ][
    #b
  ]

#set align(center)
= Gentle clues

#block(inset: 1em)[
  #emph[Add some beautiful, predefined admonitions or define your own.]
]
`gentle-clues` is a package for the typst ecosystem \
by #pkg-info.at("author").

#block(inset: 1em)[
  *Version:* #version
]

#import "gc-overview.typ": overview
#align(center, box(width: 90%)[
  #figure(
    overview,
    caption: "Overview of all predefined clues."
  )
])

#outline(depth: 2)

#pagebreak()
#set align(start)

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

  + *Optional:* Change the default settings for all clues if desired. See @gentle-clues-example[Example].
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
    See *all available parameters* at @clue-api[API].

  + *I18n:*
    - The current language which is set by `#set text(lang: "de")` changes the default header title.
    - Currently supported are #provided-translations. This package uses linguify for language settings. Feel free to contribute more languages.

]

== Features

This package provides some features which helps to customize the clues to your liking.

- Brings a wide variety of predefined clues. See @predefined.
- Set global default for all clues. See @gentle-clues-example.
- Overwrite each parameter on a single clue for changing title, color, etc. See @clue-api.
- Show or hide a counter value on tasks.
- Define your own clues very easily. See @define-own-clues

=== Custom styling<custom-styling>
Clues can be styled in your liking.

The simplest way is to change the `accent-color` which will be the thick border stroke on the left side. Header and border color will then automatically derived from this color.

But you can set the `header-color`,`border-color` and `body-color` independently with a `color`, `gradient` or `pattern`.

Additionally, you can set a different font for the title with `title-font` and its weight offset with `title-weight-delta`.

*Example:*

#box[
  ```example
  >>> #import clues: clue
  #clue(
    title: "Rainbow style",
    accent-color: gradient.linear(red, blue, dir: ttb),
    header-color: gradient.linear(red, yellow, blue),
    border-color: blue.darken(40%),
    body-color: yellow.lighten(80%),
    title-font: "Liberation Mono",
    title-weight-delta: 300
  )[Some content. #lorem(20)]
  ```
]

There are many more options for customization. For all possible parameters see @clue-api[API].




== Define your own clues <define-own-clues>

You can easily define your own clues. Just set some default values for `color`, `title`, `icon`, ... and you are ready to go.
#box[
  ```example
  >>> #import clues: clue
  // Define a clue called ghost
  #let ghost(title: "Buuuuuuh", icon: emoji.ghost , ..args) = clue(
    // Define default values.
    accent-color: purple,
    title: title,
    icon: icon,
    // Pass along all other arguments
    ..args
  )

  // Use it
  #ghost[This is the ghost number one.]
  #ghost(title: "Poltergeist")[This ghost has a custom name.]
  #ghost[Huuuuuuh.]
  ```
]


#pagebreak()



#let show-outline(module-doc, style-args: (:)) = {
  let prefix = module-doc.label-prefix
  let gen-entry(name) = {
    if "enable-cross-references" in style-args and style-args.enable-cross-references {
      link(label(prefix + name), name)
    } else {
      name
    }
  }
  if module-doc.functions.len() > 0 {
    grid(
      columns: 5 * (1fr,),
      inset: 1em,
      ..module-doc.functions.map(fn => [ - #gen-entry(fn.name + "()")])
    )
  }

  if module-doc.variables.len() > 0 {
    text([Variables:], weight: "bold")
    list(..module-doc.variables.map(var => gen-entry(var.name)))
  }
}


#let predefined-docs-style = dictionary(tidy.styles.default)
#{
  predefined-docs-style.show-parameter-list = (fn, style-args: (:)) => {}
  predefined-docs-style.show-outline = show-outline
  // predefined-docs-style.show-example = show-example
  predefined-docs-style.show-function = (fn,style-args) => block(breakable: false, tidy.styles.default.show-function(fn, style-args))
}

#figure([],supplement: "Section")<predefined>
#tidy.show-module(
  docs-predefined,
  style: predefined-docs-style,
  omit-private-definitions: true,
)

// Clues API
#pagebreak()
#tidy.show-module(docs-clues, style: tidy.styles.default)
