require_relative 'designacao'

class Programacao

    puts 'Informe o Mës da Programação: '
    Mes = gets.chomp.to_s

    puts "Informe o dia da 1ª Segunda Feira de #{Mes}: "
    Seg = gets.chomp.to_i
    
    @@des = Designacao.new
    
    def gerar_programacao
        
        File.open("Programacao.txt", "w") do |file|
        file.puts "CONGREGACAO VILA MARCONDES – 25.726"
        file.puts "\nProgramacao do mes de #{Mes}."
        
        s = 1
        dia = Seg    
        while s <= 4
            
            sem = dia + 6 
            semana = "#{dia} - #{sem}"
            dia+=7

            file.puts "\nSemana de #{semana}"     
            id = 0
            y = 1
            
            @@des.abrir_planilha(y)
            file.puts "\n#{@@des.ler_planilha}"
            file.puts "Sala A"
                    
            until @@des.estudante(id)[1] == "A" do  
                id+=1
            end

            file.puts "\t#{@@des.estudante(id)[0][0]}"
            @@des.atualiza_data
            @@des.atualiza_sala

            id=0
            until @@des.estudante(id)[1] == "B" do  
                id+=1
            end

            file.puts "Sala B"
            file.puts "\t#{@@des.estudante(id)[0][0]}"
            @@des.atualiza_data
            @@des.atualiza_sala
            
            id = 0
            desig = s
            case desig
            when 1
                y = 3
                @@des.abrir_planilha(y)
                file.puts "\n#{@@des.ler_planilha}"
                file.puts "Sala A"
                        
                until @@des.estudante(id)[1] == "A" do  
                    id+=1
                end
    
                file.puts "\t#{@@des.estudante(id)[0][0]}"
                @@des.atualiza_data
                @@des.atualiza_sala
                
                id=0
                until @@des.estudante(id)[1] == "B" do  
                    id+=1
                end
                
                file.puts "Sala B"
                file.puts "\t#{@@des.estudante(id)[0][0]}"
                @@des.atualiza_data
                @@des.atualiza_sala
            when 2
                y = 2
                @@des.abrir_planilha(y)
                file.puts "\n#{@@des.ler_planilha}"
                file.puts "Sala A"

                3.times do
                    until @@des.estudante(id)[1] == "A" do  
                        id+=1
                    end

                    file.puts "\t#{@@des.estudante(id)[0][0]} / #{@@des.ajudante(id)[0]}"
                    @@des.abrir_planilha(y)
                    @@des.atualiza_data
                    @@des.atualiza_sala
                end

                id=0
                file.puts "Sala B"
                3.times do
                    until @@des.estudante(id)[1] == "B" do  
                        id+=1
                    end

                    file.puts "\t#{@@des.estudante(id)[0][0]} / #{@@des.ajudante(id)[0]}"
                    @@des.abrir_planilha(y)
                    @@des.atualiza_data
                    @@des.atualiza_sala
                end
                
                id = 0
            when 3, 4
                y = 2
                @@des.abrir_planilha(y)
                file.puts "\n#{@@des.ler_planilha}"
                file.puts "Sala A"

                2.times do
                    until @@des.estudante(id)[1] == "A" do  
                        id+=1
                    end

                    file.puts "\t#{@@des.estudante(id)[0][0]} / #{@@des.ajudante(id)[0]}"
                    @@des.abrir_planilha(y)
                    @@des.atualiza_data
                    @@des.atualiza_sala
                end

                id=0
                file.puts "Sala B"
                2.times do
                    until @@des.estudante(id)[1] == "B" do  
                        id+=1
                    end

                    file.puts "\t#{@@des.estudante(id)[0][0]} / #{@@des.ajudante(id)[0]}"
                    @@des.abrir_planilha(y)
                    @@des.atualiza_data
                    @@des.atualiza_sala
                end
            end                
        s+=1
        end
        @@des.fechar_xls
        end
    end
end

gerar = Programacao.new
gerar.gerar_programacao
