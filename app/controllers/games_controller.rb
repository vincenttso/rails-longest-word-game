# frozen_string_literal: true

require 'json'
require 'open-uri'

# GamesController
class GamesController < ApplicationController
  def new
    if session[:score].nil?
      session[:score] = 0
    else
      session[:score]
    end
    @letters = []
    10.times do
      @letters.push(('A'..'Z').to_a.sample)
    end
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @result = if check_valid(@word) == false
                "Sorry, but #{@word} cannot be built out of #{@letters.join(', ')}"
              else
                url = "https://wagon-dictionary.herokuapp.com/#{@word.downcase}"
                parsed = parsed_json(url)
                returned_result(parsed['found'], @word)
              end
  end

  def parsed_json(url)
    JSON.parse(URI.open(url).read)
  end

  def returned_result(check_attribute, word)
    if check_attribute
      session[:score] += 2**word.length
      "Congratulations! #{word} is a valid English word!"
    else
      "Sorry, but #{@word} does not seem to be a valid English word"
    end
  end

  private

  def check_valid(word)
    word.split(//).each do |letter|
      next if @letters.include?(letter)

      return false
    end
  end
end
