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

#Получение хеша режиссеров
directorsmassive = filmstop.map { |film| film[:director] }
initial = Hash.new(0)
finalhashofdir = directorsmassive.reduce(initial) do |hashdir, director|
  hashdir[director] += 1
  hashdir
end

#Конвертация хеша в массив с массивами
directorsarray = finalhashofdir.to_a

#Сортировка по фамилии и вывод
directorsarray.sort_by! { |director| director[0].split.last }
directorsarray.each { |director| puts director[0] + " " + director[1].to_s }

#Получение массива фильмов, снятых не в США
notusafilms = filmstop.reject { |film| film[:country] == "USA" }
puts notusafilms.count


#Группировка по режиссеру
bydirector = filmstop.group_by { |film| film[:director] }
puts bydirector.count


#Получение Hash'а "актер - количество фильмов"
start = Array.new(0)
actorsarray = filmstop.reduce(start) do |finalarray, film| 
  finalarray+=film[:actors].split(',')
  finalarray
end

final = Hash.new(0)
actorshash = actorsarray.reduce(final) do |finalhash, actor| 
  finalhash[actor] += 1 
  finalhash
end  

actorshash.each { |key, value| puts key.chomp + " " + value.to_s }
