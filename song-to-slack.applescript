property channelName : "#[Slack Channel Name]"
property webhookURL : "[Incoming WebHook URL]"


property userName : short user name of (system info)
property theName : ""

on escape_quotes(string_to_escape)
  set AppleScript's text item delimiters to the "\""
  set the item_list to every text item of string_to_escape
  set AppleScript's text item delimiters to the "\\\""
  set string_to_escape to the item_list as string
  set AppleScript's text item delimiters to ""
  return string_to_escape
end escape_quotes

on idle

  if application "Spotify" is running then
    tell application "Spotify"
      if player state is playing then
        set currentTrack to current track's name
        if (theName is equal to currentTrack) then
          return 5
        else
          set theTrack to current track
          set theArtist to artist of theTrack
          set theName to name of theTrack
          set trackString to theName & " - " & theArtist
          do shell script "curl -X POST --data-urlencode \"payload={\\\"channel\\\": \\\"" & channelName & "\\\", \\\"username\\\": \\\"" & userName & "\\\", \\\"text\\\": \\\"" & my escape_quotes(trackString) & "\\\", \\\"icon_emoji\\\": \\\":dragon_face:\\\"}\"" & webhookURL
          return 5
        end if
      end if
    end tell

  else if application "iTunes" is running then

    tell application "iTunes"
      if player state is playing then
        set currentTrack to current track's name
        if (theName is equal to currentTrack) then
          return 5
        else
          set theTrack to current track
          set theArtist to artist of theTrack
          set theName to name of theTrack
          set trackString to theName & " - " & theArtist
          do shell script "curl -X POST --data-urlencode \"payload={\\\"channel\\\": \\\"" & channelName & "\\\", \\\"username\\\": \\\"" & userName & "\\\", \\\"text\\\": \\\"" & my escape_quotes(trackString) & "\\\", \\\"icon_emoji\\\": \\\":dragon_face:\\\"}\"" & webhookURL
          return 5
        end if
      end if
    end tell

  else if application "Rdio" is running then

    tell application "Rdio"
      if player state is playing then
        set currentTrack to current track's name
        if (theName is equal to currentTrack) then
          return 5
        else
          set theTrack to current track
          set theArtist to artist of theTrack
          set theName to name of theTrack
          set trackString to theName & " - " & theArtist
          do shell script "curl -X POST --data-urlencode \"payload={\\\"channel\\\": \\\"" & channelName & "\\\", \\\"username\\\": \\\"" & userName & "\\\", \\\"text\\\": \\\"" & my escape_quotes(trackString) & "\\\", \\\"icon_emoji\\\": \\\":dragon_face:\\\"}\"" & webhookURL
          return 5
        end if
      end if
    end tell
  end if

  return 5
end idle