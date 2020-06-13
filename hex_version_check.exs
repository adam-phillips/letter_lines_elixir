# Define a required version of hex, then parse the return value from a Mix command to ensure the requirement is met,
# or raise a descriptive error if not
required_hex_version = "0.20.5"

"mix"
|> System.cmd(["hex"])
|> elem(0)
|> String.split("\n")
|> List.first()
|> String.trim()
|> case do
     "Hex v" <> ^required_hex_version ->
       nil

     "Hex v" <> other ->
       raise "Invalid hex version: #{other}, required: #{required_hex_version}. If a newer version of hex is available,
       please update hex_version_check.exs"
   end
