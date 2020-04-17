require 'rubygems'
require 'faker'
require 'cpf_faker'
require 'win32ole'
require 'fileutils'
require 'spreadsheet'

class Gerador
    Faker::Config.locale = 'pt-BR'
    
    puts '

************************************************************   
________      _____                        
\______ \    /     \ _____    ______ ______
 |    |  \  /  \ /  \\__  \  /  ___//  ___/
 |    `   \/    Y    \/ __ \_\___ \ \___ \ 
/_______  /\____|__  (____  /____  >____  >
        \/         \/     \/     \/     \/ 1.1

=> Informe os dados que necessita gerar (Ex: 1,3,4): 
        (1) Nome
        (2) E-mail
        (3) CPF
        (4) RG (em manutenção)
        (5) Endereço'

    Dados = gets.chomp
    
    Dado = Dados.split(',')

    puts "
=> Informe a quantidade:"
    Qtd = gets.chomp.to_i

    def verificar_dir
        if Dir.exist?('C:\DMass') == false
            FileUtils.mkdir_p 'C:\DMass'
        else 
            FileUtils.rm_rf('C:\DMass\dmass_dados.xlsx')
        end    
    end

    def gerar_excel
        @plan = WIN32OLE.new('Excel.Application')

        @workbook = @plan.Workbooks.Add();
        @worksheet = @workbook.Worksheets(1);
        @worksheet.name = 'MassaDados'
        @worksheet.Rows(1).Font.Bold = true
        @worksheet.Cells(1,1).HorizontalAlignment = -4108
       #@worksheet.Columns(1).ColumnWidth = 70
    end

    def gerar_dado
        verificar_dir
        gerar_excel
 
        count = Dado.size
        x = 0
        c = 1
        count.times do
            l = 2

            case Dado[x].to_i
                when 1 
                    Qtd.times do
                        person_name     = Faker::Name.name
                        #puts person_name
                        @worksheet.Cells(1, c).Value = 'NOME'
                        @worksheet.Cells(l, c).Value = person_name
                        l+=1
                    end
                when 2
                    Qtd.times do
                        person_email    = Faker::Internet.email
                        #puts person_email
                        @worksheet.Cells(1, c).Value = 'E-MAIL'
                        @worksheet.Cells(l, c).Value = person_email
                        l+=1
                    end
                when 3
                    Qtd.times do
                        person_cpf      = Faker::CPF.numeric
                        #puts person_cpf
                        @worksheet.Cells(1, c).Value = 'CPF'
                        @worksheet.Cells(l, c).Value = person_cpf
                        l+=1
                    end
                when 4
                    Qtd.times do
                        person_rg      = Faker::IDNumber.numeric
                        puts person_rg
                        @worksheet.Cells(1, c).Value = 'RG'
                        @worksheet.Range(l, c).Value = person_rg
                        l+=1
                    end
                when 5
                    #@plan.visible = true
                    Qtd.times do
                        street          = Faker::Address.street_name
                        number          = Faker::Address.building_number
                        city            = Faker::Address.city
                        #state_uf        = Faker::Address.state_abbr
                        addr = ["#{street}, #{number} - #{city}"]
                        #puts addr.class
                        @worksheet.Cells(1, c).Value = 'ENDERECO'
                        @worksheet.Cells(l, c).Value = addr
                        l+=1
                    end

                    l=2
                    Qtd.times do
                        state           = Faker::Address.state
                        @worksheet.Cells(1, c + 1).Value = 'ESTADO'
                        @worksheet.Cells(l, c + 1).Value = state        
                        l+=1
                    end
            end
            x += 1
            c += 1
        end
        salvar_excel
    end

    def salvar_excel
        time = Time.now.strftime("%H%M%S")
        @worksheet.Range('A:E').EntireColumn.AutoFit
        @workbook.SaveAs("C:\\DMass\\dmass_dados_#{time}")
        @plan.ActiveWorkbook.Close(0)
        @plan.ole_free
        @plan = nil
        GC.start
    end

end

gerar = Gerador.new
gerar.gerar_dado