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
  "+1 and a half",
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
  "Wow, you guys, I'm stunned",
]

triggers = [
  "best.*ev(er|ar)",
  "so good",
  "they have the best",
  "awesome",
  "I love",
  "(excellent|fantastic|wonderful|outstanding|magnificent|brilliant|genius|amazing)",
  "(ZOMG|OMG|OMFG)",
  "\\+1",
  "(so|pretty) great",
  "off the hook"
]

special_users = process.env.IKR_SPECIAL_USERS || ["ctn"]
special_triggers = process.env.IKR_SPECIAL_TRIGGERS || ["(special|cool|incredible|incroyable)"]

regex = new RegExp triggers.join('|'), "i"
special_users_regex = new RegExp special_users.join('|'), "i"
special_triggers_regex = new RegExp special_triggers.join('|'), "i"

module.exports = (robot) ->
  robot.hear regex, (msg) ->
    msg.send msg.random replies

  robot.hear special_users_regex, (msg) ->
    msg.send msg.random replies
    if (msg.message.user.name.search special_users_regex) >= 0
      msg.send msg.random replies
