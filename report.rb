def printReport(report, format)
    report.each do |game|
        if format == "-beauty"
            printBeauty game
        else
            printRaw game
        end
    end
end

def printBeauty(game)
    puts "=== game_#{game.id} ==="
    puts "total_kills:#{game.total_kills}"
    puts "players:#{game.players.to_a.join(", ")}"
    print "kills:"
    game.players.each_with_index do |player, i| 
        print "#{player}:"
        score = game.kills[player] || 0
        print "#{score > 0 ? score : '0'}"
        print "#{i == game.players.size - 1 ? '' : ", "}"
    end
    puts ""
    print "kills_by_means:"
    game.kills_by_means.each_with_index do |(key, value), i| 
        print "#{key}:#{value}"
        print "#{i == game.kills_by_means.size - 1 ? '' : ", "}"
    end     
    puts ""
    
    puts "=============="
end

def printRaw(game)
    puts "game:#{game.id}, total_kills:#{game.total_kills}, players:#{game.players}, kills:#{game.kills}, kills_by_means:#{game.kills_by_means}"
end