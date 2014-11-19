# Description:
#   IKR helps your bot agree with the things you love
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   enthusiastic adverbs trigger random agreements
#
# Notes
#   See jargon array for list of trigger phrases
#
# Author:
#   Dave Josephsen <dave@skeptech.org> (https://github.com/djosephsen)


replies = [
  "*I know right?!*",
  "*OMG* couldn't agree more",
  ":+1:",
  "+1",
  ":arrow_up: THAT",
  ":arrow_up: you complete me :arrow_up:",
  "so true",
  "agreed.",
  "that's the fact jack",
  "YUUUUUUP",
  "that's what I'm talkin bout",
  "*IKR?!*",
  "singit",
  "^droppin the truth bombs :boom: :boom: :boom:",
  "#legit",
  "/me nodds emphatically in agreement",
  "for REALZ though",
  "FOR REALSIES",
  "it's like you *literally* just read my mind right now",
]

triggers = [
  "best.*ev(er|ar)",
  "so good",
  "they have the best",
  "awesome",
  "I love",
  "(fantastic|wonderful|outstanding|magnificent|brilliant|genius|amazing)",
  "(ZOMG|OMG|OMFG)",
  "(so|pretty) great",
  "off the hook"
]

regex = new RegExp triggers.join('|')

module.exports = (robot) ->
  robot.hear regex, (msg) ->
    msg.send msg.random replies
