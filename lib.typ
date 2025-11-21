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

#let title-slide(
  title: [],
  subtitle: [],
  author: [],
  institute: [],
  date: [],
) = slide[
  #set align(center + horizon)
  #set text(fill: text-color)

  #context {
    let m = meta-state.get()

    place(top + right)[
      #image("img/HM_Logo_Text_red.pdf", height: 2.5cm)
    ]

    place(left + horizon, dx: 25%, dy: 10%, {
      let override-or-meta(value, meta-value) = if value == [] {
        meta-value
      } else { value }

      text(size: 22pt, weight: "bold", fill: black)[
        #upper(override-or-meta(title, m.title))
      ]

      v(0.5em)

      text(
        size: 18pt,
        fill: black,
        style: "italic",
        weight: "light",
      )[
        #override-or-meta(subtitle, m.subtitle)
        #linebreak()
      ]

      text(
        size: 16pt,
        weight: "light",
        fill: black,
      )[
        #linebreak()
        #override-or-meta(author, m.author)]

      text(size: 16pt, weight: "light")[
        #linebreak()
        #override-or-meta(institute, m.institute)]

      text(size: 14pt, weight: "light")[
        #linebreak()
        #override-or-meta(date, m.date)]
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
        if m.footer-hide == false {
          align(right)[
            #toolbox.slide-number#if m.footer-show-final-number == true {
              [/#toolbox.last-slide-number]
            }]
        },
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
  footer-hide: false,
  footer-show-final-number: true,
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
    footer-hide: footer-hide,
    footer-show-final-number: footer-show-final-number,
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
      text(fill: color-accent, top-edge: "ascender", [▶]),
      text(fill: color-accent.darken(20%), top-edge: "ascender", [▶]),
      text(fill: color-accent.darken(40%), top-edge: "ascender", [▶]),
    ),
    indent: 0.25em,
  )
  set enum(indent: 1em)

  body
}


// ============================================
// BMFTR Note
// ============================================

#let hm-bmftr-note(language: "en", dx: 50pt, dy: 50pt) = {
  if language == "de" {
    place(bottom + right, dx: dx, dy: dy)[
      #stack(spacing: 0pt, align(left)[#text(size: 8pt)[Gefördert durch]], box(
        width: 6cm,
      )[
        #image("img/BMFTR_Logo_DE.svg", width: 6cm)
      ])
    ]
  } else if language == "en" {
    place(bottom + right, dx: dx, dy: dy)[
      #stack(spacing: 0pt, align(left)[#text(size: 8pt)[Funded by]], box(
        width: 6cm,
      )[
        #image("img/BMFTR_Logo_EN.svg", width: 6cm)
      ])
    ]
  }
}

// ============================================
// Helper Components
// ===========================================

#let footer-check(hide: true) = {
  if hide == false {
    hm-footer()
  }
}

// ============================================
// Slide Layouts
// ============================================

#let slide-vertical(title, body, hide-footer: false) = slide[
  #set page(footer: footer-check(hide: hide-footer))
  #heading[#title]
  #align(horizon)[
    #body
  ]
]

#let slide-centered(title, body, hide-footer: false) = slide[
  #set page(footer: footer-check(hide: hide-footer))
  #heading[#title]
  #align(center + horizon)[
    #body
  ]
]

#let slide-split-2(title, left, right, hide-footer: false) = slide[
  #set page(footer: footer-check(hide: hide-footer))
  #heading[#title]
  #grid(
    columns: (1fr, 1fr),
    rows: 1fr,
    left, right,
  )
]

#let slide-split-1-2(
  title,
  left-content,
  right-content,
  bg-color: white,
  hide-footer: false,
) = slide[
  #set page(
    background: place(left + top, box(
      width: 30%,
      height: 100%,
      fill: bg-color,
    )),
  )
  #set page(footer: footer-check(hide: hide-footer))
  #heading[#title]
  #grid(
    columns: (1fr, 2fr),
    rows: 1fr,
    left-content, right-content,
  )
]

// ============================================
// Section Support
// ===========================================

#let page-progress = toolbox.progress-ratio(ratio => {
  set grid.cell(inset: (y: .05em))
  grid(
    columns: (ratio * 100%, 1fr),
    grid.cell(fill: primary-color)[],
    grid.cell(fill: primary-color.luma().lighten(50%))[],
  )
})

#let new-section(name, show-slide: true) = {
  toolbox.register-section(name)
  if show-slide == true {
    slide({
      set page(header: none, footer: none)
      show: pad.with(x: 10%, y: 25%)
      set text(size: 22pt, weight: "bold")
      name
      page-progress
    })
  }
}

#let new-section-orientation(name, highlight-color: none) = slide({
  set page(header: none, footer: none)
  show: pad.with(x: 10%, y: 5%)
  set text(size: 22pt)

  toolbox.register-section(name)

  toolbox.all-sections((sections, current) => {
    for section in sections {
      if section == current {
        text(
          weight: "bold",
          fill: if highlight-color != none { highlight-color } else {
            text.fill
          },
          top-edge: "ascender",
        )[#section]
      } else {
        text(weight: "light", fill: text.fill.lighten(50%))[#section]
      }
      linebreak()
    }
  })

  align(bottom)[
    #page-progress
  ]
})

#let toc = toolbox.all-sections((sections, _cur) => {
  list(..sections)
})

#let slide-toc(title: "Content") = slide[
  #set page(footer: none)
  #heading[#title]
  #text(size: 22pt, weight: "light")[
    #grid(
      columns: (1fr, 7fr, 2fr),
      rows: (5fr, 1fr),
      [], align(horizon, toc),
    )
  ]
]
