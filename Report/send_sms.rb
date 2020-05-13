require_relative 'googlesheet'
require 'uri'
require 'net/http'
require 'openssl'

@@contato = Report.new

url = URI("https://sms.comtele.com.br/api/v2/send")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["content-type"] = 'application/json'
request["auth-key"] = 'a2a81b06-53ed-4cbe-ab56-5ed22dc8aa17'
request.body = "{\"Sender\":\"sender_id\",\"Receivers\":\"#{@@contato.consulta_telefone}\",\"Content\":\"Olá #{@@contato.consulta_relatorio}, recebemos seu relatório de atividades. Obrigado. Fica com Jeová!\"}"
response = http.request(request)


