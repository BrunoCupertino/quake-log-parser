load 'game.rb'
load 'report.rb'

INIT_GAME_PATTERN = "InitGame:"
KILL_PATTERN = "Kill:"

if ARGV.size === 0
    puts "path file argument is missing, try this command:"
    puts "ruby log_parser.rb log/qgames.log"
    exit
end

file_name = ARGV[0]
output_format = ARGV[1] || "-raw"

if !File.file?(file_name)
    puts "file:#{file_name} not found!"
    exit
end

@games = []

private

def process(line)
    if line.include?(INIT_GAME_PATTERN)
        @games << Game.new
        return
    end

    if line.include?(KILL_PATTERN)
        game = @games.last

        player_killer = extract_killer(line)
        player_murdered = extract_murdered(line)
        cause_of_death = extract_cause_of_death(line)

        game.update_stats(player_killer, player_murdered, cause_of_death)
    end
end

def extract_killer(line)    
    line.match(/([^:]+).(?=\skilled)/)[0].strip
end

def extract_murdered(line)
    line.match(/((?<=killed\s).*(?=\sby))/)[0].strip
end

def extract_cause_of_death(line)
    line.match(/((?<=by\s).*)/)[0].strip
end

file_contents = File.foreach(file_name) { |line| process(line) }

printReport(@games, output_format)