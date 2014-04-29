# Current Song to Slack

When this script is compiled as an application, it will send the song/artist currently playing
in Spotify, Rdio, or iTunes to the specified Slack channel. Incoming WebHooks for Slack
must be enabled.

## TODO

* Check if application exists on user's computer
* If other applications open, won't post to Slack
* Test if media is streaming over airplay
* Make emoji a config variable
* Check if slack is running before doing anything