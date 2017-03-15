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
  "http://www.gifbin.com/bin/1237811519_chuck-norris-approves.gif",
  "https://m.popkey.co/737465/w6yRN.gif",
  "http://24.media.tumblr.com/tumblr_lyvq47DWd81rn95k2o1_500.gif",
  "http://25.media.tumblr.com/tumblr_m09plvItq51rqfhi2o1_400.gif",
  "http://memeguy.com/photos/images/when-i-tell-a-classmate-i-barley-reached-page-minimum-and-he-says-he-had-trouble-keeping-it-under--71761.gif",
  "http://i.imgur.com/H34pBqF.gif"
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

special_users = process.env.HUBOT_IKR_SPECIAL_USERS || "ctn"
special_triggers = process.env.HUBOT_IKR_SPECIAL_TRIGGERS || "(special|cool|incredible|incroyable)"

regex = new RegExp triggers.join('|'), "i"
special_users_regex = new RegExp special_users, "i"
special_triggers_regex = new RegExp special_triggers, "i"

# agreeability setting based on TARS honesty setting from the movie Interstellar,
# expressed as a percentage
agreeability_max = 100
agreeability_min = 10 # because if smaller why bother?
agreeability_step = 10

setAgreeability = (robot, input) ->
  setting = Math.min(input, agreeability_max)
  setting = Math.max(setting, agreeability_min)
  robot.brain.set 'hubot_ikr_agreeability', setting
  return setting


module.exports = (robot) ->
  robot.hear special_triggers_regex, (msg) ->
    if (msg.message.user.name.search special_users_regex) >= 0
      msg.send msg.random replies

  robot.respond /agreeability?/i, (msg) ->
    agreeability_current = robot.brain.get('hubot_ikr_agreeability') || 100
    msg.reply "Current agreeability setting is " + agreeability_current

  robot.respond /set agreeability to (.*)/i, (msg) ->
    robot.logger.error msg.match[1]
    if (Number.isInteger(msg.match[1]))
      agreeability_current = setAgreeability(robot, msg.match[1])
      msg.reply "Current aggreability setting set to " + agreeability_current
    else
      msg.reply "I'm afraid I can't do that."

  robot.hear /be more agreeable/i, (msg) ->
    agreeability_current = robot.brain.get('hubot_ikr_agreeability') || 100
    agreeability_current = setAgreeability robot, agreeability_current + agreeability_step
    msg.reply "Agreeability set to " + agreeability_current

  robot.hear /be less agreeable/i, (msg) ->
    agreeability_current = robot.brain.get('hubot_ikr_agreeability') || 100
    agreeability_current = setAgreeability robot, agreeability_current - agreeability_step
    msg.reply "Agreeability set to " + agreeability_current

  robot.hear regex, (msg) ->
    if (Math.floor(Math.random() * 100) < agreeability_current)
      msg.send msg.random replies

