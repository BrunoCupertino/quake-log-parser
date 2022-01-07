require 'set'

class Game
    WORLD_PLAYER = "<world>"

    @@last_id = 0

    attr_reader :id, :total_kills, :players, :kills, :kills_by_means

    def initialize
        @id = get_last_id()
        @total_kills = 0
        @players = Set[]
        @kills = Hash[]
        @kills_by_means = Hash[]
    end

    def update_stats(player_killer, player_murdered, cause_of_death)        
        playerToUpdate = player_murdered
        valueToAdd = -1

        if !is_world_player?(player_killer)
            playerToUpdate = player_killer
            valueToAdd = 1              

            @players.add(player_killer)
            @players.add(player_murdered)
        end        
            
        update_player_kills(playerToUpdate, valueToAdd) if player_killer != player_murdered
        update_kills_by_means(cause_of_death)

        @total_kills += 1
    end

    private

    def is_world_player?(player)
        player == WORLD_PLAYER
    end

    def update_player_kills(player, value_to_add)
        deaths = @kills[player] || 0
        @kills[player] = deaths += value_to_add    
    end   
    
    def update_kills_by_means(cause_of_death)
        deaths = @kills_by_means[cause_of_death] || 0
        @kills_by_means[cause_of_death] = deaths += 1    
    end

    def get_last_id
        @@last_id += 1
        @@last_id
    end
end