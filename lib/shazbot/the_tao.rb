class Shazbot::TheTao
  def initialize
    @tao = EDN.read(File.read(File.join(Shazbot::DATA_DIR, 'tao.edn')))
  end

  def [](query)
    query_key = text_to_key(query.to_s)
    case
      when content_keys.include?(query_key) then @tao[query_key]
      when query_key == :random then @tao[choose_random]
      else perform_search(query)
    end
  end

  def perform_search(query)
    result = search(query)
    case
      when result.empty? then 'The Tao is silent.'
      when result.count == 1 then @tao[result.first]
      else result.map{|key| key_to_text(key)}
    end
  end

  def search(query)
    return [] if query.nil? or query.empty?
    terms = words_from query
    [].tap do |matches|
      content_keys.each do |key|
        terms.each do |term|
          matches << key if words_from(@tao[key]).include?(term)
        end
      end
    end
  end

  def text_to_key(entry)
    match = /\D*(?<book>\d)\D*(?<chapter>\d)?/.match entry
    case
      when entry == 'random' then :random
      when match.nil? then entry
      when match[:chapter] then "book#{match[:book]}chapter#{match[:chapter]}".to_sym
      else "book#{match[:book]}".to_sym
    end
  end

  def key_to_text(entry)
    match = /:book(?<book>\d)(?::chapter(?<chapter>\d))?/.match entry
    return "Book #{match['book']}" unless match['chapter']
    "#{match['book']}.#{match['chapter']}"
  end

  def choose_random
    content_keys.sample
  end

  def content_keys
    @tao.keys - [:title, :credits, :toc]
  end

  def compact_whitespace(string)
    string.gsub(/\s+/, ' ')
  end

  def drop_symbols(string)
    string.gsub(/[^a-z ]/, '')
  end

  def words_from(string)
    drop_symbols(compact_whitespace(string.downcase)).split.uniq
  end
end
