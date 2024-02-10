#let template(title: "", author: "", date: datetime.today(), body) = {
  set document(title: title, author: author)
  set page(paper: "us-letter")

  set text(font: "Source Serif 4", size: 10pt)
  show link: underline

  set par(justify: true)
  show heading: it => {
    set block(below: 0.8em)
    set text(font: "Montserrat", weight: 600)
    it
  }

  let headingtext = {
    set text(font: "Montserrat")
    set block(spacing: 0.75em)
    block(text(size: 2.25em, weight: 600, title), below: 2em)
    block(text[FRC Team 3636 --- Generals Robotics])
    block(text(author))
    block(text(date.display("[month repr:long] [day padding:none], [year repr:full]")))
  }

  stack(
    dir: ltr,
    spacing: 1fr,
    headingtext,
    style(styles => block(height: measure(headingtext, styles).height, image("images/3636-star.svg")))
  )

  v(3em)

  columns(2, body)
}