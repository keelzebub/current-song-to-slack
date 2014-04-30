# config variables
property channelName : "#[Slack Channel Name]"
property webhookURL : "[Incoming WebHook URL]"
property emojiName : "dragon_face"

# globals
property userName : short user name of (system info)
property theName : ""

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars

# content
#on idle

tell application "Finder" to set spotifyInstalled to exists application file ((path to applications folder as string) & "Spotify")


if spotifyInstalled and application "Spotify" is running then
	tell application "Spotify"
		if player state is playing then
			set currentTrack to my replace_chars(current track's name, "\"", "\\\"")
			if (theName is equal to currentTrack) then
				return 5
			else
				set theArtist to my replace_chars(current track's artist, "\"", "\\\"")
				set theName to currentTrack
				set trackString to theName & " - " & theArtist
				log "curl -X POST --data-urlencode 'payload={\"channel\": \"" & channelName & "\", \"username\": \"" & userName & "\", \"text\": \"" & my replace_chars(trackString, "'", "\\u0027") & "\", \"icon_emoji\": \":" & emojiName & ":\"}' " & webhookURL
			end if
		end if
	end tell
end if

tell application "Finder" to set iTunesInstalled to exists application file ((path to applications folder as string) & "iTunes")

if iTunesInstalled and application "iTunes" is running then
	
	tell application "iTunes"
		if player state is playing then
			set currentTrack to my replace_chars(current track's name, "\"", "\\\"")
			if (theName is equal to currentTrack) then
				return 5
			else
				set theArtist to my replace_chars(current track's artist, "\"", "\\\"")
				set theName to currentTrack
				set trackString to theName & " - " & theArtist
				log "curl -X POST --data-urlencode 'payload={\"channel\": \"" & channelName & "\", \"username\": \"" & userName & "\", \"text\": \"" & my replace_chars(trackString, "'", "\\u0027") & "\", \"icon_emoji\": \":" & emojiName & ":\"}' " & webhookURL
			end if
		end if
	end tell
end if

tell application "Finder" to set rdioInstalled to exists application file ((path to applications folder as string) & "Rdio")

if rdioInstalled and application "Rdio" is running then
	
	tell application "Rdio"
		if player state is playing then
			set currentTrack to my replace_chars(current track's name, "\"", "\\\"")
			if (theName is equal to currentTrack) then
				return 5
			else
				set theArtist to my replace_chars(current track's artist, "\"", "\\\"")
				set theName to currentTrack
				set trackString to theName & " - " & theArtist
				log "curl -X POST --data-urlencode 'payload={\"channel\": \"" & channelName & "\", \"username\": \"" & userName & "\", \"text\": \"" & my replace_chars(trackString, "'", "\\u0027") & "\", \"icon_emoji\": \":" & emojiName & ":\"}' " & webhookURL
			end if
		end if
	end tell
end if

#	return 5
#end idle