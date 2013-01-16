# CHANGELOG

## Version 0.2 – December 18, 2012
**Pre-Launch Prototype**
- improved Language maps, Alternations index page, Alternation detail page, Language detail page
- improved Coding frame index and detail pages, Meanings index and Meaning detail page
- changed color schema: higher contrast colors to improve legibility on projector
- added feedback link (points to [this LinguaWiki page](http://lingweb.eva.mpg.de/linguawiki/index.php/ValPaL_Preview))

## November 9, 2012
- **new feature** toggle columns of dataTables on/off
- column filters on dataTables: per button groups

## October 2012
**technical improvements**
- upgraded to Boostrap v2.1.0; refactored stylesheets
- reorganized JavaScript files for better modularity; translate custom jQuery plugins and custom jQuery datatables plugins to CoffeeScript
- changed top navbar behaviour w/tooltip for Languages dropdown menu
- added Meanings dropdown to navbar

## September 21, 2012
**minor improvements**
- languages dropdown menu now more compact (in columns)
- rearranged layout of [Verb detail](http://192.168.4.58:3000/languages/hoocak/verbs/4522363293-hiroji) page
- **Coding frames**: created basic [list view](http://192.168.4.58:3000/languages/even/coding_frames)
- **Meanings**: created [list view](http://192.168.4.58:3000/meanings/)
  and preliminary [detail page](http://192.168.4.58:3000/meanings/talk)

## September 5, 2012
**minor improvements**
- "replace me!" Coding frames are now displayed as empty
- table sorting arrows now to the left of column header
- Verb details page:
  - comment on verb form hidden; can be toggled with button
  - improved sorting of alternation values: Regular first, those with examples first
  - Alternation values' examples now displayed as Primary text + Translation
  - only the first example shown, the others can be revealed optionally

## August 31, 2012
**minor improvements**
- switched to human-readable [URL parameters](https://github.com/fanaugen/valency/issues/1)
- improved data import script: skips Brad's dummy records
- added [dropdown menu for Languages](https://github.com/fanaugen/valency/wiki/Nav-bar:-language-specific-info) in the top navigation bar:
  - if you're viewing the page of a language-specific resource such as a Verb form or Coding frame,
    selecting a different language leads you to the same resource (in list view) of that language
  - otherwise it just points you to the language info page

## Version 0.1.0 (August 24, 2012)
**first usable prototype**
- working Verbs list and Verb detail page
- object-language text is displayed in italics
- in Examples, Analyzed text and Gloss are vertically aligned
- gloss abbreviations show up in <span style="font-variant:small-caps">small caps</span>
- Microroles are listed per Meaning and derived Coding Frames' Microroles are listed separately 
