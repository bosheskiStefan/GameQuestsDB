CREATE DATABASE Video_Game;
USE Video_Game;

CREATE TABLE Player(
player_id NUMERIC(3) NOT NULL IDENTITY PRIMARY KEY,
player_username VARCHAR(20) NOT NULL,
starting_date DATE,
hours_played NUMERIC(4),
CONSTRAINT not_negative_hours CHECK (hours_played >=0));

CREATE TABLE NPC(
npc_id NUMERIC(3) NOT NULL IDENTITY PRIMARY KEY,
npc_name VARCHAR(20) NOT NULL,
npc_profession VARCHAR(20),
CONSTRAINT profession_options CHECK(npc_profession IN ('Shopkeeper', 'Blacksmith', 'Doctor', 'Chef', 'Farmer', 'Hunter', 'Librarian', 'Musician')),
npc_age NUMERIC(2),
CONSTRAINT not_negative_age CHECK (npc_age >=0),
npc_personality VARCHAR(20),
CONSTRAINT personality_options CHECK(npc_personality IN ('Nice', 'Grumpy', 'Shy', 'Mean', 'Funny')));

CREATE TABLE Reward(
reward_id NUMERIC(3) NOT NULL IDENTITY PRIMARY KEY,
reward_name VARCHAR(20) NOT NULL,
reward_type VARCHAR(20),
CONSTRAINT type_options CHECK(reward_type IN ('Tool', 'Decoration', 'Outfit', 'Artifact', 'Consumable', 'Boost', 'Trophy')),
reward_value VARCHAR(20),
CONSTRAINT value_options CHECK(reward_value IN ('Common', 'Rare', 'Epic', 'Legendary', 'Ultimate')),
reward_rarity NUMERIC(3),
CONSTRAINT rarity_options CHECK(reward_rarity BETWEEN 1 AND 100));

CREATE TABLE Quest(
player_id NUMERIC(3) NOT NULL REFERENCES Player(player_id),
npc_id NUMERIC(3) NOT NULL REFERENCES NPC(npc_id),
reward_id NUMERIC(3) NOT NULL REFERENCES Reward(reward_id),
quest_name VARCHAR(20) NOT NULL,
quest_description TEXT NOT NULL,
quest_duration NUMERIC(2),
CONSTRAINT not_negative_duration CHECK (quest_duration >=0),
quest_difficulty VARCHAR(20),
CONSTRAINT difficulty_options CHECK(quest_difficulty IN ('Easy', 'Medium', 'Hard')),
CONSTRAINT quest_primary_keys PRIMARY KEY (player_id, npc_id, reward_id));

CREATE TABLE Relation(
player_id NUMERIC(3) NOT NULL REFERENCES Player(player_id),
npc_id NUMERIC(3) NOT NULL REFERENCES NPC(npc_id),
likeness VARCHAR(20),
CONSTRAINT likeness_options CHECK(likeness IN ('Hate', 'Dislike', 'Neutral', 'Like', 'Love')),
CONSTRAINT relation_primary_keys PRIMARY KEY (player_id, npc_id));

INSERT INTO Player (player_username, starting_date, hours_played) VALUES
('Stefan', '2024-04-24', 22),
('Viktor', '2023-02-12', 10),
('Anastasija', '2021-07-30', 58),
('Sara', '2024-12-20', 3);

INSERT INTO NPC (npc_name, npc_profession, npc_age, npc_personality) VALUES
('Keli', 'Doctor', '46', 'Shy'),
('Tito', 'Musician', '24', 'Funny'),
('Mei', 'Chef', '24', 'Nice'),
('Nami', 'Shopkeeper', '24', 'Grumpy'),
('Tom', 'Farmer', '57', 'Nice'),
('Sprinkle', 'Hunter', '98', 'Mean'),
('Milton', 'Blacksmith', '50', 'Mean'),
('Eva', 'Librarian', '67', 'Nice'),
('Eva jr.', 'Farmer', '39', 'Shy'),
('Barny', 'Shopkeeper', '32', 'Grumpy'),
('Pepi', 'Doctor', '61', 'Funny'),
('Darko Bieber', 'Musician', '29', 'Mean'),
('Jerry', 'Chef', '42', 'Shy'),
('Leo', 'Shopkeeper', '26', 'Nice'),
('Bela', 'Shopkeeper', '37', 'Funny'),
('Ozzy', 'Farmer', '48', 'Grumpy');

