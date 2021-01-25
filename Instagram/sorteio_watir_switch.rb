require 'watir'
require 'gemoji'
require_relative 'emoji.rb'

class Instragram

    
    def comment
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
        qtde = 2

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
            browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: 0).click
            browser.div(class: 'RxpZH').click
            browser.textarea(class: 'Ypffh').set $emoji.raw
            browser.send_keys :enter
            sleep 5

            if x == 2 
                browser.send_keys :escape
                conta
            else
                browser.send_keys :escape
                puts x
                sleep 15
            end
            x+=1

        end
    end

    def conta
        browser.div(class: 'Fifk5', index: 4).click #click perfil
        browser.div(id: 'fb7c9e0ed08fc4').click #click opção switch
        #browser.text.include? 'jpersan02'
        browser.button(text: 'Log into an Existing Account').click #click botão para logar nova conta
    end

end


sorteio = Instragram.new
sorteio.comment