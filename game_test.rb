require "test/unit"
require_relative './game'

class GameTest < Test::Unit::TestCase
  def test_same_killer_and_mudered_should_update_kills
    p1 = "jota"
    game = Game.new
    game.update_stats(p1, p1, "MOD_SHOTGUN")
    
    assert_equal 0, game.kills[p1] || 0
    assert_equal 1, game.total_kills
  end

  def test_world_killer_should_not_be_in_players
    p1 = "<world>"
    p2 = "jota"

    game = Game.new
    game.update_stats(p1, p2, "MOD_SHOTGUN")
    
    assert_equal false, (game.players.include? p1)
    assert_equal 1, game.total_kills
  end

  def test_world_killer_should_decrement_murdered_player_score
    p1 = "<world>"
    p2 = "jota"

    game = Game.new
    game.update_stats(p1, p2, "MOD_SHOTGUN")
    
    assert_equal -1, game.kills[p2]
    assert_equal 1, game.total_kills
  end

  def test_kills_should_increment_killer_player_score
    p1 = "joje"
    p2 = "jota"

    game = Game.new
    game.update_stats(p1, p2, "MOD_SHOTGUN")
    
    assert_equal 1, game.kills[p1]
    assert_equal 0, game.kills[p2] || 0
    assert_equal 1, game.total_kills
  end

  def test_total_kills_should_always_increment
    p1 = "joje"
    p2 = "jota"

    game = Game.new

    game.update_stats(p1, p2, "MOD_SHOTGUN")
    game.update_stats(p2, p1, "MOD_SHOTGUN")
    
    assert_equal 1, game.kills[p1]
    assert_equal 1, game.kills[p2]
    assert_equal 2, game.total_kills
  end

  def test_kills_by_means_should_be_agrouped
    p1 = "joje"
    p2 = "jota"
    c1 = "MOD_SHOTGUN"
    c2 = "MOD_GAUNTLET"

    game = Game.new

    game.update_stats(p1, p2, c1)
    game.update_stats(p2, p1, c1)
    game.update_stats(p2, p1, c2)
    
    assert_equal 2, game.kills_by_means[c1]
    assert_equal 1, game.kills_by_means[c2]
    assert_equal 3, game.total_kills
  end
end