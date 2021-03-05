require 'faker'
require 'rubocop-faker'

class Gerador
  def rua
    Faker::Config.locale = 'pt-BR'
    rua = Faker::Address.street_name
  end
end