# terminfo - WIP - API NOT STABLE AT ALL!

[WIP] A Crystal library to parse and use terminfo database

DO NOT USE, the API might change!

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  terminfo:
    github: bew/terminfo.cr
```

## Usage

See [the samples](samples/) and the [database specs](spec/database_spec.cr) for up-to-date usage examples.

```crystal
require "terminfo"

# do stuff..
```

## Development

Also see [dev notes](Notes.md).

### Progress

**Done**:
- Search terminfo database in standards directories from the terminal name
- Terminfo database parsing to a `Terminfo::Database` object (extracts all standards number/boolean/string capabilities)
- Get/Set number/boolean/string capabilities

**TODO**:
- Parameterized string parser & executor (see references below)
- Documentation
- Parser specs
- Allow to generate a terminfo database from a Terminfo object (to be used in parser specs)
- Allow to parse & query/set terminfo extensions (non-standards capabilities)
- (maybe) Make names database (`src/terminfo/names.cr`) less memory hungry?
- ...

### Used references

[unibilium](https://github.com/mauke/unibilium)

[term (rust)](https://github.com/Stebalien/term): A Rust library for terminfo parsing and terminal colors.
- [its parser](https://stebalien.github.io/doc/term/src/term/terminfo/parser/compiled.rs.html)
- [its param parser/exec](https://stebalien.github.io/doc/term/src/term/terminfo/parm.rs.html)

[terminfo (go)](https://github.com/xo/terminfo/): Terminfo for Go
- [parametizer](https://github.com/xo/terminfo/blob/master/param.go)

[rust-terminfo (rust)](https://github.com/meh/rust-terminfo/): Terminfo for Rust
- [param expander](https://github.com/meh/rust-terminfo/blob/master/src/expand.rs): It uses a kind of iterator producing states, and switching on each state.

Compiled terminfo format man page: https://www.systutorials.com/docs/linux/man/5-term/

Source terminfo format: http://pubs.opengroup.org/onlinepubs/7908799/xcurses/terminfo.html (not used ATM)

Full (almost) doc on terminfo, param strings, usages, etc.. [linux - man5 - terminfo](https://linux.die.net/man/5/terminfo)

About [Control Functions, Escape Sequences, and VT-Keys](https://support2.microfocus.com/techdocs/1364.html) (not official, but still interesting!)
[Control characters](https://en.wikipedia.org/wiki/Control_character)

Full XTerm Control Sequences doc: http://invisible-island.net/xterm/ctlseqs/ctlseqs.html

### Misc

Cool lib [termfest (rust)](https://github.com/agatan/termfest) (using `term`, see above)

## Contributing

1. Fork it ( https://github.com/bew/terminfo.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

Also, feel free to open an issue for anything (feature idea, implementation idea, or just discuss about the project).

## Contributors

- [bew](https://github.com/bew) Benoit de Chezelles - creator, maintainer