INSERT INTO Reward (reward_name, reward_type, reward_value, reward_rarity) VALUES
('Sword', 'Tool', 'Rare', 30),
('Axe', 'Tool', 'Common', 45),
('Pickaxe', 'Tool', 'Common', 35),
('Guitar', 'Tool', 'Ultimate', 5),
('Box', 'Decoration', 'Legendary', 10),
('Portrait', 'Decoration', 'Rare', 25),
('Statue', 'Decoration', 'Epic', 15),
('Rug', 'Decoration', 'Rare', 35),
('Crown', 'Outfit', 'Ultimate', 2),
('Cape', 'Outfit', 'Legendary', 13),
('Dress', 'Outfit', 'Epic', 18),
('Box', 'Outfit', 'Legendary', 10),
('Crystal Ball', 'Artifact', 'Epic', 22),
('Voodoo Doll', 'Artifact', 'Legendary', 11),
('Meaning of Life', 'Artifact', 'Ultimate', 1),
('Map', 'Artifact', 'Legendary', 12),
('Health Potion', 'Consumable', 'Common', 45),
('Mana Potion', 'Consumable', 'Common', 45),
('Invisibility Potion', 'Consumable', 'Rare', 30),
('Spaghetti', 'Consumable', 'Legendary', 15),
('Damage+', 'Boost', 'Common', 50),
('Defense+', 'Boost', 'Common', 50),
('Speed+', 'Boost', 'Common', 50),
('Charisma+', 'Boost', 'Common', 50),
('Dragon Head', 'Trophy', 'Legendary', 7),
('Witch Hat', 'Trophy', 'Legendary', 7),
('Orc Club', 'Trophy', 'Legendary', 7),
('Computer Chip', 'Trophy', 'Ultimate', 4);

ALTER TABLE Quest
ALTER COLUMN quest_name VARCHAR(35);

INSERT INTO Quest (player_id, npc_id, reward_id, quest_name, quest_description, quest_duration, quest_difficulty) VALUES
(1, 1, 22, 'Wounds make you stronger!', 'Fight the monsters behind the hospital.', 3, 'Medium'),
(1, 2, 4, 'Music to my ears', 'Play the guitar perfectly.', 1, 'Hard'),
(1, 5, 20, 'Spaghetti?', 'Find the lost bell.', 7, 'Medium'),
(1, 6, 1, 'Show me your power!', 'Spar with Sprinkle and win.', 1, 'Hard'),
(1, 9, 2, 'For me?', 'Give Eva jr. the letter.', 10, 'Easy'),
(1, 11, 6, 'Cleaning time!', 'Clean the office.', 3, 'Easy'),
(1, 13, 17, 'I need ingredients', 'Bring back vegetables to Jerry.', 7, 'Easy'),
(1, 16, 7, 'So many worms...', 'Kill all the worms.', 3, 'Medium'),
(2, 1, 16, 'Are you lost?', 'Find the lost map.', 5, 'Hard'),
(2, 3, 11, 'Dress like a princess', 'Give Mei her lost dress.', 1, 'Easy'),
(2, 4, 3, 'Cleaning time!', 'Clean the shop.', 2, 'Medium'),
(2, 8, 18, 'Where is my book?', 'Find the lost book.', 2, 'Easy'),
(2, 12, 24, 'Charmed, I am sure', 'Go to a Darko Bieber concert.', 1, 'Easy'),
(2, 15, 8, 'Under where?', 'Look under the rug.', 7, 'Medium'),
(3, 1, 14, 'Yours now!', 'Adopt the two kittens.', 14, 'Hard'),
(3, 2, 12, 'Box!', 'Give the box to Tito.', 2, 'Easy'),
(3, 3, 5, 'Box?', 'Throw out the box.', 2, 'Easy'),
(3, 4, 26, 'Save me!', 'Save Nami from The Witch.', 5, 'Hard'),
(3, 5, 9, 'How are the cats?', 'Show Tom the kittens.', 1, 'Easy'),
(3, 7, 13, 'The Future?', 'Find a weird crystal.', 12, 'Medium'),
(3, 10, 17, 'Want this?', 'Find someone to buy the junk.', 7, 'Medium'),
(3, 11, 19, 'For my next trick...', 'Make yourself disappear.', 5, 'Hard'),
(3, 12, 24, 'Charmed, I am sure', 'Go to a Darko Bieber concert.', 1, 'Easy'),
(3, 13, 21, 'Food fight!', 'Break out the food fight.', 1, 'Medium'),
(3, 15, 23, 'Fast!!!', 'Win the race.', 1, 'Hard'),
(3, 13, 25, 'Flying lizard egg', 'Get the Dragon egg.', 7, 'Hard'),
(3, 12, 27, 'Shrek?', 'Take a picture of the Orc.', 7, 'Hard'),
(3, 14, 28, 'Game over', 'Go in the shop after finishing the game.', 7, 'Hard'),
(4, 2, 15, 'The true meaning of life', '???', 99, 'Hard');

INSERT INTO Relation (player_id, npc_id, likeness) VALUES
(1, 1, 'Love'),
(1, 2, 'Like'),
(1, 3, 'Like'),
(1, 5, 'Love'),
(1, 6, 'Love'),
(1, 8, 'Neutral'),
(1, 9, 'Like'),
(1, 11, 'Like'),
(1, 12, 'Hate'),
(1, 13, 'Neutral'),
(1, 16, 'Dislike'),
(2, 4, 'Neutral'),
(2, 10, 'Like'),
(2, 15, 'Love'),
(2, 16, 'Hate'),
(3, 1, 'Dislike'),
(3, 2, 'Love'),
(3, 3, 'Love'),
(3, 4, 'Like'),
(3, 5, 'Neutral'),
(3, 7, 'Love'),
(3, 10, 'Neutral'),
(3, 12, 'Hate'),
(3, 14, 'Love'),
(3, 15, 'Neutral'),
(4, 1, 'Hate'),
(4, 2, 'Neutral'),
(4, 4, 'Love');

