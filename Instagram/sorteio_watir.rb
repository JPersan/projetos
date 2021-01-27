require 'watir'
require 'gemoji'
require_relative 'emoji.rb'

puts '=> Você deseja visualizar a execução?
        1 - Sim
        2 - Não'
headless = gets.chomp.to_i

if headless == 1
    headless = false
else
    headless = true
end

# puts '=> Informe seu usuário:'
# user = gets.chomp.to_s

# puts '=> Informe sua senha:'
# pass = gets.chomp.to_s

# puts '=> Informe a quantidade de comentários que deseja fazer:'
# qtde = gets.chomp.to_i

# puts '=> Escreva seu comentário:'
# msg = gets.chomp.to_s

user = 'jpersan01'
pass = '02042010'
qtde = 1


Watir.logger.level = :error
browser = Watir::Browser.new :chrome, headless: headless
browser.goto "https://www.instagram.com"

browser.text_field(name: 'username').set user
browser.text_field(name: 'password').set pass

browser.send_keys :enter
sleep 5


browser.text_field(class_name: 'XTCLo').set 'binhhoovideos'
browser.div(class: 'uyeeR').click

x = 0 
while x < qtde       
    browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: 1).click
    browser.div(class: 'RxpZH').click
    browser.textarea(class: 'Ypffh').set $emoji.raw
    browser.send_keys :enter
    sleep 5

    if browser.text.include? 'post comment.'
       browser.send_keys :escape
       puts 'Msg exibida. Aguardar 60seg'
       sleep 500

    else
        browser.send_keys :escape
        puts x
        sleep 50
    end
    x+=1

end
  
