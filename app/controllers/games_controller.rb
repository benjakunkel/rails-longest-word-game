require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end
  
  def score
    @contador = 0
    @palabra = params[:palabra].upcase
    @letters = params[:letters]
    respuesta = open "https://wagon-dictionary.herokuapp.com/#{@palabra}"
    json = JSON.parse(respuesta.read)
      if  json['found'] == true
        if include?(@palabra,@letters)
          asd = @palabra.size
          @contador += asd*10
          @valida = "Word exist"
        else
          @valida = "Exist"
        end
      elsif  json['found'] == false
        @valida = "Not exist"
      else
        @valida = "no entre a ninguna condicion"
      end


  end

  def include?(palabra,letters)
    palabra.chars.all? { |letter| palabra.count(letter) <= letters.count(letter)  }
  end
end
