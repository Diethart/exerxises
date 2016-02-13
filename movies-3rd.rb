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
filmstop.sort_by! { |film| film[:length].to_i}
filmstop.reverse!
mostlengthfilms = filmstop.take(5)

#Вывод 5-ти самых длинных фильмов
puts "Most length movies:", " "
mostlengthfilms.each do |film|
  puts film[:name], " "
end

#Сортировка по жанру "Комедия" и сортировка получившегося массива по дате выпуска
onlycomedyfilms = filmstop.select { |film| film[:genre].to_s.include?("Comedy") }
onlycomedyfilms.sort_by! { |film| film[:date].to_i }

#Вывод получившегося массива комедий
puts " ", "Comedy sorted by date"
onlycomedyfilms.each do |film|
  puts " ", film[:name] +  " " + film[:date]
end

#Получение уникального массива режиссеров, сортированного по алфавиту
directorsmassive = filmstop.uniq { |film| film[:director] }
directorsmassive.sort_by! { |film| film[:director].to_s }

directorsmassive.each do |film|
  puts film[:director]
end

#Получение массива фильмов, снятых не в США
notusafilms = filmstop.reject { |film| film[:country] == "USA" }
puts notusafilms.count


#Группировка по режиссеру
bydirector = filmstop.group_by { |film| film[:director] }
puts bydirector.count

#Получение Hash'а "актер - количество фильмов"
start = Hash.new(0)
final = filmstop.reduce(start) do |actors, film|
  splitted = film[:actors].split(',')
  splitted.map! { |actor| actor.chomp }
  splitted.each do |actor|
    actors[actor] += 1
  end
  actors
end
puts final
