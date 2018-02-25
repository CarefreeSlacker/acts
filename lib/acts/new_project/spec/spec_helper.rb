require 'require_all'
require 'yaml'
require 'capybara/rspec'
require 'turnip/capybara'
require 'turnip/rspec'
require 'site_prism'
require 'init_utils'
require 'pry-byebug'
require 'chromedriver/helper'
require "selenium-webdriver"



include InitUtils

ENV['SERVER'] ||= 'rubygems.org'

ENV['USE_TURNIP'] ||= 'false'
ENV['CHROME_DRIVER_VERSION'] ||= '2.33'

puts '============================================='
puts 'Welcome Acceptance Testing'
puts "Using server: #{ENV['SERVER']}"
puts "Chrome driver version: #{ENV['CHROME_DRIVER_VERSION']}"
puts `google-chrome-stable --version`
puts '============================================='

Chromedriver.set_version ENV['CHROME_DRIVER_VERSION']

init_capybara
init_rspec
init_site_prism

require_all('spec/support/**/*.rb')
require_all('spec/steps/**/*.rb')
