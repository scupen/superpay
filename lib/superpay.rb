# -*- encoding : utf-8 -*-
require "superpay/version"
require 'savon'

module Superpay
  
  autoload :Conector, 'superpay/conector'
  autoload :Configuracao, 'superpay/configuracao'
  autoload :Helper, 'superpay/helper'
  autoload :Transacao, 'superpay/transacao'
  autoload :TransacaoOneClick, 'superpay/transacao_one_click'

  class Producao
    TRANSACAO = 'https://superpay2.superpay.com.br/checkout/servicosPagamentoCompletoWS.Services?wsdl'
    TRANSACAO_ONE_CLICK = 'https://superpay2.superpay.com.br/checkout/servicosPagamentoOneClickWS.Services?wsdl'
  end

  class Teste
    TRANSACAO = 'http://homologacao2.superpay.com.br/superpay/servicosPagamentoCompletoWS.Services?wsdl'
    TRANSACAO_ONE_CLICK = 'http://homologacao2.superpay.com.br/superpay/servicosPagamentoOneClickWS.Services?wsdl'
  end

  #
  # Configura a conexão com o gateway.
  # Utlização:
  #
  # Superpay.config do |config|
  #   config.ambiente         = :teste
  #   config.estabelecimento  = 1111111
  #   config.usuario          = 'ERNET'
  #   config.senha            = 'ERNET'
  # end
  # def self.config
  #   yield(Configuracao.instance) if block_given?
  #   return Configuracao.instance
  # end

  # def self.conector
  #   Conector.instance
  # end

  # @@ambiente = :teste
  # mattr_accessor :ambiente
  
  # @@estabelecimento = 1111111
  # mattr_accessor :estabelecimento
  
  # @@usuario = 'ERNET'
  # mattr_accessor :usuario
  
  # @@senha = 'ERNET'
  # mattr_accessor :senha

  # def self.setup
  #   yield self
  # end

  # class MissingArgumentError < StandardError; end

end
