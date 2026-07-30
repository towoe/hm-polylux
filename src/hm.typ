// University theme

// Originally contributed by Pol Dellaiera - https://github.com/drupol

#import "@preview/touying:0.7.4": *
#import "colors.typ": *

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }

  let header(self) = {
    place(top + left)[
      #if self.store.progress-bar {
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.tertiary,
        )
      }
    ]

    set std.align(left + top)
    place(top + right)[
      #image("HM_Logo_Text_red.pdf", height: 2.5cm)
    ]
  }
  let footer(self) = {
    set std.align(center + bottom)
    set text(size: .4em)
    {
      let cell(..args, it) = components.cell(
        ..args,
        inset: 1mm,
        std.align(horizon, text(fill: black, it)),
      )
      show: block.with(width: 100%, height: auto)
      grid(
        columns: self.store.footer-columns,
        rows: 1.5em,
        cell(stroke: self.colors.primary, fill: self.colors.primary.lighten(60%), utils.call-or-display(
          self,
          self.store.footer-a,
        )),
        cell(stroke: self.colors.secondary, fill: self.colors.secondary.lighten(60%), utils.call-or-display(
          self,
          self.store.footer-b,
        )),
        cell(stroke: self.colors.tertiary, fill: self.colors.tertiary.lighten(60%), utils.call-or-display(
          self,
          self.store.footer-c,
        )),
      )
    }
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})


#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config,
  )
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }

  let body = {
    place(right, image("HM_Logo_Text_red.pdf", height: 2.5cm))

    place(left + horizon, dx: 25%, dy: 10%, {
      box(width: 75%, {
        // Title
        text(size: 22pt, weight: "bold", fill: black)[
          #upper(self.info.title)
        ]

        v(0.5em)
        // Subtitle
        text(size: 18pt, fill: black, style: "italic", weight: "light")[
          #info.subtitle
          #linebreak()
        ]

        // Author
        text(size: 16pt, weight: "light", fill: black)[
          #linebreak()
          #info.author
        ]

        text(size: 16pt, weight: "light")[
          #linebreak()
          #info.institution
        ]

        // Date
        text(size: 14pt, weight: "light")[
          #linebreak()
          #info.date.display()
        ]
      })
    })
  }
  touying-slide(self: self, body)
})


#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em, fill: black, weight: "bold")
    // utils.display-current-heading(level: level, numbered: numbered)
    body
    stack(
      dir: ttb,
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(
          height: 4pt,
          self.colors.primary,
          self.colors.primary-light,
        ),
      ),
    )
  }
  touying-slide(self: self, config: config, slide-body)
})

#let focus-slide(
  config: (:),
  background-color: none,
  background-img: none,
  body,
) = touying-slide-wrapper(self => {
  let background-color = if (
    background-img == none and background-color == none
  ) {
    rgb(self.colors.primary)
  } else {
    background-color
  }
  let args = (:)
  if background-color != none {
    args.fill = background-color
  }
  if background-img != none {
    args.background = {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    }
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 1em, ..args),
  )
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 2em)
  touying-slide(self: self, std.align(horizon, body))
})


#let matrix-slide(
  config: (:),
  columns: none,
  rows: none,
  ..bodies,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(
    self: self,
    config: config,
    composer: components.checkerboard.with(columns: columns, rows: rows),
    ..bodies,
  )
})

#let hm-theme(
  aspect-ratio: "16-9",
  align: top,
  progress-bar: true,
  header: utils.display-current-heading(level: 2, style: auto),
  header-right: self => (image("HM_Logo_Text_red.pdf", height: 2.5cm)),
  footer-columns: (25%, 1fr, 25%),
  footer-a: self => self.info.author,
  footer-b: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-c: self => {
    h(1fr)
    utils.display-info-date(self)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
    h(1fr)
  },
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 2em, bottom: 1.25em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        show heading.where(level: 3): set text(fill: black)
        show heading.where(level: 4): set text(fill: black)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: hm-red,
      secondary: hm-accent1,
      tertiary: hm-accent2,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    // save the variables for later use
    config-store(
      align: align,
      progress-bar: progress-bar,
      header: header,
      header-right: header-right,
      footer-columns: footer-columns,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
    ),
    ..args,
  )

  // List styling
  set list(
    marker: (
      text(fill: hm-red, [▶]),
      text(fill: hm-accent1, [▶]),
      text(fill: hm-accent2, [▶]),
    ),
    indent: 0.25em,
  )

  body
}
