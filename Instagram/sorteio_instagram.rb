require 'watir'
require 'watir-scroll'
require 'gemoji'
require_relative 'emoji.rb'

class Instagram

    puts '=> Qual instagram voce quer pesquisar?'
    $pesquisa = gets.chomp

    $usuarios = []
    $qtde = 10000
    $user = 0
    $x = 0

    puts "=> Em qual posição está a foto do sorteio na timeline do(a) #{$pesquisa}?"
    $foto = gets.chomp

    puts '=> Qual comentário você quer fazer na publicação?'
    $comentario = gets.chomp

    puts '=> Quais usuários voce pretende logar no instagram? (Para cada usuário digite e pressione ENTER. Para o ultimo usuário pressione ENTER 2x)'
    
    while true
        input = gets.chomp
        break if input.empty?
            $usuarios << input
    end
    
    $usuarios.join(", ")

    puts '=> Qual a senha dos usuários?(A senha precisa ser igual para todos os usuários que inseriu. Digite apenas uma única vez e pressione ENTER.)'
    $senha = gets.chomp

    def initialize(search)
        begin
            @browser = Watir::Browser.new :chrome
            @browser.goto "https://www.instagram.com"
            @browser.text_field(name: 'username').wait_until(&:present?)
            
            if @browser.text.include?('Forgot password?')
                stop
            end
    
            login                                                                         
            comments

        rescue StandardError => e
            if $usuarios.count == 1
               puts e.message
            else
               @browser.close
               initialize($pesquisa)
            end
        end
    end

    def login
        @browser.text_field(name: 'username').set $usuarios[$user]
        @browser.text_field(name: 'password').set $senha
        @browser.send_keys :enter 

        sleep 1
        if @browser.text.include?('minutos')
            #$usuarios.delete($usuarios[$user])
            #puts 'msg erro login'
            #$user+=1
            sleep 120
            login
        end

        @browser.button(text: 'Entrar com o Facebook').wait_while(&:present?) #aguarda até a tela de login sumir

        @y = 0
        @k = 30
        painel  

        if @browser.text.include?('Ativar notificações') #popup de notificação
            @browser.button(text: 'Agora não').click #click no botão do popup
        end
    end

    def switch_accounts
        @y = 0

        if $user >= $usuarios.count
            $user=0
        end

        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]").click
        @browser.div(xpath: "//section/nav/div[2]/div/div/div[3]/div/div[5]/div[2]/div[2]/div[2]/div[1]").click
        login
        #@browser.div(class: 'mwD2G').click #flag para armazenar dados de conta logada
        #@browser.button(text: 'Log In').click
    end

    def search(item)
        @browser.text_field(class_name: 'XTCLo').when_present.set item
        @browser.a(text: /#{$pesquisa}/).focus
        @browser.send_keys :enter
    end

    def comments
        search($pesquisa)
        @y = 0
        @k = 30

        while $x < $qtde 
            sleep 2
            loop do
                @browser.scroll.to [10, 600]    
                break if @browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: $foto.to_i - 1).present?
            end      

            @browser.div(class: 'v1Nh3 kIKUG  _bz0w', index: $foto.to_i - 1).click #o index é a posição da foto na timeline iniciada em 0
            @browser.div(class: 'RxpZH').click
            @browser.textarea(class: 'Ypffh').set $comentario
            @browser.button(xpath: '/html/body/div[4]/div[2]/div/article/div[3]/section[3]/div/form/button[2]').click
            sleep 5
            @browser.send_keys :escape

            if @y == 30 #qtde de comentários por usuario
               if $usuarios.count != 1
                  $user+=1 
                  switch_accounts
                  search($pesquisa)
               else
                  $x+=1
                  sleep 55 #tempo de espera de um comentario para o outro
               end
            elsif @browser.text.include?('Não foi possível publicar o comentário.') and $usuarios.count == 1
                  puts '############  FIM DA EXECUÇÃO / TODOS OS USUÁRIOS ESTÃO BLOQUEADOS  ##############'
                  exit #a execução finalizará quando houver apenas um usuário e exibir a mensagem de comentário bloqueado
            elsif @browser.text.include?('Não foi possível publicar o comentário.')
                  $usuarios.delete($usuarios[$user]) #usuário bloqueado é removido para não logar novamente durante esta execução
                  $user = 0
                  switch_accounts
                  search($pesquisa)
            else
                $x+=1
                @y+=1
                sleep 55 #tempo de espera de um comentario para o outro
            end
            save_file
            painel
        end
    end

    def save_file
        time = Time.now.strftime("%I:%M %p")

        if Dir.exist?('C:\Instagram_Comentarios') == false
            FileUtils.mkdir_p 'C:\Instagram_Comentarios'
         end

        arq = File.open("C:\\Instagram_Comentarios\\sorteio_#{$pesquisa}.txt", 'w')
        arq.puts "
        Horário que parou a execução: #{time} 
        Qtde de comentários feitos: #{$x}"
        arq.close
    end

    def painel
        system 'cls'
        if $usuarios.count == 1
            puts "
###################################################################
# Número de Comentários: #{$x}                                 
# Usuários Ativos: #{$usuarios.count}                              
# Usuário Comentando: #{$usuarios[$user]}                                                 
###################################################################################"            
        else
            puts "
###################################################################
# Número de Comentários: #{$x}                                 
# Usuários Ativos: #{$usuarios.count}                              
# Usuário Comentando: #{$usuarios[$user]}                               
# Faltam #{@k-@y} comentários para a troca de usuário.                     
###################################################################################"
        end
    end
end

sorteio = Instagram.new($pesquisa)