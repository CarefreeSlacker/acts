# language: ru
# encoding: utf-8
@implemented
Функция: Формирование активности для анонимного клиента

  Как анонимный клиент, обращаясь в компанию
  Я хочу получить профильное обслуживание по интересующему меня вопросу
  но при этом я не указываю свои идентификационные данные
  Поэтому у меня должна быть возможность выбора причины обращения

  При формировании активности, сначала создается контекст Case -> Activity.

  Алгоритм ->
  ~ сначала создается Case в поле "name" которого заносится -> "Вопрос по теме #{RequestType.name}"
  ~ затем Case привязывается к RequestType в соответствии с намерением клиента
  ~ в конце Activity привязывается к созданному Case.

  Задействованные роли ->
  ~ Алексей -> анонимный клиент
  ~ Мария -> оператор

  Контекст:
    Дано что в системе имеется тип обращения "Кредиты"

  Сценарий: Показ причины обращения
    Допустим Алексей решил обратиться в банк через web-чат
    И он открыл новый чат и зашел анонимным пользователем
    И он видит текстовое меню -> "Выберите причину обращения" с не более 5-ти пунктами выбора
    И он  выбирает одну из причин обращения
    Тогда он видит сообщение -> "Здравствуйте, меня зовут Мария. Чем я могу вам помочь?"

  Сценарий: Успешное формирование активности для анонимного клиента
    Допустим Алексей решил обратиться в банк через web-чат
    Когда он открыл новый чат, выбрал зайти анонимным пользователем и выбрал причину обращения -> "Кредиты"
    Тогда в БД появляется кейс с именем -> "Вопрос по теме Кредиты"
    И этот кейс связан с причиной обращения -> "Кредиты"
    И в БД появляется новая активность, которая привязана к только что созданному кейсу
