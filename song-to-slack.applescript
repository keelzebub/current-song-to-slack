# config variables - Properties are stored in the OS and are configurable
property firstRun : 0
property channelName : ""
property webhookURL : ""
property emojiName : "musical_note"
property emojiList : {"beers", "cd", "loudspeaker", "microphone", "musical_keyboard", "musical_note", "musical_score", "radio", "saxophone", "speaker"}
property chosenEmoji : ""
property userName : ""
property theName : ""
property selectedAnswer : ""

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars

# Is this the first run of the application?
if firstRun is equal to 0 then
	set channelName to the text returned of (display dialog "What is the channel name?" default answer "#your_channel")
	set webhookURL to the text returned of (display dialog "What is the webhook URL?" default answer "https://hooks.slack.com/services/XXX/XXX/XXXX")
	set chosenEmoji to (choose from list emojiList with title "Emoji Selector" with prompt "Choose the emoji you prefer:")
	set userName to the text returned of (display dialog "What is your Slack user name?" default answer "username")
	set firstRun to 1
	# Does the user want to adjust the settings?
else
	set changeSettingsQuestion to display dialog "Need to adjust settings?" buttons {"Yes", "No"} default button 2
	set selectedAnswer to button returned of changeSettingsQuestion
end if


if selectedAnswer is equal to "Yes" then
	set channelName to the text returned of (display dialog "What is the channel name?" default answer "#your_channel")
	set webhookURL to the text returned of (display dialog "What is the webhook URL?" default answer "https://hooks.slack.com/services/XXX/XXX/XXXX")
	set chosenEmoji to (choose from list emojiList with title "Emoji Selector" with prompt "Choose the emoji you prefer:")
	set userName to the text returned of (display dialog "What is your Slack user name?" default answer "username")
end if

# Ensure the service will work
if userName is equal to "" and webhookURL is equal to "" then
	quit me
end if

# Check every 5 seconds if the song is different, if so update the Slack channel
on idle
	
	using terms from application "iTunes"
		tell application "iTunes" #(chosenApp as string)
			if player state is playing then
				set currentTrack to my replace_chars(current track's name, "\"", "\\\"")
				if (theName is equal to currentTrack) then
					return 5
				else
					set theArtist to my replace_chars(current track's artist, "\"", "\\\"")
					set theName to currentTrack
					set trackString to theName & " - " & theArtist
					do shell script "curl -X POST --data-urlencode 'payload={\"channel\": \"" & channelName & "\", \"username\": \"" & userName & "\", \"text\": \"" & my replace_chars(trackString, "'", "\\u0027") & "\", \"icon_emoji\": \":" & chosenEmoji & ":\"}' " & webhookURL
				end if
			end if
		end tell
	end using terms from
	
	return 5
end idle
