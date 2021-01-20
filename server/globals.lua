---- Libraries
Class = require 'libs.middleclass'
Suit = require 'libs.suit'


---- Enums
Combinations = {
	Single = 1,
	Double = 2,
	Triple = 3,
	Quadruple = 4,

	Sequence = 5,
	DoubleSequence = 6
}

CardRank = {
	Three = 1,
	Four = 2,
	Five = 3,
	Six = 4,
	Seven = 5,
	Eight = 6,
	Nine = 7,
	Ten = 8,
	Jack = 9,
	Queen = 10,
	King = 11,
	Ace = 12,
	Two = 13
}

CardSuit = {
	Spades = 1,
	Clubs = 2,
	Diamonds = 3,
	Hearts = 4
}


-- Classes
Card = require 'card'
Player = require 'player'