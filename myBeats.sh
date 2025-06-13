#!/bin/bash

# Variables
mDIR="$HOME/Music/"
iDIR="assets"
rofi_theme="beats-glass.rasi"

# Online Stations
# Edit it according to your choice 
declare -A online_music=(
  ["News - BBC Network 📻📰"]="https://www.bbc.co.uk/sounds/play/live/bbc_world_service"
  ["News - NPR News 📻📰"]="https://nprstreaming-arts-prod-01.streamguys1.com:443/npr_allsides_news.mp3"
  ["News - CNN News 📻📰"]="http://streaming.cnn.com:8000/cnn_world.mp3"
  ["News - Al Jazeera English 📻📰"]="http://media-aljazeera-eng-01.s3.amazonaws.com/live/aljazeera/stream.m3u8"
  ["FM - Ujalyo Network 📻🎶"]="https://onlineradiobox.com/np/ujyaalo90network/?cs=np.ujyaalo90network&played=1"
  ["FM - Easy Rock - Baguio 91.9 📻🎶"]="https://radio-stations-philippines.com/easy-rock-baguio"
  ["FM - Love Radio 90.7 📻🎶"]="https://radio-stations-philippines.com/love"
  ["FM - WRock - CEBU 96.3 📻🎶"]="https://onlineradio.ph/126-96-3-wrock.html"
  ["FM - Fresh Philippines 📻🎶"]="https://onlineradio.ph/553-fresh-fm.html"
  ["Radio - Lofi Girl 🎧🎶"]="https://play.streamafrica.net/lofiradio"
  ["Radio - Chillhop 🎧🎶"]="http://stream.zeno.fm/fyn8eh3h5f8uv"
  ["Radio - Ibiza Global 🎧🎶"]="https://filtermusic.net/ibiza-global"
  ["Radio - Metal Music 🎧🎶"]="https://tunein.com/radio/mETaLmuSicRaDio-s119867/"
  ["YT - Wish 107.5 YT Pinoy HipHop 📻🎶"]="https://youtube.com/playlist?list=PLkrzfEDjeYJnmgMYwCKid4XIFqUKBVWEs&si=vahW_noh4UDJ5d37"
  ["YT - Youtube Top 100 Songs Global 📹🎶"]="https://youtube.com/playlist?list=PL4fGSI1pDJn6puJdseH2Rt9sMvt9E2M4i&si=5jsyfqcoUXBCSLeu"
  ["YT - Relaxing Piano Music 🎹🎶"]="https://youtu.be/6H7hXzjFoVU?si=nZTPREC9lnK1JJUG"
  ["YT - Youtube Remix 📹🎶"]="https://youtube.com/playlist?list=PLeqTkIUlrZXlSNn3tcXAa-zbo95j0iN-0"
  ["YT - Relaxing Piano Jazz Music 🎹🎶"]="https://youtu.be/85UEqRat6E4?si=jXQL1Yp2VP_G6NSn"
  ["YT - Relaxing youtube songs 🎹🎶"]="https://www.youtube.com/watch?v=GYgnPrmbxH4&list=RDGMEMCMFH2exzjBeE_zAHHJOdxg&start_radio=1&rv=u6jHblOBOrk"
  ["YT - Kishore Kumar Golden Hits 🎶"]="https://youtu.be/GHPIVOdCh4w"
  ["YT - Lata Mangeshkar & Mohammad Rafi Duets 🎵"]="https://youtu.be/6RZA3zjFoVU"
  ["YT - Kumar Sanu & Alka Yagnik 90s Songs 💕"]="https://youtu.be/GZivKJpLh2U"
  ["YT - Udit Narayan Evergreen Hits 🎤🎶"]="https://youtu.be/ZbGGmU7X2aQ"
  ["YT - Mukesh & Mohammed Rafi Old Hindi Songs 🎶"]="https://youtu.be/xpmNJVIVn3o"
  ["YT - Ed Sheeran Greatest Hits 🎸🎶"]="https://youtube.com/playlist?list=PLjp0AEEJ0-fGKG_3skl0e1FQlJfnx-TJz&si=qTb6qbiz16FUz6je"
  ["YT - Coldplay Best Songs Collection 🎸🎶"]="https://youtu.be/cIGd8gm_pYE"
  ["YT - The Best of Adele 🎤🎶"]="https://youtu.be/2s0WW7IfaC0?si=rE649iLaoUBN_e4R"
  ["YT - Taylor Swift Love Songs Collection 💕🎶"]="https://youtu.be/AX1-3xUuw8M?si=sQhIH-IVoWkaVf9b"
  ["YT - Narayan Gopal Songs 🎹🎶"]="https://youtu.be/Jg8sUojDgXw?si=H5BW60jEfcVoa7Jd"
  ["YT - NEPATHYA Evergreen songs 🎹🎶"]="https://youtu.be/MeBjCVAyXqA?si=Yov7pvxPJdja4rH5"
  ["YT - Sushant KC hit song collection 🎹🎶"]="https://youtu.be/TFkyTUEMd0c?si=hcTG5YZ9_uc5nney"
  ["YT - Best of SUJAN CHAPAGAIN 🎹🎶"]="https://youtu.be/MMxanjQYU3M?si=ZXL_tgWj-0E78WX_"
  ["YT - South Indian Chuttamalle 🎹🎶"]="https://youtu.be/5vsOv_bcnhs?si=5ASAs-LXnV74QW9d"
  ["YT - South indian playlist 🎹🎶"]="https://youtube.com/playlist?list=PLm9c6V-WcpRyhE9opBzjFQgzV2bF3-NS2&si=o2lZ43tluMEDuzo9"
  ["YT - Husn Mashup🎹🎶"]="https://youtu.be/_mR6bY-ndso?si=ZOU7aKQytoSc2bG9"
  ["YT - Hindi X English🎹🎶"]="https://youtu.be/CmHfWSxt0UQ?si=5B8RBFsJwhgJgfxG"
  ["YT - Ohso 🎹🎶"]="https://youtu.be/hw4XOTf0VcM?si=fprEBMOv3SeWv46g"
)

