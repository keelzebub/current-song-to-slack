# config variables
property channelName : "#[Slack Channel Name]"
property webhookURL : "[Incoming WebHook URL]"
property emojiName : "dragon_face"
property possibleAppList : {"Spotify", "iTunes", "Rdio"}
property installedAppList : {}
property chosenApp : ""

set installedAppList to {}

# globals
property userName : do shell script "whoami"
property theName : ""

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars


repeat with n from 1 to count of possibleAppList
	tell application "Finder" to set appInstalled to exists application file ((path to applications folder as string) & item n of possibleAppList)
	if appInstalled then
		set installedAppList to installedAppList & item n of possibleAppList
	end if
end repeat

set chosenApp to (choose from list installedAppList with title "Application Selection" with prompt "Choose an application:")

if chosenApp is false then
	quit me
end if

# content
on idle

	if application (chosenApp as string) is running then

		using terms from application "iTunes"
			tell application (chosenApp as string)
				if player state is playing then
					set currentTrack to my replace_chars(current track's name, "\"", "\\\"")
					if (theName is equal to currentTrack) then
						return 5
					else
						set theArtist to my replace_chars(current track's artist, "\"", "\\\"")
						set theName to currentTrack
						set trackString to theName & " - " & theArtist
						do shell script "curl -X POST --data-urlencode 'payload={\"channel\": \"" & channelName & "\", \"username\": \"" & userName & "\", \"text\": \"" & my replace_chars(trackString, "'", "\\u0027") & "\", \"icon_emoji\": \":" & emojiName & ":\"}' " & webhookURL
					end if
				end if
			end tell
		end using terms from
	end if

	return 5
end idle