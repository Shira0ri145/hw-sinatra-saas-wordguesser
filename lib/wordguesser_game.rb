class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word  #@ is gloval var
    @guesses = ""
    @wrong_guesses = ""
    @show ="" #display - - - - -
    @incorrect_guesses = 0

    word.length.times do
      @show += "-"
    end
  end

  def word()
    @word
  end

  def guesses()
    @guesses
  end

  def wrong_guesses()
    @wrong_guesses
  end

  def word_with_guesses()
    @show
  end

  def check_win_or_lose()
    return :lose if @incorrect_guesses >= 7
    return :win if @word == @show
    return :play
  end

  def guess(letter)    
    raise ArgumentError.new("Err0r") if letter == nil || letter.empty? || !(letter.match?(/\A[a-zA-Z]+\z/))
    # raise ArgumentError.new("empty error") if letter.empty?
    # raise ArgumentError.new("not letter") if !(letter.match?(/\A[a-zA-Z]+\z/))
    letter.downcase!

    if @word.include?(letter)
      return false if @guesses.include?(letter)
      i = 0
      word.length.times do
        if word[i] == letter
          @show[i] = letter
        end
        i+=1
      end
      @guesses = letter
    
    else
      return false if @wrong_guesses.include?(letter)
      @wrong_guesses = letter
    end
    @incorrect_guesses += 1
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