/*Showing the Players*/
SELECT *
FROM Player;

/*Showing the NPCs*/
SELECT *
FROM NPC;

/*Showing the Rewards*/
SELECT *
FROM Reward;

/*Showing the Quests*/
SELECT *
FROM Quest;

/*Showing the Relations*/
SELECT *
FROM Relation;

/*Order Players by hours played*/
SELECT *
FROM Player
ORDER BY hours_played DESC;

/*Order Players by starting date*/
SELECT *
FROM Player
ORDER BY starting_date ASC;

/*Order NPCs by age*/
SELECT *
FROM NPC
ORDER BY npc_age ASC;

/*Group NPCs by personality*/
SELECT *
FROM NPC
ORDER BY npc_personality, npc_age ASC;

/*Count NPCs by personality*/
SELECT npc_personality, COUNT(*) AS total_personality
FROM NPC
GROUP BY npc_personality
ORDER BY COUNT(*) DESC, npc_personality;

/*Count NPCs by profession*/
SELECT npc_profession, COUNT(*) AS total_profession
FROM NPC
GROUP BY npc_profession
ORDER BY COUNT(*) DESC, npc_profession;

/*Avgrage rarity of Rewards by type*/
SELECT reward_type, AVG(reward_rarity) AS avgrage_rarity
FROM Reward
GROUP BY reward_type 
ORDER BY AVG(reward_rarity) DESC, reward_type;

/*Avgrage rarity of Rewards by value*/
SELECT reward_value, AVG(reward_rarity) AS avgrage_rarity
FROM Reward
GROUP BY reward_value
ORDER BY AVG(reward_rarity) DESC, reward_value;

/*Count Rewards by value*/
SELECT reward_value, COUNT(*) AS total_value
FROM Reward
GROUP BY reward_value
ORDER BY COUNT(*) DESC;

/*Order Rewards by rarity and value*/
SELECT *
FROM Reward
ORDER BY reward_rarity ASC, reward_value DESC;

/*Count Relations by likeness*/
SELECT likeness, COUNT(*) AS total_likeness
FROM Relation
GROUP BY likeness
ORDER BY COUNT(*) DESC;

/*Count Relations by likeness for each Player*/
SELECT p.player_username, l.likeness, COUNT(*) AS total_likeness
FROM Relation l, Player p
WHERE p.player_id=l.player_id
GROUP BY p.player_username, l.likeness
ORDER BY p.player_username, COUNT(*) DESC;

/*Count Relations by likeness for each NPC*/
SELECT n.npc_name, l.likeness, COUNT(*) AS total_likeness
FROM Relation l, NPC n
WHERE n.npc_id=l.npc_id
GROUP BY n.npc_name, l.likeness
ORDER BY n.npc_name, COUNT(*) DESC;

/*Show the Relations between Players and NPCs*/
SELECT p.player_username, l.likeness, n.npc_name
FROM Relation l, NPC n, Player p
WHERE n.npc_id=l.npc_id AND p.player_id=l.player_id
ORDER BY likeness, player_username;

/*Show the Quests done between Players from NPCs and the Rewards they got*/
SELECT p.player_username, n.npc_name, r.reward_name, r.reward_type, r.reward_value
FROM NPC n, Player p, Reward r, Quest q
WHERE n.npc_id=q.npc_id AND p.player_id=q.player_id AND r.reward_id=q.reward_id
ORDER BY p.player_username, r.reward_value;

/*Count Quests done by Players*/
SELECT p.player_username, COUNT(*) AS total_quest
FROM Player p, Quest q
WHERE p.player_id=q.player_id
GROUP BY p.player_username
ORDER BY COUNT(*) DESC;

/*Count Quests given by NPCs*/
SELECT n.npc_name, COUNT(*) AS total_quest
FROM NPC n, Quest q
WHERE n.npc_id=q.npc_id
GROUP BY n.npc_name
ORDER BY COUNT(*) DESC;

/*Order Quests by duration*/
SELECT q.quest_name, q.quest_description, q.quest_duration, q.quest_difficulty, r.reward_name
FROM Quest q, Reward r
WHERE r.reward_id=q.reward_id
ORDER BY q.quest_duration DESC, q.quest_difficulty;

/*Order Quests by difficulty*/
SELECT q.quest_name, q.quest_description, q.quest_duration, q.quest_difficulty, r.reward_name
FROM Quest q, Reward r
WHERE r.reward_id=q.reward_id
ORDER BY q.quest_difficulty DESC, q.quest_duration DESC;