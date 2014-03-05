require 'test_helper'

class TheTaoTest < MiniTest::Unit::TestCase
  def setup
    @tao = Shazbot::TheTao.new
  end

  def test_silence
    assert_equal "The Tao is silent.", @tao[nil]
  end

  def test_with_letters_period_and_space
    expected = <<-TAO
                                 1.2

The Tao gave birth to machine language.  Machine language gave birth to
the assembler.

The assembler gave birth to the compiler.  Now there are ten thousand
languages.

Each language has its purpose, however humble.  Each language expresses
the Yin and Yang of software.  Each language has its place within the
Tao.

But do not program in COBOL if you can avoid it.
TAO
    assert_equal @tao['chapter 1.2'], expected.chomp
  end

  def test_with_period_only
    expected = <<-TAO
                                2.2

Grand Master Turing once dreamed that he was a machine.  When he awoke
he exclaimed:

     "I don't know whether I am Turing dreaming that I am a machine,
     or a machine dreaming that I am Turing!"
TAO
    assert_equal @tao['chapter2.2'], expected.chomp
  end

  def test_numbers_with_period
    expected = <<-TAO
                                5.4

Does a good farmer neglect a crop he has planted?
Does a good teacher overlook even the most humble student?
Does a good father allow a single child to starve?
Does a good programmer refuse to maintain his code?
TAO
    assert_equal @tao['5.4'], expected.chomp
  end

  def test_no_period_or_space
    expected = <<-TAO
                                7.1

A novice asked the master:  "In the east there is a great
tree-structure that men call 'Corporate Headquarters'.  It is bloated
out of shape with vice presidents and accountants.  It issues a
multitude of memos, each saying 'Go, Hence!' or 'Go, Hither!' and
nobody knows what is meant.  Every year new names are put onto the
branches, but all to no avail.  How can such an unnatural entity be?"

The master replied:  "You perceive this immense structure and are
disturbed that it has no rational purpose.  Can you not take
amusement from its endless gyrations?   Do you not enjoy the
untroubled ease of programming beneath its sheltering branches?
Why are you bothered by its uselessness?"
TAO
    assert_equal @tao['71'], expected.chomp
  end

  def test_random_section
    random = @tao['random']
    refute_equal random, @tao[nil]
    refute_equal random, @tao['title']
    refute_equal random, @tao['credits']
    refute_equal random, @tao['toc']
    refute random.empty?
  end

  def test_search
    branches = <<-TAO
                                7.1

A novice asked the master:  "In the east there is a great
tree-structure that men call 'Corporate Headquarters'.  It is bloated
out of shape with vice presidents and accountants.  It issues a
multitude of memos, each saying 'Go, Hence!' or 'Go, Hither!' and
nobody knows what is meant.  Every year new names are put onto the
branches, but all to no avail.  How can such an unnatural entity be?"

The master replied:  "You perceive this immense structure and are
disturbed that it has no rational purpose.  Can you not take
amusement from its endless gyrations?   Do you not enjoy the
untroubled ease of programming beneath its sheltering branches?
Why are you bothered by its uselessness?"
TAO

    assert_equal @tao['googly moogly'], 'The Tao is silent.'
    assert_equal @tao['branches'], branches.chomp
    assert_equal @tao['book'], 'Book 1, Book 2, Book 3, Book 4, Book 5, Book 6, Book 7, Book 8, Book 9'
  end
end
