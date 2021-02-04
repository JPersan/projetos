require 'watir'
require 'gemoji'
require_relative 'emoji.rb'

class Instagram

    def initialize(search)
        # puts '=> Você deseja visualizar a execução?
        #         1 - Sim
        #         2 - Não'
        # headless = gets.chomp.to_i

        # if headless == 1
        #     headless = false
        # else
        #     headless = true
        # end

        @pesquisa = search
        @qtde = 10000
        @usuarios = ["jpersan01", "jpersan02", "jpersan03", "jpersan04", "jpersan05", "jpersan06"]
        #@usuarios = ["jpersan01", "jpersan02", "jpersan04"]
        @user = 0

        # puts '=> Quais usuários voce pretende logar no instagram? (Para cada usuário digite e pressione Enter.)'
        
        # while true
        #     input = gets.chomp
        #     break if input.empty?
        #         @usuarios << input
        # end
        
        # @usuarios.join(", ")

        Watir.logger.level = :error
        @browser = Watir::Browser.new :chrome, headless: false
        @browser.goto "https://www.instagram.com"

        login
        @browser.send_keys :enter
        comments
    end

    def login
        @browser.text_field(name: 'username').set @usuarios[@user]
        @browser.text_field(name: 'password').set '02042010'
    end

    def switch_accounts
        @y = 0

        if @user >= @usuarios.count
            @user=0
        end

        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]").click
        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]/div[2]/div[2]/div[2]/div[1]").click
        @browser.button(text: 'Log into an Existing Account').click #click botão para logar nova conta
        login
        #@browser.div(class: 'mwD2G').click
        @browser.button(text: 'Log In').click
        @browser.button(text: 'Log In').wait_while(&:present?)

        if @browser.text.include?('There was a problem logging you into Instagram.')
            @usuarios.delete(@usuarios[@user])
            puts 'msg erro login'
            @user+=1
            login
        elsif  
            @browser.text_field(name: 'username').present?
            login
        else
        end

        @browser.div(class: 'EPjEi').wait_while(&:present?)

    end

    def search(item)
        @browser.text_field(class_name: 'XTCLo').set item
        @browser.div(class: 'uyeeR').click
    end

    def comments
        search(@pesquisa)
        x = 791
        @y = 0

        while x < @qtde       
            @browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: 1).click # O index é a posição da foto na timeline iniciada em 0
            @browser.div(class: 'RxpZH').click
            @browser.textarea(class: 'Ypffh').set $emoji.raw #+ " #{x}"
            @browser.send_keys :enter
            sleep 5
            @browser.send_keys :escape

            if  @y == 3
                @user+=1 
                switch_accounts
                search(@pesquisa)
            elsif 
                @browser.text.include?('post comment.')
                @usuarios.delete(@usuarios[@user])
                puts @usuarios
                @user = 0
                switch_accounts
                search(@pesquisa)
            else
                @browser.send_keys :escape
                sleep 30
                @y+=1
            end
            x+=1
            puts x
        end
    end
end

sorteio = Instagram.new('redbrandao')