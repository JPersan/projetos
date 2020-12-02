require 'watir'

puts '=> Você deseja visualizar a execução?
        1 - Sim
        2 - Não'
headless = gets.chomp.to_i

if headless == 1
    headless = false
else
    headless = true
end

puts '=> Informe seu usuário:'
user = gets.chomp.to_s

puts '=> Informe sua senha:'
pass = gets.chomp.to_s

puts '=> Informe a quantidade de comentários que deseja fazer:'
qtde = gets.chomp.to_i

puts '=> Escreva seu comentário:'
msg = gets.chomp.to_s

Watir.logger.level = :error
browser = Watir::Browser.new :chrome, headless: headless
browser.goto "https://www.instagram.com"

browser.text_field(name: 'username').set user
browser.text_field(name: 'password').set pass

browser.send_keys :enter
browser.text_field(class_name: 'XTCLo').set 'binhhoovideos'
browser.div(class: 'uyeeR').click


x = 0
while x < qtde       
    browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: 0).click
    sleep 5
    browser.div(class: 'RxpZH').click
    browser.textarea(class: 'Ypffh').set msg
    browser.send_keys :enter

    sleep 5

    if browser.text.include? 'post comment.'
       puts 'msg exibida. Aguardar 50seg'
       sleep 50

    else
        puts x
    end

    browser.send_keys :escape
    x+=1
    
end
  
