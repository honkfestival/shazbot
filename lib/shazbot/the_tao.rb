class Shazbot::TheTao
  def initialize
    text = EDN.read(File.read(File.join(Shazbot::DATA_DIR, 'tao.edn')))
    @tao = Hash.new('The Tao is silent.').merge text
  end

  def [](entry)
    chosen_entry = key(entry.to_s).to_sym
    @tao[chosen_entry]
  end

  def key(entry)
    match = /\D*(?<book>\d)\D*(?<chapter>\d)?/.match entry
    case
      when entry.empty? then choose_random
      when match.nil? then entry
      when match[:chapter] then "book#{match[:book]}chapter#{match[:chapter]}"
      else "book#{match[:book]}"
    end
  end

  def choose_random
    keys = @tao.keys - [:title, :credits, :toc]
    keys.sample
  end
end
