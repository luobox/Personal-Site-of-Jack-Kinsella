require "twitter"
results = Twitter.search("to:jackkinsella i-want-your-decks")
results.each {|tweet| puts tweet.text}
relevant_authors = results.map &:from_user
database_name = "i-want-your-decks.txt"
saved_authors = File.read(database_name).split
authors_to_be_saved = relevant_authors - saved_authors
puts "About to save: #{authors_to_be_saved}"
File.open(database_name, "a") {|file| file.write(authors_to_be_saved.join("\n")) }
