#import "@preview/linguify:0.4.0": *
#import "clues.typ": clue, if-auto-then
#import "theme.typ": catppuccin as theme

// load linguify language database
#let lang-database = toml("lang.toml")

/// Helper for fetching the translated title
#let _get-title-for(id) = {
  assert.eq(type(id),str);
  return linguify(id, from: lang-database, default: linguify(id, lang: "en", default: id));
}

/// Helper to get the accent-color from the theme
/// -> color
#let _get-accent-color-for(
  /// The id for the predefined clue.
  /// -> string
  id
) = {
  return theme.at(id).accent-color
}

/// Helper to get the icon from the theme
/// -> content
#let _get-icon-for(
  /// The id for the predefined clue.
  /// -> string
  id
) = {
  let icon = theme.at(id).icon
  if type(icon) == str {
    return image("assets/" + theme.at(id).icon, fit: "contain")
  } else {
    return icon
  }
}

/// Wrapper function for all predefined clues.
/// -> clue
#let _predefined-clue(
  /// The id of the clue from which color, icon and default title will be calculated.
  /// -> string
  id,
  /// for overwriting the default parameter of a clue.
  /// -> parameter
  ..args
) = clue(
  accent-color: _get-accent-color-for(id),
  title: _get-title-for(id),
  icon: _get-icon-for(id),
  ..args
)

/// Info
/// ```example
/// #info[Whatever you want to say]
/// ```
/// -> content
#let info(..args) = _predefined-clue("info",..args)
/// Notificaton
/// ```example
/// #notify[New features in future versions.]
/// ```
/// -> content
#let notify(..args) = _predefined-clue("notify",..args)
/// ```example
/// #success[All tests passed. It's worth a try.]
/// ```
/// -> content
#let success(..args) = _predefined-clue("success",..args)
/// ```example
/// #warning[Still a work in progress.]
/// ```
/// -> content
#let warning(..args) = _predefined-clue("warning",..args)
/// ```example
/// #danger[Be carefull.]
/// ```
/// -> content
#let danger(..args) = _predefined-clue("danger",..args)
/// ```example
/// #error[Something did not work here.]
/// ```
/// -> content
#let error(..args) = _predefined-clue("error",..args)
/// ```example
/// #tip[Check out this cool package]
/// ```
/// -> content
#let tip(..args) = _predefined-clue("tip",..args)
/// ```example
/// #abstract[Make it short. This is all you need.]
/// ```
/// -> content
#let abstract(..args) = _predefined-clue("abstract",..args)
/// ```example
/// #goal[Beatuify your document!]
/// ```
/// -> content
#let goal(..args) = _predefined-clue("goal",..args)
/// ```example
/// #question[How do amonishments work?]
/// ```
/// -> content
#let question(..args) = _predefined-clue("question",..args)
/// ```example
/// #idea[Some content]
/// ```
/// -> content
#let idea(..args) = _predefined-clue("idea",..args)
/// ```example
/// #example[Lets make something beautifull.]
/// ```
/// -> content
#let example(..args) = _predefined-clue("example",..args)
/// ```example
/// #experiment[Try this ...]
/// ```
/// -> content
#let experiment(..args) = _predefined-clue("experiment",..args)
/// ```example
/// #conclusion[This package makes it easy to add some beatufillness to your documents.]
/// ```
/// -> content
#let conclusion(..args) = _predefined-clue("conclusion",..args)
/// ```example
/// #memo[Leave a #emoji.star on github.]
/// ```
/// -> content
#let memo(..args) = _predefined-clue("memo",..args)
/// ```example
/// #code[`#let x = "secret"`]
/// ```
/// -> content
#let code(..args) = _predefined-clue("code",..args)
/// ```example
/// #quotation(attribution: "The maintainer")[Keep it simple. Admonish your life.]
/// ```
/// -> content
#let quotation(attribution: none, content, ..args) = _predefined-clue("quote",..args)[
  #quote(block: true, attribution: attribution)[#content]
]

#let gc-task-counter = counter("gc-task-counter")
#let gc-task-counter-enabled = state("gc-task-counter", true)

#let increment-task-counter() = {
    context {
    if (gc-task-counter-enabled.get() == true){
      gc-task-counter.step()
    }
  }
}

#let get-task-number() = {
  context {
    if (gc-task-counter-enabled.get() == true){
      " " + gc-task-counter.display()
    }
  }
}

/// ```example
/// #task[Check out this wonderful typst package!]
/// ```
/// -> content
#let task(..args) = {
  increment-task-counter()
  _predefined-clue("task", title: _get-title-for("task") + get-task-number(), ..args)
}
