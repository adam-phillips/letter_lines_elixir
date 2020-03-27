ExUnit.start()

# Create mock for use only in test env
Mox.defmock(LetterLinesElixir.DictionaryFileProvider.Mock, for: LetterLinesElixir.DictionaryFileProvider.Behaviour)
