[![Build Status](https://travis-ci.org/adam-phillips/letter_lines_elixir.svg?branch=master)](https://travis-ci.org/adam-phillips/letter_lines_elixir)

# LetterLinesElixir

LetterLinesElixir is a Mix project containing the logic around a word game which will be ported to a Phoenix
 project. The game presents a board similar to a crossword puzzle, and a group of letters. The player uses these
  letters one-by-one to build a word. A Scrabble dictionary is the authoritative source to determine if a
   submitted word is valid.
   
If a submitted word is valid and fits a slot on the board, it is displayed in place. If a word exists but is not part
 of the board, the player still gets credit, and the word is "dropped in a bucket" of valid words not included on the
  board. In the case of the player submitting an invalid word, an error will display verbiage explaining the
   submission is not a word.
   
### Gameplay Nuances

* No matter how many letters are in the letter group, there will _always_ be at least one word that requires all
 letters to be formed. It's also possible that more than one word can be formed by using all letters.
* Words must be at least three letters long to be considered valid
* There is no penalty for submitting a previously guessed word. This will simply trigger a message explaining the
 word has been used.
* **Forthcoming**: There will be a set of perks for purchase by a player if they have enough points earned to pay the
 cost
    * **Random Reveal**: the cheapest perk; when used, a random empty space on the board has its corresponding letter
     permanently revealed. This is truly random, with no control over what space reveals.
    * **Bullseye**: this perk allows a player to select an empty space anywhere on the board and have the corresponding
     letter permanently revealed. This is functionally like the `Random Reveal` except the player chooses where to
      reveal instead of using a random process.
    * **Letter Explosion**: the most expensive but effective perk; this perk "pops" with the result being a number of
     empty spaces permanently showing their corresponding letter. The number of revealed letters is not set, instead
      being a calculated percentage of blank spaces on the board.
      
---

## Code Quality

`:githooks` are enabled for the development environment, and enforce different levels and types of code quality based
 on the git command run:
 * `pre_commit` - before a commit can successfully complete, file formatting is checked with `mix format` and a
  number of flags.
    * `--check-formatted` - checks a file to determine whether it has been formatted
    * `--dry-run` - formats files where necessary, but doesn't save changes
    * `--check-equivalent` - checks whether the files have the same AST before and after formatting is performed
* **Be aware** that if any of the `--check-*` options fail, the git process terminates, formatted contents revert, and
 no formatting results write to STDIO. Hence it being advantageous to familiarize yourself with `githooks` and
  enforcements ahead of time.
 
### Reviewing Established Quality Standards
Please review the following to become familiar with quality enforcement and avoid surprises:
* `.credo.exs` - Credo configuration file with an extensive list of Credo checks. Details about specific checks can
 be reviewed [in the Credo Hexdocs](https://hexdocs.pm/credo/overview.html)
    * **It is important to understand** - some Credo checks labeled as controversial or experimental are enabled and
     enforced on this project
* `.formatter.exs` - options used with `mix format`
* `dev.exs` - all `githook` configurations are defined in this file, with code quality actions listed under the
 corresponding git action
* `.iex.exs` - modules listed in this file are automatically aliased when starting an iEX session as a time saver
. Many are not, but often used modules with long names have been included as a convenience.
* `.tool-versions` - this project was built and is maintained using language versions managed by the very useful tool
 `asdf`. This file is read by `asdf` to ensure proper language versions are used with the project in case multiple
  versions are installed. If the required version is not installed, you'll receive a warning that proper version is a
   requirement.
   
## Testing
Every attempt has and will continue to be made to maintain excellent test coverage of the codebase. There are a few
 customizations and additions to make this endeavor easier and more effective through quality feedback loops.
* `ExCoveralls`: this dependency has been added and configured to provide meaningful data regarding code coverage
    * `$ MIX_ENV=test mix coveralls` - running this from the command line returns a relatively simple console
     printout of each file, percentage of code coverage, lines present, relevant lines, and missed lines
    * `$ MIX_ENV=test mix coveralls.detail | less -R` - prints the same report as above to the console, but follows with
     file-by-file details. The piping to `less` with the `R` flag is optional, but the results are paginated and use
      color.
      * Scrolling through pagination will expose the full source contents of all tested files.
      * Within files, relevant lines that were missed will be colored red, and those that were hit during testing are green.
      * If you need to quit while scrolling through the paginated results, simply press `q` to return to a command
       prompt
    * `MIX_ENV=test mix coveralls.detail --filter some_file.ex` - similar to the previous `.detail` command, but
     accepts a single file for which to show results. The overall results are printed, followed by the full source
      contents of the provided file with the same color coding of red/green to determine lines that were hit or
       missed by tests. This prints the file without pagination, so it's easy to see by scrolling.
    * What you _really_ want whether you realize it or not: `$ mix coverage_report`
      * Under the hood, this command runs `$ MIX_ENV=test mix coveralls.html` but some tailoring is in
       `mix.exs` to enhance value. 
      * `coverage_report` is not a prexisting `mix` task. It is instead an alias that calls a function of the same
       name. This function runs the `coveralls.html` task, determines the current operating system, then issues the
        OS specific command to opening the HTML version of the coveralls report in the default
        browser. 
      * As before, full file source is available with hit/missed lines of code colored green/red. This method is much
       easier to see and work with through generated file links on a clean HTML page opposed to "bursts" of terminal
        output
* **Please** be sure your `.gitignore` file has an entry for both `/cover/` and `/cover` as different runs can
 create artifacts that should not be committed. If you'd like to read more and work with different Coveralls options
 , the [documentation available in the repo](https://github.com/rrrene/excoveralls/blob/master/README.md) is great
 
 # Committing and Pushing Changes
 `master` is the only protected branch on the project, and has additional rules applied through GitHub. Any feature
  work, bug fixes, hot fixes, or code push at all should be submitted as a PR against `master`. Force pushing to
   `master` is disabled for commits from anyone, but the merge process is still simple. PR review approvals, admin
    involvement, and similar features are disabled. The requirements to merge are passing status checks - currently
     TravisCI - and the PR branch must be current with `master`.
     
The `Allow merge commits` option in GitHub has been disabled in favor of other options that better preserve git
 history with "responsible" `Squash and merge`ing being the preference. Please format the autogenerated commit
  message when taking this route though and ensure individual commit messages are preserved.
  
If merging is urgent, any committer with admin rights can bypass the `status check` requirement and force a merge
 before TravisCI has completed.
