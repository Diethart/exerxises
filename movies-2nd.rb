unless File.file?(ARGV[0])
  abort("File doesn't exist")
end

filmstop = File.open(ARGV[0]) { |file| file.readlines }
filmstop.each do |film|
  filmstopseparated = film.split('|')
  if filmstopseparated[1].include?("Time")
    rating =  filmstopseparated[7].to_f - filmstopseparated[7].to_i 
    print filmstopseparated[1], " "
    print "*"*(rating*10).round
    print "\n"
  end
end
