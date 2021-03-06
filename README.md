# Shazbot

ShazBot is an IRC bot based on Cinch.

## Installation

`git clone https://github.com/honkfestival/shazbot.git`

## Configuration

From the ShazBot directory, create a file `config/shazbot.edn`. ShazBot uses all of the normal Cinch configuration options. For an example, see `config/shazbot.edn.example`.

## Running ShazBot

Again from the ShazBot directory, `bundle exec bin/shazbot` to connect!

## Plugins

ShazBot comes with several plugins:

**Hello** - Say `!hello` to ShazBot!

**The Tao** - ShazBot can recite entries from [The Tao of Programming](http://www.canonical.org/~kragen/tao-of-programming.html) with e.g. `!tao book 2 chapter 2`. ShazBot can also produce random sections (`!tao random`) or search the text (`!tao branches`).

## Contributing

Please submit pull requests! :space_invader:
