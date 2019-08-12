require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(8)
  end

  def score
    @letters = params[:letters].split("")
    @word = params[:word]
    url = 'https://wagon-dictionary.herokuapp.com/'
    word_serialized = open("#{url}#{@word}").read
    word = JSON.parse(word_serialized)
    verif = @word.upcase.split("").map { |letter| @letters.include?(letter) ? @letters.delete_at(@letters.index(letter)) : "false" }
    # Ici je verifie si
    if verif.include? "false"
      @answer = "Not in the grid"
    # et que chaque lettre de word est inclus une seule dans grid
    elsif word["found"] == false
      @answer = "Not an english word"
    # que le mot choisi est bien dans le dictionnaire
    else
      @answer = "Well done"
    end
      return @answer
  end
end
