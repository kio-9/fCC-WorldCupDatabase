#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Reset tables
DROP_RESULTS=$($PSQL "TRUNCATE TABLE games, teams")

# Read games
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR -ne year ]]
then
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
if [[ -z $WINNER_ID ]]
then
INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
WINNER_ID=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")
fi
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")
if [[ -z $OPPONENT_ID ]]
then
INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")
fi
INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
fi
done
