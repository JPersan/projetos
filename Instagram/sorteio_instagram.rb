require 'watir'
require 'gemoji'
require 'whatlanguage'
require_relative 'emoji.rb'

class Instagram

    puts '=> Qual instagram voce quer pesquisar?'
    $pesquisa = gets.chomp

    def initialize(search)
        @wl = WhatLanguage.new(:all)
        # puts '=> Você deseja visualizar a execução?
        #         1 - Sim
        #         2 - Não'
        # headless = gets.chomp.to_i

        # if headless == 1
        #     headless = false
        # else
        #     headless = true
        # end

        #@usuarios = ["jpersan01", "jpersan02", "jpersan03", "jpersan04", "jpersan05", "jpersan06"]
        #@usuarios = ["jpersan03", "jpersan04", "jpersan05", "jpersan06"]
        @usuarios = []
        @qtde = 10000
        @user = 0

        puts '=> Iniciado em 0(zero) qual posição a foto do sorteio está na timeline do instagram?'
        @foto = gets.chomp

        puts '=> Quais usuários voce pretende logar no instagram? (Para cada usuário digite e pressione ENTER. Para o ultimo usuário pressione ENTER 2x)'
        
        while true
            input = gets.chomp
            break if input.empty?
                @usuarios << input
        end
        
        @usuarios.join(", ")

        puts '=> Qual a senha dos usuários?(A senha precisa ser igual para todos os usuários que inseriu. Digite apenas uma única vez e pressione ENTER.)'
        @senha = gets.chomp

        Watir.logger.level = :error
        @browser = Watir::Browser.new :chrome, headless: false
        @browser.goto "https://www.instagram.com"
        idioma
        login
        puts '############  CONTADOR DE COMENTÁRIOS  ##############'
        comments
    end

    def login
        @browser.text_field(name: @username).set @usuarios[@user]
        @browser.text_field(name: @password).set @senha
        @browser.send_keys :enter
        @browser.button(text: @login_facebook).wait_while(&:present?) #aguarda até a tela de login sumir 

        if @browser.text.include?(@turn_on_notification).to_s #popup de notificação
            @browser.button(text: @not_now).click #click no botão do popup
        end
    end

    def switch_accounts
        @y = 0

        if @user >= @usuarios.count
            @user=0
        end

        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]").click
        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]/div[2]/div[2]/div[2]/div[1]").click
        #@browser.button(text: 'Log into an Existing Account').click #click botão para trocar de conta
        login
        #@browser.div(class: 'mwD2G').click #flag para armazenar dados de conta logada
        #@browser.button(text: 'Log In').click

        if @browser.text.include?(@msg_erro)
            @usuarios.delete(@usuarios[@user])
            puts 'msg erro login'
            @user+=1
            login
        # elsif  
        #     @browser.text.include?('Facebook')
        #     login
        #     @browser.button(text: 'Log In').click
        # else
        end

        #@browser.div(class: 'EPjEi').wait_while(&:present?)
    end

    def search(item)
        @browser.text_field(class_name: 'XTCLo').when_present.set item
        @browser.a(text: /#{$pesquisa}/).focus
        @browser.send_keys :enter
    end

    def comments
        search($pesquisa)
        x = 0 #contador
        @y = 0

        while x < @qtde 
            sleep 2      
            @browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: @foto.to_i).click #o index é a posição da foto na timeline iniciada em 0
            @browser.div(class: 'RxpZH').click
            @browser.textarea(class: 'Ypffh').set $emoji.raw #+ " #{x}"
            @browser.send_keys :enter
            sleep 5
            @browser.send_keys :escape

            if @y == 3 #qtde de comentários por usuario
               if @usuarios.count != 1
                  @user+=1 
                  switch_accounts
                  search($pesquisa)
               else
                  x+=1
                  puts x
                  sleep 50 #tempo de espera de um comentario para o outro
               end
            elsif @browser.text.include?(@post_comment).to_s and @usuarios.count == 1
                  puts '############  FIM DA EXECUÇÃO  ##############'
                  puts "=> Quer executar o script novamente?(Y/N)"
                    opt = gets.chomp
                    if opt == "y"
                        @browser.close
                        initialize($pesquisa)
                    else
                        exit #a execução finalizará quando houver apenas um usuário e exibir a mensagem de comentário bloqueado
                    end
            elsif @browser.text.include?(@post_comment).to_s
                  @usuarios.delete(@usuarios[@user]) #usuário bloqueado é removido para não logar novamente durante esta execução
                  puts @usuarios
                  @user = 0
                  switch_accounts
                  search($pesquisa)
            else
                sleep 50 #tempo de espera de um comentario para o outro
                x+=1
                @y+=1
                puts x
            end
        end
    end

    def idioma
        button = @browser.element(xpath: '//*[@id="loginForm"]/a').text
        idioma = @wl.language(button)
        puts idioma

        if idioma == ':portuguese'
            @username = 'usuário'
            @password = 'senha'
            @turn_on_notification = 'Ativar notificações' 
            @not_now = 'Agora não'
            @post_comment = 'Não foi possível publicar o comentário.'
            @login_facebook = 'Entrar com o Facebook'
            @msg_erro = 'problema'
        else
            exit
        end
    end
end

sorteio = Instagram.new($pesquisa)