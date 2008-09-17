require 'rest-open-uri'
require 'uri'
require 'cgi'

class Status < ActiveResource::Base
  
  def self.update(login, password, st)
    representation = self.form_encoded({"status" => portunhol(st)})

    begin
      response = open('http://twitter.com/statuses/update.xml', 
                        :method => :post,
                        :http_basic_authentication => [login, password], 
                        :body=> representation)
                              
    rescue OpenURI::HTTPError => e
      response_code = e.io.status[0].to_i
      if response_code == 401
        return "El Servidor non aceitó su credenciales!"
      elsif response_code == 500
        return "El Servidor está comiendo bananas! Volve outra ora!"
      else
        raise e
        logger.warn("GOT #{response_code}")
      end
    end
    
    "Ok, su tweet foi submetido con suceho!"
    
  end
  
  private
  
  def self.portunhol(frase)
      frase = frase.gsub(/\beu\b/, 'jo')
      frase = frase.gsub(/\bmas\b/, 'pero')
      frase = frase.gsub(/\buma\b/, 'una')
      frase = frase.gsub(/\bum\b/, 'uno')
      frase = frase.gsub(/\b(minha|meu)\b/, 'mi')
      frase = frase.gsub(/\b(s|t)(ua|eu)\b/, '\1u')
      frase = frase.gsub(/\b(tu|você)\b/, 'usted')
      frase = frase.gsub(/\bdo\b/, 'del')
      frase = frase.gsub(/\bem\b/, 'en')
      frase = frase.gsub(/\bbom\b/, 'bueno')
      frase = frase.gsub(/\b(a|o)(s?)\b/, 'l\1\2')
      frase = frase.gsub(/\bé\b/, 'es')
      frase = frase.gsub(/\bcara\b/, 'cabrón')
      frase = frase.gsub(/\bhoje\b/, 'hoy')
      frase = frase.gsub(/\b(\w{2,}?)ção\b/, '\1ción')
      frase = frase.gsub(/\b(\w{2,}?)ção\b/,'\1ción')
      frase = frase.gsub(/\b(\w{2,}?)ções\b/,'\1ciónes')
      frase = frase.gsub(/\b(\w{3,}?)ão\b/,'\1ión')
      frase = frase.gsub(/\b(\w{3,}?)ões\b/,'\1iónes')
      frase = frase.gsub(/\b(\w*)inh(a|o)\b/,'\1it\2')
      frase = frase.gsub(/\b(\w)o(\w{2,3})\b/,'\1ue\2')
      frase = frase.gsub(/\b(\w)e(\w{2,3})\b/,'\1ie\2')
      frase = frase.gsub(/\b(\w{3,}?)dade\b/,'\1dad')
      frase = frase.gsub(/\bfalar\b/,'hablar')
      frase = frase.gsub(/eit/,'ect')
      frase = frase.gsub(/nh/,'ñ')
  end

  def self.form_encoded(hash)
    encoded = []
    hash.each do |key, value|
      encoded << CGI.escape(key) + '=' + CGI.escape(value)
    end
    return encoded.join('&')
  end

end