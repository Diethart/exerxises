unless File.file?(ARGV[0])
  abort("File doesn't exist")
end

#Получение массива строк с фильмами
filmstop = File.open(ARGV[0]) { |file| file.readlines }

#Разделение строк на части и превращение каждого элемента массива в словарь
filmstop.map! do |film|
  film = film.split('|')
  film = { name: film[1], date: film[2], country: film[3],
		   premier: film[4], genre: film[5], length: film[6],
		     rating: film[7], director: film[8], actors: film[9]}
end

#Сортировка по длине
mostlengthfilms = filmstop.sort_by { |film| film[:length].to_i}.reverse.first(5)

#Вывод 5-ти самых длинных фильмов
puts "Most length movies:", " "
mostlengthfilms.each do |film|
  puts film[:name], " "
end

#Сортировка по жанру "Комедия" и сортировка получившегося массива по дате выпуска
onlycomedyfilms = filmstop.select { |film| film[:genre].include?("Comedy") }
onlycomedyfilms.sort_by! { |film| film[:date].to_i }

#Вывод получившегося массива комедий
puts " ", "Comedy sorted by date"
onlycomedyfilms.each do |film|
  puts " ", film[:name] +  " " + film[:date]
end

#Получение массива фильмов, снятых не в США
notusafilms = filmstop.reject { |film| film[:country] == "USA" }
puts notusafilms.count

#Получение Hash'а "актер - количество фильмов"

actorsarray = filmstop.map {|actor| actor[:actors].split(',')}.flatten

actorshash = actorsarray.reduce(Hash.new(0)) do |actorslist, actor| 
  actorslist[actor.chomp] += 1 
  actorslist
end  

actorshash.each { |actor, countfilms| puts "#{actor}: #{countfilms}" }

#Группировка по режиссеру
filmstop.group_by { |film| film[:director] }.each { |director, film| puts "#{director}: #{film.size}"}

#Получение массива режиссеров с сортировкой по фамилии
puts filmstop.map { |film| film[:director] }.uniq.sort_by { |director| director.split(" ").last }
