#import "@preview/codelst:2.0.2": sourcecode

// Link Settings
#show link: set text(fill: rgb(0, 0, 100)) // make links blue
#show link: underline // underline links

// Heading Settings
#show heading.where(level: 1): it => {    
  text(2em)[#it.body]
}
#show heading.where(level: 2): set text(size: 1.5em)
#show heading.where(level: 3): set text(size: 1.2em)
#set heading(numbering: "1.")

// Raw Blocks
#set raw(theme: "./theme.tmTheme")
#show raw: set text(font: "Iosevka NF", size: 8pt)
#show raw.where(block: true): it => block(
  inset: 8pt,
  radius: 5pt,
  text(it),
  stroke: (
    left: 2pt + luma(230),
  )
)
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

// Font and Language
#set text(
  lang: "cs",
  font: "Latin Modern Sans",
  size: 11pt,
)

// TITLE PAGE begin
#include "title.typ"
// TITLE PAGE end

// Paper Settings
#set page(paper: "a4")


// Paragraph Settings
#set par(
  justify: true,
  first-line-indent: 1em,
  linebreaks: "optimized",
)

// Text margins
#set block(spacing: 2em)
#set par(leading: 0.8em)

// Start the Page Counter
#counter(page).update(1)

#v(8em)
#include "outline.typ"
#pagebreak()


= Relační model

== Grafický tvar relačního datového modelu
#align(horizon)[
  #figure(
    image("./conceptual_relational_model_cardinal.svg"),
    gap: 6em,
    caption: [Relační model]
  )
]


#pagebreak()


== Popis tabulek 

- #[
  _*user*_ - 
  Záznam reprezentuje jednoho uživatele s osobními informacemi, 
  jako je uživatelské jméno, e-mail, křestní a příjmení, 
  datum registrace, URL profilového obrázku a další detaily, 
  jako je sekce "o mně".
] 

- #[
  _*channel*_ - 
  Záznam reprezentuje jeden kanál vlastněný uživatelem. 
  Obsahuje název kanálu, popis a datum vytvoření, spolu 
  s referencí na uživatele, který kanál vlastní.
] 

- #[
  _*video*_ - 
  Záznam reprezentuje jedno video nahrané na kanál. 
  Obsahuje detaily, jako je název videa, popis, URL, 
  náhledový obrázek, nastavení viditelnosti, status monetizace, 
  datum nahrání, délka a počet zhlédnutí, spolu s referencí na kanál, 
  ke kterému video patří.
] 

- #[
  _*playlist*_ - 
  Záznam reprezentuje jeden playlist vytvořený uživatelem. 
  Obsahuje název playlistu, uživatele, který playlist vytvořil, 
  a nastavení viditelnosti playlistu, spolu s datem vytvoření.
]


- #[
  _*playlist_video*_ - 
  Záznam reprezentuje video v playlistu. 
  Spojuje konkrétní video s konkrétním playlistem
  a uchovává datum, kdy bylo video do playlistu přidáno.
]


- #[
  _*comment*_ - 
  Záznam reprezentuje jediný komentář napsaný uživatelem k videu. 
  Obsahuje text komentáře, datum, a referenci na uživatele, 
  který komentář napsal, a video, ke kterému byl komentář přidán. 
  Může mít také referenci na nadřazený komentář, pokud se jedná o odpověď.
]


- #[
  _*reaction*_ - 
  Záznam reprezentuje reakci uživatele na cílový prvek 
  (video, komentář nebo příspěvek). 
  Obsahuje typ reakce (like, dislike, love), datum reakce, 
  a referenci na cíl (video `video_id` nebo komentář `comment_id`) 
  a uživatele, který reagoval.
] 

- #[
  _*subscription*_ - 
  Záznam reprezentuje odběr uživatele na kanál. 
  Obsahuje referenci na odběratele (uživatele) 
  a kanál, na který se uživatel přihlásil, 
  spolu s preferencemi pro oznámení a datem přihlášení k odběru.
] 


- #[
  _*video_view*_ - 
  Záznam reprezentuje zhlédnutí videa uživatelem. 
  Uchovává délku zhlédnutého času, datum zhlédnutí 
  a referenci na video a uživatele, který video zhlédl.
] 

- #[
  _*video_category*_ - 
  Záznam reprezentuje přiřazení kategorie k videu. 
] 

- #[
  _*category*_ - 
  Záznam reprezentuje jednu kategorii videí. 
  Může mít nadřazenou kategorii (vytváří hierarchickou strukturu) 
  a obsahuje název kategorie.
] 

- #[
  _*advertisement*_ - 
  Záznam reprezentuje jednu reklamu s jejím obsahem, 
  cílovou skupinou, URL obrázku, odkazem na CTA (Call to Action), 
  stavem (aktivní, neaktivní, vypršelo), 
  mírou prokliku, příjmem a rozpočtem.
] 

- #[
  _*video_advertisement*_ - 
  Záznam reprezentuje umístění reklamy ve videu. 
  Spojuje video s reklamou, specifikuje typ reklamy 
  (pre-roll, mid-roll, post-roll nebo banner) 
  a čas začátku a konce reklamy.
] 


- #[
  _*ad_impression*_ -
  Záznam reprezentuje zobrazení reklamy uživatelem ve videu. 
  Obsahuje reklamu, uživatele, který reklamu viděl, video, 
  ve kterém se reklama objevila, datum a čas zobrazení, zařízení, 
  které uživatel použil, a informaci o tom, zda byla reklama zakliknuta.
] 

#pagebreak()


= Skripty
== DDL Skript

#let ddl_script = read("./DDL_script.sql")

#sourcecode[
  #raw(ddl_script, lang: "sql")
]

== DML Skript

#let dml_script = read("./DML_script.sql")

#sourcecode[
  #raw(dml_script, lang: "sql")
]

// == Integritní omezení
//
// #sourcecode[```sql
// ALTER TABLE [user] ADD CONSTRAINT chk_email_format CHECK ([email] LIKE '%_@_%._%')
// GO
// ```] 
//
//
// == Cizí klíče
//
// #let ddl_foreign_keys = read("./ddl_foreign_keys.sql")
// #sourcecode[
//   #raw(ddl_foreign_keys)
// ]
//
//
// == Indexy
//
// #let ddl_indexes_script = read("./ddl_indexes.sql")
//
// #sourcecode[
//   #raw(ddl_indexes_script)
// ]
//
//
//
