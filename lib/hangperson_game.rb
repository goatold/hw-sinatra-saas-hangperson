class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_reader :word, :guesses, :wrong_guesses
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(l)
    raise ArgumentError, "invalid input:'#{l}'" if !(l =~ /^[[:alpha:]]$/)
    l.downcase!
    return false if @guesses.include? l or @wrong_guesses.include? l
    if @word.include? l
      @guesses += l
    else
      @wrong_guesses += l
    end
    return true
  end
  
  def word_with_guesses
    return '-' * @word.length if @guesses.empty?
    @word.gsub(Regexp.new("[^#{@guesses}]"),'-')
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif @word.chars.uniq.all? {|c| @guesses.include?c}
      return :win
    else
      return :play
    end
  end

end
