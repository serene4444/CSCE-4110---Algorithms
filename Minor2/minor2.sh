# Name: Serene Plummer sp3155
# Course: CSCE 3600
# Assignment: Minor 2 - Writing Bash Scripts

#-------------------------------------------------------------
# 1. DEBUG MODE
if [[ "$1" == "--debug" ]]; then
    set -x
fi


# Global Variables
LOG_FILE="$HOME/minor2_actions.log"
MAX_REMINDERS=5
reminders=()

# log_action : append a timestamped message to the log file
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$(whoami)] $1" >> "$LOG_FILE"
}

# handle_signal : calls by trap on SIGINT and SIGTERM to log the signal and exit gracefully
handle_signal() {
    echo
    echo "Use the menu to exit safely."
    log_action "Script interrupted by $1 (ignored)."
}

#-------------------------------------------------------------
# 2. SIGNAL HANDLING
trap 'handle_signal SIGINT' SIGINT
trap 'handle_signal SIGTERM' SIGTERM

# print_calendar: display the current month without depending on the cal utility
print_calendar() {
    local month_start first_weekday days_in_month day weekday
    month_start=$(date '+%Y-%m-01')
    first_weekday=$(date -d "$month_start" '+%w') || return 1
    days_in_month=$(date -d "$month_start +1 month -1 day" '+%d') || return 1
    days_in_month=$((10#$days_in_month))

    date -d "$month_start" '+%B %Y' || return 1
    echo "Su Mo Tu We Th Fr Sa"
    printf '%*s' "$((first_weekday * 3))" ""
    for ((day = 1; day <= days_in_month; day++)); do
        printf '%2d ' "$day"
        weekday=$(((first_weekday + day) % 7))
        if (( weekday == 0 )); then
            printf '\n'
        fi
    done
    if (( (first_weekday + days_in_month) % 7 != 0 )); then
        printf '\n'
    fi
}

# daily_briefing: greeting, date/time, calendar, number of running processes
daily_briefing() {
    echo "Good morning, $(whoami)!"
    echo "Date and Time: $(date)"
    echo "Calendar:"
    if ! print_calendar; then
        echo "Unable to display the calendar."
        log_action "Failed to display calendar."
    fi
    echo "Running Processes: $(ps -eo pid --no-headers | wc -l)"
    log_action "Displayed daily briefing."
}

# organize_files: ask for a directory, count files, list .txt/.sh/.log files, and move .log files to logs subdirectory
organize_files() {
    local dir
    read -p "Enter the directory to organize: " dir

    #check that "$dir" is a directory. if not print "ivalid directory" and return to the menu
    if [[ ! -d "$dir" ]]; then
        echo "Invalid directory. Please try again."
        log_action "Invalid directory entered: $dir"
        return
    fi

    echo "Scanning $dir..."

    # TODO 2: print "Total files: N"   (count regular files only)
    local total_files
    total_files=$(find "$dir" -maxdepth 1 -type f | wc -l)
    echo "Total files: $total_files"

    echo "Text files:"
    ls "$dir"/*.txt 2>/dev/null || echo "No text files found."
    
    echo "Shell scripts:"
    ls "$dir"/*.sh 2>/dev/null || echo "No shell scripts found."
   
    echo "Log files:"
    ls "$dir"/*.log 2>/dev/null || echo "No log files found."
 
    mkdir -p "$dir/logs"
    mv "$dir"/*.log "$dir/logs/" 2>/dev/null || echo "No log files to move."
   
    log_action "Organized files in $dir"
}

# add_reminder: add a reminder to the array (max MAX_REMINDERS)
add_reminder() {
    if (( ${#reminders[@]} >= MAX_REMINDERS )); then
        echo "Reminder list is full."
        return
    fi

    local reminder
    read -r -p "Enter reminder: " reminder
    reminders+=("$reminder")
    log_action "Added reminder: $reminder"
    echo "Reminder added."
}

# view_reminders: print every reminder as "index: text"
view_reminders() {
    if (( ${#reminders[@]} == 0 )); then
        echo "No reminders."
        return
    fi

    echo "Reminders:"
    local i
    for i in "${!reminders[@]}"; do
        echo "$i: ${reminders[$i]}"
    done
    log_action "Viewed reminders"
}

# delete_reminder: remove a reminder by its index
delete_reminder() {
    local idx
    read -r -p "Enter index to delete: " idx
    if [[ ! "$idx" =~ ^[0-9]+$ ]] || [[ -z "${reminders[$idx]+set}" ]]; then
        echo "Invalid reminder index."
        return
    fi

    unset 'reminders[idx]'
    echo "Reminder deleted."
    log_action "Deleted reminder at index $idx"
}

# health_check: read a heart rate and classify it with if-elif-else
#               <60 Low, 60-100 Normal, >100 High
health_check() {
    local hr result
    read -r -p "Enter your heart rate: " hr
    if [[ ! "$hr" =~ ^[0-9]+$ ]]; then
        echo "Invalid heart rate. Please enter a whole number."
        log_action "Invalid heart rate entered: $hr"
        return
    fi

    if (( hr < 60 )); then
        result="Heart rate is Low."
    elif (( hr <= 100 )); then
        result="Heart rate is Normal."
    else
        result="Heart rate is High."
    fi

    echo "$result"
    log_action "Heart rate $hr: $result"
}

#------------------------------------------------------------------------------
# MAIN PROGRAM

log_action "Script started."
daily_briefing

PS3="Please select an option: "
options=("Organize Files" "Add Reminder" "View Reminders" "Delete Reminder" "Health Check" "Exit")

# 3. MENU MODE - outer while re-prints the full menu after each action;
#    select reads one choice, then we break out to the while loop.
COLUMNS=1
while true; do
    echo
    echo "Choose an option:"
    select opt in "${options[@]}"; do
        case $REPLY in
            1) organize_files ;;
            2) add_reminder ;;
            3) view_reminders ;;
            4) delete_reminder ;;
            5) health_check ;;
            6) echo "Goodbye!"
                log_action "User exited via menu"
                exit 0 ;;
            *) echo "Invalid option. Please try again." ;;
        esac
        break
    done

    #select also ends on end-of-input (Ctrl+D); REPLY is then empty 
    if [[ -z "$REPLY" ]]; then
       echo; echo "Goodbye!"
        log_action "End of input - exiting"
        exit 0
    fi
done
