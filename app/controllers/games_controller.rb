require 'open-uri'
require 'json'
# require 'pry'

class GamesController < ApplicationController
  def searchWord(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dictionary_serialized = open(url).read
    dictionary_api = JSON.parse(dictionary_serialized)
    @found_the_word = dictionary_api["found"] #will return true or false
    # binding.pry
    # parsed_word = dictionary_api["word"] #will return the word
    # parsed_length = dictionary_api["length"] #will return the length
  end

  def new
    @letters = ('a'..'z').to_a.sample(10)
    # .sample(10)
  end

  def score
    @user_word = params[:user_word]
    @user_word_split = params[:user_word].split("")
    @new_array = params[:letters_array].split("")
    searchWord = searchWord(@user_word)


    if @found_the_word == true
      if @user_word_split.all? {|letter| @user_word_split.count(letter) <= @new_array.count(letter)}
        return @word_score = "Congratulations, #{@user_word} is a valid english word"
      else
        return @word_score = "Sorry but #{@user_word} can't be built out of #{@new_array}."
      end
    else
      return @word_score = "Sorry but #{@user_word} does not seem to be a valid english word"
    end
  end
end
