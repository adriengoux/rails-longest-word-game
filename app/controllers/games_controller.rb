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

    english?(answer)
    in_grid?(answer, grid)



    @score = score_calculation(answer, grid)
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

  # def score_calculation(attempt, grid, duration)
  #   return attempt.length * duration
  # end
  def score_calculation(try, grid)
    @my_score = (try.length.fdiv(grid.length)) * 10
    @my_score.to_i
  end
end

# previous game done




# def run_game(attempt, grid, start_time, end_time)
#   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
#   result = {}
#   my_duration = duration(start_time, end_time)
#   if in_grid?(attempt, grid) == false
#     result[:time] = my_duration
#     result[:score] = 0
#     result[:message] ="the given word is not in the grid"
#   elsif english?(attempt) == false
#     result[:time] = my_duration
#     result[:score] = 0
#     result[:message] = "the given word is not an english one"
#   else
#     result[:time] = my_duration
#     result[:score] = score_calculation(attempt, grid, my_duration)
#     result[:message] = "well done"
#     # {
#     #   bad: "poor score" ,
#     #   medium: "not bad",
#     #   good: "good job"
#     # }
#   end
#   result
# end





