# remkit

Collection of scripts, agent skills, snippets, customisations, and tools.

2026 Rémino Rem <https://remino.net/>

- [Code](https://github.com/remino/remkit)
- [Site](https://remino.github.io/remkit/)

<!-- mtoc-start -->

- [Browser tools](#browser-tools)
- [Toolbox](#toolbox)
- [Development](#development)
    - [Bookmarklets](#bookmarklets)
- [Licence](#licence)

<!-- mtoc-end -->

## Browser tools

- `bookmarklets/` contains installable bookmarklets and their source files.
  Import [bookmarklets/index.html](bookmarklets/index.html) to add them to a
  browser.
- `userscripts/` contains userscripts for a userscript manager such as
  [Tampermonkey](https://www.tampermonkey.net/) or
  [Violentmonkey](https://violentmonkey.github.io/).
- `userstyles/` contains userstyles for
  [Stylus](https://add0n.com/stylus.html/).

Some bookmarklets have their own pages:

- [Contrast Checker](https://remino.github.io/remkit/bookmarklets/contrast-checker/)
- [Japaste](https://remino.github.io/remkit/bookmarklets/japaste/)

## Toolbox

- `customized/` holds application and terminal customizations.
- `cheatsheets/` and `quickref/` hold command and application references.
- `snippets/` holds reusable examples across languages.
- `skills/` holds reusable agent skills.
- The remaining top-level directories contain focused utilities and
  configuration for tools such as Karabiner, Photoshop, Raycast, JXA, and
  shaders.

## Development

### Bookmarklets

Install dependencies with `npm install`, copy
`bookmarklets/_template.bookmarklet.js` to a numbered bookmarklet filename, then
run `npm start`. The generated bookmark file is `bookmarklets/index.html`.

Build the accompanying Jekyll site with `rake build`, or run it locally with
live reload using `rake serve`.

## Licence

See `LICENSE.txt`.
