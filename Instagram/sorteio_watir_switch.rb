require 'watir'
require 'gemoji'
require_relative 'emoji.rb'

class Instagram

    def initialize(user, search)
        puts '=> Você deseja visualizar a execução?
                1 - Sim
                2 - Não'
        headless = gets.chomp.to_i

        if headless == 1
            headless = false
        else
            headless = true
        end
        @user = user
        @pesquisa = search
        @qtde = 4000

        Watir.logger.level = :error
        @browser = Watir::Browser.new :chrome, headless: headless
        @browser.goto "https://www.instagram.com"
        login
        @browser.send_keys :enter
        comments
    end

    def login
        @browser.text_field(name: 'username').set "jpersan0#{@user}"
        @browser.text_field(name: 'password').set '02042010'
    end

    def switch_accounts
        @y = 0
        
        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]").click
        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]/div[2]/div[2]/div[2]/div[1]").click
        @browser.button(text: 'Log into an Existing Account').click #click botão para logar nova conta
        login
        #@browser.div(class: 'mwD2G').click
        @browser.button(text: 'Log In').click
        @browser.div(class: 'EPjEi').wait_while(&:present?)

    end

    def search(item)
        @browser.text_field(class_name: 'XTCLo').set item
        @browser.div(class: 'uyeeR').click
    end

    def comments
        search(@pesquisa)

        x = 2424
        @y = 0
        while x < @qtde       
            @browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: 1).click
            @browser.div(class: 'RxpZH').click
            @browser.textarea(class: 'Ypffh').set $emoji.raw #+ " #{x}"
            @browser.send_keys :enter
            sleep 5

            if @y == 3 or @browser.text.include?('post comment.')
            #if @browser.text.include?('post comment.')
                @browser.send_keys :escape
                case @user
                    when 1
                        @user = 2
                     when 2
                        @user = 3
                    when 3
                        @user = 4
                    when 4
                        @user = 5
                    when 5
                        @user = 6
                    when 6
                        @user = 1
                end
                switch_accounts
                search(@pesquisa)
            sleep 60
            
            else
                @browser.send_keys :escape
                sleep 30
            end
            puts x
            x+=1
            @y+=1
        end
    end
end

sorteio = Instagram.new(1, 'binhhoovideos')