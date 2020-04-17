require 'win32ole'
require 'spreadsheet'

class Designacao

  def initialize
    @excel = WIN32OLE.new('excel.Application')
    @workbook = @excel.Workbooks.Open('C:\Users\je.santos\Desktop\programacao_v1\reuniao\Planilha.xls')
  end

  def abrir_planilha(plan)
    @worksheet = @workbook.Worksheets(plan)
  end

  def ler_planilha
    nome_planilha = @worksheet.name
  end

  def estudante(id)

    $qtd = @worksheet.UsedRange.Rows.Count
    
    publ = Array.new()
    publ = @worksheet.Range('a1:a'"#{$qtd}").Value
    
    data = Array.new()
    data = @worksheet.Range('b1:b'"#{$qtd}").Value
    
    sala = Array.new()
    sala = @worksheet.Range('c1:c'"#{$qtd}").Value

    arr = data.map.with_index { |_, idx| [data[idx], publ[idx], sala[idx]] }
    arr.sort!{|k,v| k <=> v}
    @desig_nome = arr[id][1]
    sala = arr[id][2]
    @desig_sala = sala.join(";")
    
    publ.each_with_index do |row, index|
      for column in 0..(row.length-1)
         if @desig_nome == row
           @vlr = index += 1
           @atualiza_data
          end
       end
     end

     return @desig_nome, @desig_sala
  end
  
  def atualiza_data
	  @atualiza_data = @worksheet.Range('b'"#{@vlr}").Value = Time.now.strftime '%m/%d/%Y'
  end

  def atualiza_sala
    if @desig_sala == 'B'
      @desig_sala = 'A'
    else
      @desig_sala = 'B' 
    end
    @atualiza_sala = @worksheet.Range('c'"#{@vlr}").Value = @desig_sala
  end

  def ajudante(id)
    abrir_planilha(4)

    $qtd1 = @worksheet.UsedRange.Rows.Count
    
    ajud = Array.new()
    ajud = @worksheet.Range('a1:a'"#{$qtd1}").Value
  
    data1 = Array.new()
    data1 = @worksheet.Range('b1:b'"#{$qtd1}").Value

    ar_ajud = data1.map.with_index { |_, idx| [data1[idx], ajud[idx]]}
    ar_ajud.sort!{|k,v| k <=> v}
    @desig_ajud = ar_ajud[id][1]
    
    ajud.each_with_index do |row, index|
      for column in 0..(row.length-1)
         if @desig_ajud == row
           @vlr = index += 1
           atualiza_data
         end
      end
    end
    return @desig_ajud
  end

  def fechar_xls
    @workbook.save
    @workbook.Close(0)
    @excel.Quit()
  end
end