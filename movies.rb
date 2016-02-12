matrixvalue = "matrix"
titanicvalue = "titanic"

arg = ARGV.join(" ")

if arg == matrixvalue
	puts "Matrix is a good film"
elsif arg == titanicvalue
	puts "Titanic is also a good film"
else
	puts "I haven't seen this movie yet"
end

goodfilms = ["matrix", "citizen kane", "mad max"]
badfilms = ["green elephant", "elki", "best movie"]

if goodfilms.include?(arg)
	puts "This film in the lists of good films"
elsif badfilms.include?(arg)
	puts "This film in the lists of bad films"
else
	puts "This film is not in the list"
end

