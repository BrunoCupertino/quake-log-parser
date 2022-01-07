load 'game.rb'

INIT_GAME_PATTERN = "InitGame:"
KILL_PATTERN = "Kill:"

if ARGV.size === 0
    puts "path file argument is missing, try this command:"
    puts "ruby log_parser.rb log/qgames.log"
    exit
end

file_name = ARGV[0]

if !File.file?(file_name)
    puts "file:#{file_name} not found!"
    exit
end

@games = []

private

def process(line)
    if line.include? INIT_GAME_PATTERN
        @games.append(Game.new)
        return
    end

    if line.include? KILL_PATTERN
        game = @games.last

        killer = get_killer(line)
        murdered = get_murdered(line)
        cause_of_death = get_cause_of_death(line)

        game.kill(killer, murdered, cause_of_death)
    end
end

def printReport
    @games.each do |game|
        puts "game:#{game.id}, total_kills:#{game.total_kills}, players:#{game.players}, kills:#{game.kills}, kills_by_means:#{game.kills_by_means}"
    end
end

def get_killer(line)    
    line.match(/([^:]+).(?=\skilled)/)[0].strip
end

def get_murdered(line)
    line.match(/((?<=killed\s).*(?=\sby))/)[0]
end

def get_cause_of_death(line)
    line.match(/((?<=by\s).*)/)[0]
end

file_contents = File.foreach(file_name) { |line| process(line) }

printReport