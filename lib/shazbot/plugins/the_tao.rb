require 'shazbot/the_tao'
require 'cinch'
require 'edn'

class Shazbot::Plugins::TheTao
  include Cinch::Plugin
  attr_reader :tao

  match /tao (.+)/i, method: :consult

  def initialize(*args)
    super
    @tao = Shazbot::TheTao.new
  end

  match /tao (.+)/i
  def execute(m, section = nil)
    m.reply ' '
    tao[section].split("\n").each do |line|
      m.reply "#{line} "
      sleep 2 if line.empty?
    end
    m.reply ' '
  end
end
