#import "@preview/touying:0.7.4": *
#import "hm.typ": *

#show: hm-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Project Typst HM Presentation Theme],
    subtitle: [Getting Started with Typst's Touying],
    author: [Simon Mederer],
    date: datetime.today(),
    institution: [Munich University of Applied Sciences],
    contact: [contact\@mail.com],
    logo: none,
  ),
)
#title-slide()

#new-section-slide([Motivation])

#slide([
  == Subtitle
  - Typst is great
    - touying for creating presentations
      - touying for creating presentations
  - HM theme, because logos and colors are nice
])

#slide([
  == New Slide 2
  - Typst is great
    - touying for creating presentations
      - touying for creating presentations
  - HM theme, because logos and colors are nice
])

#new-section-slide([New Section])

#slide([
  == Subtitle
  - Typst is great
    - touying for creating presentations
      - touying for creating presentations
  - HM theme, because logos and colors are nice
])

#slide([
  == New Slide 2
  - Typst is great
    - touying for creating presentations
      - touying for creating presentations
  - HM theme, because logos and colors are nice
])


#focus-slide([Motivation2])

#matrix-slide(columns: 2, rows: 2, [Top Left], [Top Right], [Bottom Left], [Bottom Right])