# Populate local_music array with files from music directory and subdirectories
populate_local_music() {
  local_music=()
  filenames=()
  while IFS= read -r file; do
    local_music+=("$file")
    filenames+=("$(basename "$file")")
  done < <(find -L "$mDIR" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.mp4" \))
}

# Function for displaying notifications
notification() {
  notify-send -u normal -i "iDIR/music.png" "Now Playing:" "$@"
}

# Main function for playing local music
play_local_music() {
  populate_local_music

  # Prompt the user to select a song
  choice=$(printf "%s\n" "${filenames[@]}" | rofi -i -dmenu -config $rofi_theme)

  if [ -z "$choice" ]; then
    exit 1
  fi

  # Find the corresponding file path based on user's choice and set that to play the song then continue on the list
  for (( i=0; i<"${#filenames[@]}"; ++i )); do
    if [ "${filenames[$i]}" = "$choice" ]; then
      notification "$choice"
      mpv --playlist-start="$i" --loop-playlist --vid=no  "${local_music[@]}"
      break
    fi
  done
}

# Main function for shuffling local music
shuffle_local_music() {
  notification "Playing local music🥰🥰"
  # Play music in $mDIR on shuffle
  mpv --shuffle --loop-playlist --vid=no "$mDIR"
}

# Main function for playing online music
play_online_music() {
  choice=$(for online in "${!online_music[@]}"; do
      echo "$online"
    done | sort | rofi -i -dmenu -config "$rofi_theme")

  if [ -z "$choice" ]; then
    exit 1
  fi

  link="${online_music[$choice]}"
  notification "$choice"
  # Play the selected online music using mpv
  mpv --shuffle --vid=no "$link"
}

# Function to stop music and kill mpv processes
stop_music() {
  mpv_pids=$(pgrep -x mpv)

  if [ -n "$mpv_pids" ]; then
    mpvpaper_pid=$(ps aux | grep -- 'unique-wallpaper-process' | grep -v 'grep' | awk '{print $2}')

    for pid in $mpv_pids; do
      if ! echo "$mpvpaper_pid" | grep -q "$pid"; then
        kill -9 $pid || true
      fi
    done
    notify-send -u low -i "$iDIR/music.png" "Music stopped. Bye!!🥰🥰" || true
  fi
}

# Function to search and play music from YouTube
search_youtube_music() {
  # Get user query via rofi
  query=$(rofi -dmenu -p "🎵 Song name? 🥰:" -config "$rofi_theme")

  if [ -z "$query" ]; then
    exit 1
  fi

  # Show persistent "Searching..." notification with fake spinner
  notif_id=$(dunstify -p -a "Rofi Beats" -i "$iDIR/music.png" "🔍 Searching on YouTube. Please wait🥰🥰" "🎵 \"$query\"" -u low -t 0)

  # Fetch top 5 results with title + duration + video ID
  mapfile -t raw_results < <(yt-dlp "ytsearch5:$query" --print "%(title)s | %(duration)s | %(id)s")

  # Close the persistent "loading" notification
  dunstify -C "$notif_id"

  # Show a fallback if no results found
  if [ ${#raw_results[@]} -eq 0 ]; then
    dunstify -a "Rofi Beats" -i "$iDIR/music.png" "🚫 No results" "\"$query\" not found"
    exit 1
  fi

  # Let user choose from the cleaned list
  choice=$(printf "%s\n" "${raw_results[@]}" | rofi -dmenu -i -p "🎧Here is it🥰🎼🎼:" -config "$rofi_theme")

  if [ -z "$choice" ]; then
    exit 1
  fi

  # Extract video ID and play
  video_id=$(echo "$choice" | awk -F' | ' '{print $NF}')
  video_url="https://www.youtube.com/watch?v=$video_id"

  title=$(echo "$choice" | awk -F' | ' '{print $1}')
  notification "🎶 Now Playing😍" "$title"
  mpv --no-video "$video_url"
}

# Function to create a YouTube mix
create_youtube_mix() {
  # Get user query via rofi (to search YouTube Mix)
  query=$(rofi -dmenu -p "🎵 Genre please🥰:" -config "$rofi_theme")
  if [ -z "$query" ]; then
    exit 1
  fi

  # Show persistent "Searching..." notification
  notif_id=$(dunstify -p -a "Rofi Beats" -i "$iDIR/music.png" "🔍 Searching... Please wait🥰🥰!!" "🎵 \"$query\" mix" -u low -t 0)

  # Fetch YouTube Mix results with title + video ID
  mapfile -t raw_results < <(yt-dlp "ytsearch5:$query mix" --print "%(title)s | %(id)s")

  # Close the persistent "loading" notification
  dunstify -C "$notif_id"

  # Show fallback if no results found
  if [ ${#raw_results[@]} -eq 0 ]; then
    dunstify -a "Rofi Beats" -i "$iDIR/music.png" "🚫 No results found" "\"$query\" mix not available."
    exit 1
  fi

  # Let user choose a YouTube Mix from the cleaned list
  choice=$(printf "%s\n" "${raw_results[@]}" | rofi -dmenu -i -p "🎧 Here it is🥰🥰:" -config "$rofi_theme")

  if [ -z "$choice" ]; then
    exit 1
  fi

  # Extract video ID from selected mix
  mix_id=$(echo "$choice" | awk -F' | ' '{print $NF}')
  mix_url="https://www.youtube.com/watch?v=$mix_id"

  # Notify user about mix creation process
  creating_notif_id=$(dunstify -p -a "Rofi Beats" -i "$iDIR/music.png" "⏳ Creating mix..." "Gathering videos from the mix...😍")

  # Extract individual video URLs (limit to first 10)
  playlist_urls=$(yt-dlp --flat-playlist -i "$mix_url" --print "%(id)s" | head -n 10 | awk '{print "https://www.youtube.com/watch?v="$1}')

  # Check if any URLs were extracted
  if [ -z "$playlist_urls" ]; then
    dunstify -a "Rofi Beats" -i "$iDIR/music.png" "🚫 Failed to extract videos" "No videos found in the selected mix.😔"
    dunstify -C "$creating_notif_id"
    exit 1
  fi

  # Close the notification and start playback
  dunstify -C "$creating_notif_id"
  mpv --no-video --playlist <(echo "$playlist_urls")
}

# Check if music is already playing
if pgrep -x "mpv" > /dev/null; then
  stop_music
else
  user_choice=$(printf "🔘Play from Online Stations\n🎸Play from Music directory\n🎼Shuffle Play from Music directory\n👉Search and Play from YouTube\n🎧Youtube mix" | rofi -dmenu -config $rofi_theme)

  echo "User choice: $user_choice"

  case "$user_choice" in
    "🎸Play from Music directory")
      play_local_music
      ;;
    "🔘Play from Online Stations")
      play_online_music
      ;;
    "🎼Shuffle Play from Music directory")
      shuffle_local_music
      ;;
    "🎧Youtube mix")
      create_youtube_mix
      ;;
    "👉Search and Play from YouTube")
      search_youtube_music
      ;;
    *)
      ;;
  esac
fi
