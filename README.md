<img src="https://media.giphy.com/media/13lIFCT4YxJSes/giphy.gif" width="100%" />

# Jared's Advent of Code Solutions

Hey, I'm Jared and I sometimes participate in [Advent of Code](https://adventofcode.com/), a fun annual competition (but there's no requirement that you approach it competitively) where programmers are given a two-part problem solve every day from December 1st to 25th. This project contains my solutions, as well as a handy script to set up each problem.

If you'd like to use this as a template for your own solutions, simply fork it and remove the solutions: `git rm -rf ./201*`

## Usage

```
# Install dependencies (really just pry):
$ bundle install

# To run a puzzle (creating it if it doesn't exist) run ./puzz with the year
# (e.g. "2018"), the day (e.g. "15") and which part of the puzzle you want to
# run (either "1" or "2").

# The following command with run part two of puzzle 15 from 2018:
$ bundle exec ./puzz 2018 15 2
Solution: 0

# If the puzzle hasn't been initialized yet, that previous command creates this
# simple file structure:
$ tree 2018
2018
└── 15
    ├── input.txt
    └── puzzle.rb

1 directory, 2 files

# 2018/15/input.txt will be an empty file and 2018/15/puzzle.rb will contain a
# PartOne and PartTwo class (PartTwo inherits from PartOne) that load the input
# file. The classes implement a "solve" method that is expected to spit out the
# result of the problem.
```
