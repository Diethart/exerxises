require 'ostruct'
require 'csv'
require 'pp'
require 'date'

unless File.file?(ARGV[0])
  abort("File doesn't exist")
end

#Получение массива строк с фильмами
ATTR = %w[refer name date country premier genre length rating director actor]
filmstop = CSV.read(ARGV[0], {:col_sep =>'|'}).map { |film| film = OpenStruct.new(Hash[ATTR.zip(film)]) }

#Сортировка по длине
longest = filmstop.sort_by { |film| film.length.to_i}.reverse.first(5)

#Вывод 5-ти самых длинных фильмов
longest.each { |film| puts "#{film.name} "}

#Сортировка по жанру "Комедия" и сортировка получившегося массива по дате выпуска
onlycomedyfilms = filmstop.select { |film| film.genre.include?("Comedy") }.sort_by { |film| film.date.to_i }

#Вывод получившегося массива комедий
onlycomedyfilms.each { |film| puts "#{film.name} #{film.date}" }

#Получение массива фильмов, снятых не в США
puts filmstop.reject { |film| film.country == "USA" }.count

#Получение Hash'а "актер - количество фильмов"
actorsarray = filmstop.map {|actor| actor.actors.split(',')}.flatten

actorshash = actorsarray.reduce(Hash.new(0)) do |actorslist, actor| 
  actorslist[actor] += 1 
  actorslist
end  

actorshash.each { |actor, countfilms| puts "#{actor}: #{countfilms}" }

#Группировка по режиссеру
filmstop.group_by(&:director).each { |director, film| puts "#{director}: #{film.size}"}

#Получение массива режиссеров с сортировкой по фамилии
puts filmstop.map(&:director).uniq.sort_by { |director| director.split(" ").last }

#Получение статистики выхода фильмов по месяцам
monthstat = filmstop.reduce(Hash.new(0)) do |stat, film| 
  begin
    stat[Date.strptime(film.premier,'%Y-%m').month] += 1
  rescue
    next(stat)
  end
  stat
end

pp monthstat
