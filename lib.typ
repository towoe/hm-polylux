// HM Polylux Theme
// Presentation theme for Hochschule München
#import "@preview/polylux:0.4.0": *

// HM Brand Colors
#let hm-red = rgb(252, 85, 85)
#let hm-green = rgb(74, 211, 134)
#let hm-yellow = rgb(255, 255, 0)
#let hm-blue = rgb(62, 70, 217)
#let hm-dark-gray = rgb(110, 110, 110)
#let hm-light-gray = rgb(198, 198, 198)
#let hm-accent1 = rgb(87, 66, 63)
#let hm-accent2 = rgb(191, 165, 163)
#let hm-accent3 = rgb(110, 158, 0)
#let hm-accent4 = rgb(55, 106, 0)

// Primary color scheme (customizable)
#let primary-color = hm-red
#let accent-color = hm-red
#let text-color = black

// Metadata for access across slides
#let meta-state = state("meta", (:))

// ============================================
// Title slide
// ============================================

#let title-slide() = slide[
  #set align(center + horizon)
  #set text(fill: text-color)

  #context {
    let m = meta-state.get()

    place(top + right)[
      #image("img/HM_Logo_Text_red.pdf", height: 2.5cm)
    ]

    place(left + horizon, dx: 25%, dy: 10%, {
      text(size: 22pt, weight: "bold", fill: black)[#upper(m.title)]

      v(0.5em)

      text(
        size: 18pt,
        fill: black,
        style: "italic",
        weight: "light",
      )[#m.subtitle]
      linebreak()

      if m.author != none {
        linebreak()
        text(size: 16pt, weight: "light", fill: black)[#m.author]
      }

      if m.institute != none {
        linebreak()
        text(size: 16pt, weight: "light")[#m.institute]
      }

      if m.date != none {
        linebreak()
        text(size: 14pt, weight: "light")[#m.date]
      }
    })
  }
]

// ============================================
// Footer
// ============================================

#let hm-footer() = {
  set text(size: 10pt)
  context {
    if here().page() > 1 {
      let m = meta-state.get()
      grid(
        columns: (1fr, 6fr, 1fr),

        align(left)[
          #image("img/HM_Logo.svg", height: 22pt)
        ],
        [#text(weight: "bold")[#m.title #if m.subtitle != none {
              [\- #m.subtitle]
            }] #linebreak()
          #m.author #if m.institute != none {
            [\- #m.institute]
          }],
        align(right)[
          #toolbox.slide-number/#toolbox.last-slide-number],
      )
    }
  }
}

// ============================================
// Theme Setup
// ============================================

#let setup(
  aspect-ratio: "16-9",
  title: none,
  subtitle: none,
  author: none,
  institute: none,
  date: none,
  color-primary: primary-color,
  color-accent: accent-color,
  body,
) = {
  // Store metadata in state
  meta-state.update((
    title: title,
    subtitle: subtitle,
    author: author,
    institute: institute,
    date: date,
  ))

  set text(
    font: ("Helvetica Neue", "Roboto"),
    weight: "light",
    size: 16pt,
    fill: text-color,
  )

  // Page setup
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: white,
    margin: (x: 3em, top: 3em, bottom: 4em),
    footer: hm-footer(),
  )

  // Heading styles
  show heading.where(level: 1): set text(
    size: 28pt,
    fill: black,
    weight: "bold",
  )

  show heading.where(level: 2): set text(
    size: 22pt,
    fill: hm-dark-gray,
    weight: "bold",
  )

  // List styling
  set list(
    marker: (
      text(fill: color-accent, size: 16pt, [▶]),
      text(fill: color-accent.darken(20%), [▶]),
      text(fill: color-accent.darken(40%), [▶]),
    ),
    indent: 0.25em,
  )
  set enum(indent: 1em)

  body
}
