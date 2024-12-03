#import "meta_data.typ"

#set text(
  size: 14pt,
)

#set page(
  margin: 1.2in
)

#align(top + right)[
  Vysoká škola báňská - Technická univerzita Ostrava \
  Fakulta elektrotechniky a informatiky
]

#v(50pt)

#align(horizon)[
  #text(size: 36pt, [
    *Databázové systémy 1*
  ])
  #text(size: 24pt, [
    Projekt -- YouTube-like platforma
  ])
]

#v(40pt)

#align(bottom + left)[
  Jméno: #meta_data.student_fullname \
  Osobní číslo: #meta_data.student_identifier
  #h(1fr)  
  Datum: #datetime.today().display("[day]. [month]. [year]")
]



