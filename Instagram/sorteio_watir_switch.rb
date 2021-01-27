require 'watir'
require 'gemoji'
require_relative 'emoji.rb'

class Instagram

    def start
        puts '=> Você deseja visualizar a execução?
                1 - Sim
                2 - Não'
        headless = gets.chomp.to_i

        if headless == 1
            headless = false
        else
            headless = true
        end

        @qtde = 2

        Watir.logger.level = :error
        @browser = Watir::Browser.new :chrome, headless: headless
        @browser.goto "https://www.instagram.com"
        @user = 1
        login
        @browser.send_keys :enter
        conta
        #comment
    end

    def login
        @browser.text_field(name: 'username').set "jpersan0#{@user}"
        @browser.text_field(name: 'password').set '02042010'
    end

    def conta
        @browser.div(class: 'Fifk5', index: 4).click
        @browser.div(class: '-qQT3').click
        @user = 2

        if @browser.div(text: 'jpersan01' && 'jpersan02') == false
               @browser.button(text: 'Log into an Existing Account').click #click botão para logar nova conta
               login
               @browser.div(class: 'mwD2G').click
               @browser.button(text: 'Log In').click

               if @user == 2
                    @user = 1
               end
        end
    end
end

    # def comment
    #     @browser.text_field(class_name: 'XTCLo').set 'binhhoovideos'
    #     @browser.div(class: 'uyeeR').click

    #     x = 0 
    #     while x < @qtde       
    #         @browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: 1).click
    #         @browser.div(class: 'RxpZH').click
    #         @browser.textarea(class: 'Ypffh').set $emoji.raw
    #         @browser.send_keys :enter
    #         sleep 5

    #         puts x
    #         if x == 1 
    #             @browser.send_keys :escape
    #             switch_accounts
    #         else
    #             @browser.send_keys :escape
    #             puts x
    #             sleep 15
    #         end
    #         x+=1

    #     end
    # end
#end


sorteio = Instagram.new
sorteio.start