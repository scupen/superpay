# -*- encoding : utf-8 -*-

module Superpay
  class TransacaoOneClick < Transacao

    #
    # Faz o cadastro do cliente / cartão para pagamento one click.
    def self.cadastrar(dados)

      # Valida os dados passados
      raise 'Campo obrigatório: forma_pagamento' if dados[:forma_pagamento].blank?
      raise 'Campo obrigatório: nome_titular_cartao_credito' if dados[:nome_titular_cartao_credito].blank?
      raise 'Campo obrigatório: numero_cartao_credito' if dados[:numero_cartao_credito].blank?
      raise 'Campo obrigatório: codigo_seguranca' if dados[:codigo_seguranca].blank?
      raise 'Campo obrigatório: data_validade_cartao' if dados[:data_validade_cartao].blank?
      raise 'Campo obrigatório: email_comprador' if dados[:email_comprador].blank?

      # Sobrecarga com dados default
      dados[:codigo_estabelecimento] = ::Superpay.config.estabelecimento

      # Verifica se a resposta veio correta ou se deu problema
      begin
        retorno = Superpay.conector.call(:cadastra_pagamento_one_click, {dados_one_click: dados})
        resposta = retorno.to_array(:cadastra_pagamento_one_click_response, :return).first
      rescue Savon::SOAPFault => error
        return {error: error.to_hash[:fault][:faultstring]}
      end
      
      return resposta
    end

    #
    # Faz o pagamento da transação one click, a partir dos dados do gateway.
    # Se a transação já foi feita, seu status de retorno será 31: ja_efetuada. 
    # Caso deseje saber qual o real status da transação, faça uma consulta.
    def self.pagar(dados)

      # Valida os dados passados
      raise 'Campo obrigatório: token' if dados[:token].blank?
      raise 'Campo obrigatório: numero_transacao' if dados[:numero_transacao].blank?
      raise 'Campo obrigatório: codigo_forma_pagamento' if dados[:codigo_forma_pagamento].blank?
      raise 'Campo obrigatório: valor' if dados[:valor].blank?
      raise 'Campo obrigatório: nome_titular_cartao_credito' if dados[:nome_titular_cartao_credito].blank?
      raise 'Campo obrigatório: numero_cartao_credito' if dados[:numero_cartao_credito].blank?
      raise 'Campo obrigatório: codigo_seguranca' if dados[:codigo_seguranca].blank?
      raise 'Campo obrigatório: data_validade_cartao' if dados[:data_validade_cartao].blank?
      raise 'Campo obrigatório: dados_usuario_transacao' if dados[:dados_usuario_transacao].blank?
      raise 'Campo obrigatório: itens_do_pedido' if dados[:itens_do_pedido].blank?

      # Sobrecarga com dados default
      dados[:codigo_estabelecimento] = ::Superpay.config.estabelecimento

      # Tratamento dos valores de envio
      dados = TransacaoOneClick.tratar_envio(dados)

      # Verifica se a resposta veio correta ou se deu problema
      begin
        retorno = Superpay.conector.call(:pagamento_one_click, {transacao: dados})
        resposta = retorno.to_array(:pagamento_one_click_response, :return).first
      rescue Savon::SOAPFault => error
        # return {error: error.to_hash[:fault][:faultstring]}
      end
      
      # Se o estabelecimento retornado for diferente da configuração, deu coisa errada
      # if resposta[:codigo_estabelecimento] != ::Superpay.config.estabelecimento.to_s
      #   raise "Código do estabelecimento não é o da configuração: #{resposta[:codigo_estabelecimento]}"
      # end

      # Sobrecarga com dados tratados e retorna
      # return TransacaoOneClick.tratar_retorno(resposta)
      return resposta
    end

  end
end
