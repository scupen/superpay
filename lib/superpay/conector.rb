module Superpay
  class Conector

    attr_accessor :savon_client, :ambiente, :estabelecimento, :usuario, :senha, :url

    def initialize(config, ws_tipo)
      @ambiente = config[:ambiente]
      @estabelecimento = config[:estabelecimento]
      @usuario = config[:usuario]
      @senha = config[:senha]
      @url = eval(@ambiente.to_s.capitalize + '::' + ws_tipo.to_s.upcase).to_s
      self.reload
    end

    def reload
      Rails.logger.info "**********************************************************"
      Rails.logger.info @url.inspect

      # @savon_client = Savon.client do 
      #   # wsdl ::Superpay.config.url
      #   wsdl @url
      #   convert_request_keys_to :lower_camelcase
      # end
       @savon_client = Savon.client(wsdl: @url, convert_request_keys_to: :lower_camelcase)
    end

    def self.instance
      @__instance__ ||= new
    end

    def call(metodo, transacao)
      # parametros = {
      #   usuario: Configuracao.instance.usuario, 
      #   senha: Configuracao.instance.senha
      # }
      
      key = transacao.keys.first
      transacao[key][:codigo_estabelecimento] = @estabelecimento

      parametros = {
        usuario: @usuario,
        senha: @senha
      }
      @savon_client.call(metodo.to_sym) do
        message parametros.merge(transacao)
      end
    end

  end
end