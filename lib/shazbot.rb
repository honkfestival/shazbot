require 'shazbot/version'
require 'shazbot/plugins'
require 'shazbot/the_tao'

module Shazbot
  extend self

  CONFIG_DIR = File.expand_path('../../config', __FILE__)
  DATA_DIR   = File.expand_path('../../data',   __FILE__)

  def plugins
    @plugins ||= Shazbot::Plugins.constants.map{|c| Shazbot::Plugins.const_get("Shazbot::Plugins::#{c}")}
  end

  def config(filename = 'shazbot.edn')
    @config ||= {
      :nick => 'ShazBot',
      :server => 'irc.freenode.org',
      :channels => ['#cinch-bots'],
      :modes => ['B', 'i']
    }.merge load_edn(File.join(CONFIG_DIR, filename))
  end

  def load_edn(filename)
    File.exist?(filename) ? EDN.read(File.read(filename)) : {}
  end
end
