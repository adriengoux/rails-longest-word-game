require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('a'..'z').to_a
    10.times { @letters << alphabet.sample }
    @start_time = Time.now
    return @letters
  end

  def answer_length
    @answer.length
  end

  def score
    answer = params[:answer]
    grid = params[:grid]

    result_hash = run_game(answer, grid)
    @message = result_hash[:message]
    @score = result_hash[:score]
  end

  def run_game(answer, grid)
    result = {}
    if in_grid?(answer, grid) == false
      result[:win] = false
      result[:score] = 0
      result[:message] = "the given word <strong>#{answer}</strong> is not in the grid #{grid}"
    elsif english?(answer) == false
      result[:win] = false
      result[:score] = 0
      result[:message] = 'the given word is not an english one'
    else
      result[:win] = true
      result[:score] = score_calculation(answer, grid)
      result[:message] = 'well done'
    end
    return result
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    raw_answer = open(url).read
    hash_answer = JSON.parse(raw_answer)
    hash_answer["found"] == true
  end

  def in_grid?(user_input, grid)
    input = user_input.split('')
    uniq_input = input.uniq
    uniq_input.all? do |letter|
      input.count(letter) <= grid.split('').count(letter)
    end
  end

  def score_calculation(try, grid)
    @my_score = (try.length.fdiv(grid.length)) * 10
    @my_score.to_i
  end
end





