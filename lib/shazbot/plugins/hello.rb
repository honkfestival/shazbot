require 'cinch'

class Shazbot::Plugins::Hello
  include Cinch::Plugin

  match 'hello'

  def execute(m)
    m.reply "hello #{m.user.nick}"
  end
end
