class BlackJack
  attr_accessor :players_hand, :dealers_hand

  def initialize
    @new_deck = Deck_of_cards.shuffle
    @players_hand = []
    @dealers_hand = []
    @player_bust = 0
    @player_ace_chance = 0
  end
  
 
  
  def play
    @players_hand = @new_deck.pop(2)
    @dealers_hand = @new_deck.pop(2)
    puts "Welcome to Las Vegas. Lets play some BlackJack!\n\n"
    puts "You have: #{@players_hand}"
    puts "Your hand value is #{value?(@players_hand)}\n\n"
    if value?(@players_hand) == 21
      return puts "You got BlackJack. You Win!"
    end  
    puts "Dealer is showing: #{@dealers_hand[1]}\n\n"
    if @dealers_hand[1][0] == "A" && value?(@dealers_hand) == 21
      puts "Dealer has #{@dealers_hand}"
      return puts "Dealer got BlackJack. You lose."
    end 
    puts "Do you want to hit?(y/n)"
    @ans = gets.chomp
    
    while true
      if @ans == "y"
        hit(@players_hand)
        puts "You have: #{@players_hand}"
        puts "Your hand value is #{value?(@players_hand)}\n\n"
        # if @players_hand.any? { |card| card.include?("Ace") } && value?(@players_hand) >21 && @player_ace_chance == 0 
        #   @player_ace_chance += 1
          
        if value?(@players_hand) > 21
          @player_bust = 1
          puts "You Bust. You Lose!"
          puts "Dealer was showing: #{@dealers_hand}"
          puts "Dealer's hand value was #{value?(dealers_hand)}"
          break
        end  
        
        puts "Do you want to hit?(y/n)"
        @ans = gets.chomp
      elsif  @ans == "n"
        break
      else
        puts "Invaid Entry. Try again."
        puts "Do you want to hit?(y/n)"
        @ans = gets.chomp
      end
      
      
    end    
    
    if @player_bust == 0
      until value?(dealers_hand) > 16
        hit(dealers_hand)
      end
      
      puts "Dealer shows: #{@dealers_hand}"
      puts "Dealer's hand value is #{value?(dealers_hand)}"
      
      if value?(dealers_hand) > 21
        puts "Dealer Bust. You win!"
      elsif value?(dealers_hand) >= value?(players_hand)
        puts "Dealer got you beat. You lose."
      else
        puts "You got the Dealer beat. You win!"
      end  
    end  
      
    
  end
  
  def hit(hand)
    hand << @new_deck.pop
  end
  
  def value?(cards)
    all_cards = cards.map do |card|
       char = card.chars[0].to_i
         if char > 0
           if card[0..1].to_i == 10
              10 
            else 
           char
         end
         else
            if card.chars[0] == "A"
              11
            else
            10
            end  
          end 
     end  
     all_cards.reduce(:+)
  end  
  
  
  private
  
  one_to_ten_cards = (2..10).to_a.map! { |int| int.to_s }
  
  
  suits = [" of Diamonds", " of Clubs", " of Hearts", " of Spades"]
  num_diamonds = one_to_ten_cards.map { |card| card + suits[0] }
  num_clubs = one_to_ten_cards.map { |card| card + suits[1] }
  num_hearts = one_to_ten_cards.map { |card| card + suits[2] }
  num_spades = one_to_ten_cards.map { |card| card + suits[3] }
  jacks = suits.map { |s| "Jack" + suits[0] }
  queens = suits.map { |s| "Queen" + suits[1] }
  kings = suits.map { |s| "King" + suits[2] }
  aces = suits.map { |s| "Ace" + suits[3] }
  
  Deck_of_cards = num_diamonds + num_clubs + num_hearts + num_spades + jacks + queens + kings + aces
  
end

game = BlackJack.new
game.play