# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  User.create(username: "Morgan", password: "Morgan1")
  User.create(username: "Mom", password: "Ilovemorgan")
  User.create(username: "UsErnaMe", password: "Password")

indianajones = Movie.find_or_create_by(name:"Raiders of the Lost Ark", director:"Steven Spielberg", genre:"Adventure", release_date:"1981", user_id:1)
spiderman2 = Movie.find_or_create_by(name:"Spider-Man 2", director:"Sam Raimi", genre:"Action", release_date:"2004", user_id:1)
batmanbegins = Movie.find_or_create_by(name:"Batman Begins", director:"Christopher Nolan", genre:"Action", release_date:"2005", user_id:1)
inception = Movie.find_or_create_by(name:"Inception", director:"Christopher Nolan", genre:"Thriller", release_date:"2010", user_id:1)
twelveangrymen = Movie.find_or_create_by(name:"12 Angry Men", director:"Sidney Lumet", genre:"Drama", release_date:"1957", user_id:1)
sevensamurai = Movie.find_or_create_by(name:"Seven Samurai", director:"Akira Kurosawa", genre:"Action", release_date:"1954", user_id:1)
emperorsnewgroove = Movie.find_or_create_by(name:"Emperor's New Groove", director:"Mark Dindal", genre:"Comedy", release_date:"2000", user_id:2)
lawrenceofarabia = Movie.find_or_create_by(name:"Lawrence of Arabia", director:"David Lean", genre:"Drama", release_date:"1962", user_id:2)
paulblartmallcop = Movie.find_or_create_by(name:"Paul Blart: Mall Cop", director:"Andy Fickman", genre:"Comedy", release_date:"2009", user_id:2)
goodfellas = Movie.find_or_create_by(name:"Goodfellas", director:"Martin Scorsese", genre:"crime", release_date:"1990", user_id:3)
jurassicpark = Movie.find_or_create_by(name:"Jurassic Park", director:"Steven Spielberg", genre:"Adventure", release_date:"1993", user_id:3)
minorityreport = Movie.find_or_create_by(name:"Minority Report", director:"Steven Spielberg", genre:"Sci-fi", release_date:"2002", user_id:3)
