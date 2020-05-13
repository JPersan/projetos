require "google_drive"
require 'openssl'
require 'spreadsheet'

class Report
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

    def initialize
        session = GoogleDrive::Session.from_config("client_secrets.json")
        @ws_google = session.spreadsheet_by_key("1Wa2mseqrmB0wpGiCY61wg5IYlgmC6QdCa5wsEJDUiwk")
    end
        
    def consulta_relatorio 
        lin = @ws_google.worksheets[2].num_rows
        @nome = @ws_google.worksheets[2][lin, 1]
        return @nome
    end

    def consulta_telefone
        consulta_relatorio
        ws = Spreadsheet.open('contatos.xls')
        ws_local = ws.worksheet('Telefone')
        l = 2

        while @nome != ws_local[l, 0] do
            l +=1
        end

        return ws_local[l, 1].to_i
    end
end