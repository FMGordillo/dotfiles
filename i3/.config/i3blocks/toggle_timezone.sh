date_output=''
current_tz=''
click_event=$button

if [[ $button == "1" ]]; then
	date_output=$(TZ="America/Argentina/Buenos_Aires" date +"%a %x - %T")
	current_tz='ARG'
else
	date_output=$(TZ="Europe/Madrid" date +"%a %x - %T")
fi

echo "🗓️ $date_output"
