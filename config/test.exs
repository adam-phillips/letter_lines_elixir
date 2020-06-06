use Mix.Config

# Define a Mock for wherever the authoritative dictionary is derived
config :letter_lines_elixir, dictionary_file_provider: LetterLinesElixir.DictionaryFileProvider.Mock
