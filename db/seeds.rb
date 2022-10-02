# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category_1 = Category.create(title: 'Ruby')
category_2 = Category.create(title: 'Rails')
category_3 = Category.create(title: 'SQL')
category_4 = Category.create(title: 'HTML')

test_1 = Test.create(title: 'Структура HTML-документа', level: 0, category_id: category_4.id)
test_2 = Test.create(title: 'Разметка текста', level: 0, category_id: category_4.id)
test_3 = Test.create(title: 'Интерфейсы, наследование и полиморфизм', level: 1, category_id: category_1.id)
test_4 = Test.create(title: 'Блоки, Proc и lambda', level: 1, category_id: category_1.id)

question_1 = Question.create(body:'Что такое блоки?', test_id: test_4.id)
question_2 = Question.create(body:'Что такое proc?', test_id: test_4.id)
question_3 = Question.create(body:'Что такое lambda?', test_id: test_4.id)
question_4 = Question.create(body:'За что отвечает тег <head>?', test_id: test_1.id)

answer_1 = Answer.create(body: 'Методы без названия', correct: true, question_id: question_3.id)
answer_2 = Answer.create(body: 'Перенос строки', correct: false, question_id: question_4.id)
answer_3 = Answer.create(body: 'Создание гипертекстовой ссылки.', correct: false, question_id: question_4.id)
answer_4 = Answer.create(body: 'Представление тела документа', correct: false, question_id: question_4.id)

user_1 = User.create(name: 'Ruby', password: 'Bury', email: 'ruby@gmail.com')
user_2 = User.create(name: 'Rails', password: 'Liars', email: 'rails@gmail.com')

Usertest.create(user_id: user_1.id, test_id: test_1.id, status: 0)
Usertest.create(user_id: user_2.id, test_id: test_2.id, status: 1)
Usertest.create(user_id: user_1.id, test_id: test_3.id, status: 1)
