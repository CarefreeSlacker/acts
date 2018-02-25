# language: ru
# encoding: utf-8
Функция: Поиск Gem "Acceptance Testing"

  Сценарий: Поиск Gem "Acceptance Testing"
    Когда пользователь открывает "rubygems.org"
    И вводит в поле поиска "acceptance_testing"
    И нажимает клавишу "enter"
    Тогда открывается gem "acceptance_testing"
