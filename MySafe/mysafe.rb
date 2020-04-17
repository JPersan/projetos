#require 'hg-finance'
require 'httparty'

class API
    include HTTParty
    @@url = "http://api.hgbrasil.com/finance/stock_price?key=7ace0e46&symbol="

    
        print '
        => MENU: 
            (1) Cadastrar Carteira
            (2) Alterar Carteira
            (3) Atualizar Carteira
        
            => Informe a opção desejada: '

        def menu 
            opcao = gets.chomp.to_i
        case opcao
            when 1
                if File.exist?('minha_carteira.txt') == true
                   print 'Vocë já possui uma carteira cadastrada. Informe outra opção: '
                   self.menu
                else
                    cadastrar_carteira
                end 
            when 2
                if File.exist?('minha_carteira.txt') == false
                    print 'Vocë ainda não possui uma carteira cadastrada. Deseja cadastrar? (y/n) '
                    ret = gets.chomp
                    if ret.downcase == 'y'
                        cadastrar_carteira
                    else
                        exit
                    end
                else
                    alterar_carteira
                end
            when 3
                puts 3
        end
    end
    
    def cadastrar_carteira
        print '
        => Informe quantas ações vocë possui em sua carteira: '
        qtd_acoes = gets.chomp.to_i
        y = 0
        x = 1

        carteira = Array.new    
        qtd_acoes.times do
        papel = "ação #{x}"
        print "             * Informe o código da #{papel}: "
        @acao = gets.chomp
        print "             * Informe o valor de compra do ativo - #{@acao}: "
        @valor = gets.chomp    
        carteira.push(@acao)
        x+=1
        end
 
        qtd_acoes.times do
        #dados_acao(carteira[y])
        y+=1
        end
        arq = File.new("minha_carteira.txt", "w")
        vlr = carteira.join(";")
        arq.puts vlr 
        arq.close
    end

    def alterar_carteira
        carteira = Array.new
        dados = File.read('minha_carteira.txt')
        carteira = dados
        puts carteira[0]
    end

    def dados_acao(titulo)
        response = HTTParty.get("#{@@url}#{titulo}")
        valor = response.parsed_response
        valor['results']
    end
end

cotacao = API.new
cotacao.menu