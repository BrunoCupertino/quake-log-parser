# quake-log-parser
Parse a Quake game log and extract info from it

# run
Extract report by running these commands:
```
 ruby log_parser.rb log/qgames.log
```
or 
```
 ruby log_parser.rb log/qgames.log -beauty
```
for a beauty version that includes:
- not show negative kill values
- all players are shown in ranking include players with no score

# test
The tests can be running using this command:
```
ruby game_test.rb
```