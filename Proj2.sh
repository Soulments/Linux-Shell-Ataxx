#!/bin/bash

declare -A -x _screen=(
    ['rows']=$(tput lines)
    ['cols']=$(tput cols)
) #행 열 정의
declare -A -x key_map=(
    ['UP']='[A'
    ['DOWN']='[B'
    ['LEFT']='[D'
    ['RIGHT']='[C'
) #방향키 정의
declare -a -x yellow_map=(9 14 18 21 27 28 35 36 42 45 49 54)
declare -g -x ESC=$( printf '\033') #ESC 입력 정의
declare -g -x half_width=$(( ${_screen['cols']} / 2 )) #행 절반
declare -g -x half_height=$(( ${_screen['rows']} / 2 )) #열 절반
declare -x file="userdata.txt" #회원목록 정의
declare -g -x map_width=$(( $half_width - 16 ))
draw_chars() #출력용 함수
{
    local x=$1 #x좌표
    local y=$2 #y좌표
    local s="$3" #입력 텍스트
    local c=$4 #색상

    printf "\033[${c}m\033[${y};${x}H${s}\033[0m"
}

draw_maps()
{
    local index=$1
    local num=0
    local pr_left=$((${_screen['cols']} / 14 * 5 - 17))
    local pr_right=$((${_screen['cols']} / 14 * 11 - 16))

    if [[ $index == 1 ]]
    then w=$pr_left
    elif [[ $index == 2 ]]
    then w=$pr_right
    else
        w=$map_width
        num=6
    fi
    
    draw_chars ${w} $((14-$num)) '┌───┬───┬───┬───┬───┬───┬───┬───┐' 0
    draw_chars ${w} $((15-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((16-$num)) '├───┼───┼───┼───┼───┼───┼───┼───┤' 0
    draw_chars ${w} $((17-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((18-$num)) '├───┼───┼───┼───┼───┼───┼───┼───┤' 0
    draw_chars ${w} $((19-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((20-$num)) '├───┼───┼───┼───┼───┼───┼───┼───┤' 0
    draw_chars ${w} $((21-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((22-$num)) '├───┼───┼───┼───┼───┼───┼───┼───┤' 0
    draw_chars ${w} $((23-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((24-$num)) '├───┼───┼───┼───┼───┼───┼───┼───┤' 0
    draw_chars ${w} $((25-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((26-$num)) '├───┼───┼───┼───┼───┼───┼───┼───┤' 0
    draw_chars ${w} $((27-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((28-$num)) '├───┼───┼───┼───┼───┼───┼───┼───┤' 0
    draw_chars ${w} $((29-$num)) '│   │   │   │   │   │   │   │   │' 0
    draw_chars ${w} $((30-$num)) '└───┴───┴───┴───┴───┴───┴───┴───┘' 0

    if [[ $index == 2 || $index == 4 ]]
    then
        draw_chars $(( ${w} + 5 )) $((17 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 25 )) $((17 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 9 )) $((19 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 21 )) $((19 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 13 )) $((21 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 17 )) $((21 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 13 )) $((23 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 17 )) $((23 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 9 )) $((25 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 21 )) $((25 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 5 )) $((27 - $num)) '   ' '1;43'
        draw_chars $(( ${w} + 25 )) $((27 -$num)) '   ' '1;43'
    fi
}

map_array()
{
    local x=$1
    local y=$2
}

main() #시작 함수
{
    local index=0 #선택된 인덱스
    local login="              "
    local login_1p="1P LOGIN"
    local signin="    SIGN IN   "
    local login_2p="2P LOGIN"
    local signout="   SIGN OUT   "
    local join="     JOIN     "
    local exit="     EXIT     "
    local pr_left=$((${_screen['cols']} / 14)) #왼쪽 정렬용
    local pr_right=$((${_screen['cols']} / 14)) #오른쪽 정렬용
    clear  

    while [ true ]
    do
        color_set

        draw_chars $(( $half_width - 16 )) 3 ' ____   ___  ____ ___ _       _ ' 0
        draw_chars $(( $half_width - 16 )) 4 '/ ___| / _ \/ ___|_ _| |     / |' 0
        draw_chars $(( $half_width - 16 )) 5 '\___ \| | | \___ \| || |     | |' 0
        draw_chars $(( $half_width - 16 )) 6 ' ___) | |_| |___) | || |___  | |' 0
        draw_chars $(( $half_width - 16 )) 7 '|____/ \___/|____/___|_____| |_|' 0
        draw_chars $(( $half_width - 16 )) 8 '    _  _____  _    __  ____  __ ' 0
        draw_chars $(( $half_width - 16 )) 9 '   / \|_   _|/ \   \ \/ /\ \/ / ' 0
        draw_chars $(( $half_width - 16 )) 10 '  / _ \ | | / _ \   \  /  \  /  ' 0
        draw_chars $(( $half_width - 16 )) 11 ' / ___ \| |/ ___ \  /  \  /  \  ' 0
        draw_chars $(( $half_width - 16 )) 12 '/_/   \_\_/_/   \_\/_/\_\/_/\_\ ' 0

        draw_chars $(( $half_width + 8 )) 14 '2018203091 정호윤' 0
        
        draw_chars $(( (${pr_left} * 5) - (${#login} / 2) )) $(( (${_screen['rows']} / 20) * 16 )) "$login" $c1
        draw_chars $(( (${pr_left} * 5) - (${#login_1p} / 2) )) $(( (${_screen['rows']} / 20) * 16 )) "${login_1p}" $c1
        draw_chars $(( (${pr_right} * 11) - (${#signin} / 2) )) $(( (${_screen['rows']} / 20) * 16 )) "$signin" $c2
        draw_chars $(( (${pr_left} * 5) - (${#login} / 2) )) $(( (${_screen['rows']} / 20) * 18 )) "$login" $c3
        draw_chars $(( (${pr_left} * 5) - (${#login_2p} / 2) )) $(( (${_screen['rows']} / 20) * 18 )) "${login_2p}" $c3
        draw_chars $(( (${pr_right} * 11) - (${#signout} / 2) )) $(( (${_screen['rows']} / 20) * 18 )) "$signout" $c4
        draw_chars $(( (${pr_left} * 6) - (${#join} / 2) )) $(( ${_screen['rows']} - 3 )) "$join" $c5
        draw_chars $(( (${pr_right} * 10) - (${#exit} / 2) )) $(( ${_screen['rows']} - 3 )) "$exit" $c6

        read -n1 -s input #첫글자 입력
        if [[ $input = $ESC ]] #방향키 입력 경우
        then
            read -n2 -s x
            if [[ $x == ${key_map['UP']} ]]
            then
                if [[ $index -ge 3 && $index -le 6 ]]
                then index=$(( $index - 2 ))
                fi
            elif [[ $x == ${key_map['DOWN']} ]]
            then
                if [[ $index -ge 1 && $index -le 4 ]]
                then index=$(( $index + 2 ))
                fi
            elif [[ $x == ${key_map['LEFT']} ]]
            then
                if [[ ${index}%2 -eq 0  &&  $index -ne 0 ]]
                then index=$(( $index - 1 ))
                fi
            else
                if [[ ${index}%2 -eq 1 ]]
                then index=$(( $index + 1 ))
                fi
            fi
            if [[ $index == 0 ]]
            then index=1
            fi
        elif [[ $input = "" ]] #엔터 입력 경우
        then
            if [[ $index == 1 ]]
            then
                login_func 1
                local login_1p=$player1
            elif [[ $index == 2 ]]
            then signin_func
            elif [[ $index == 3 ]]
            then
                login_func 2
                local login_2p=$player2
            elif [[ $index == 4 ]]
            then signout_func
            elif [[ $index == 5 ]]
            then lobby_func
            elif [[ $index == 6 ]]
            then end_func
            else continue
            fi
        else continue
        fi
    done
}

signin_func() #회원가입 함수(구조 main과 동일)
{
    local index=0
    local id="        ID        "
    local pw="        PW        "
    local dup_ch="  Duplicate check  "
    local signin="  SIGN IN  "
    local exit="   EXIT   "
    local pr_left=$((${_screen['cols']} / 14 * 6))
    local pr_right=$((${_screen['cols']} / 14 * 10))
    en=0
    clear
    
    while [ true ]
    do
        color_set

        draw_chars $(( $half_width - 16 )) 3 ' ____ ___ ____ _   _   ___ _   _ ' 0
        draw_chars $(( $half_width - 16 )) 4 '/ ___|_ _/ ___| \ | | |_ _| \ | |' 0
        draw_chars $(( $half_width - 16 )) 5 '\___ \| | |  _|  \| |  | ||  \| |' 0
        draw_chars $(( $half_width - 16 )) 6 ' ___) | | |_| | |\  |  | || |\  |' 0
        draw_chars $(( $half_width - 16 )) 7 '|____/___\____|_| \_| |___|_| \_|' 0
        
        draw_chars $(( ${pr_left} - 9 )) $(( (${_screen['rows']} / 20) * 9 )) "                  " $c1
        draw_chars $(( ${pr_left} - (${#id} / 2) )) $(( (${_screen['rows']} / 20) * 9 )) "$id" $c1
        draw_chars $(( ${pr_right} - (${#dup_ch} / 2) )) $(( (${_screen['rows']} / 20) * 9 )) "$dup_ch" $c2
        draw_chars $(( ${pr_left} - 9)) $(( (${_screen['rows']} / 20) * 11 )) "                  " $c3
        draw_chars $(( ${pr_left} - (${#pw} / 2) )) $(( (${_screen['rows']} / 20) * 11 )) "$pw" $c3
        draw_chars $(( ${pr_left} - (${#signin} / 2) )) $(( ${_screen['rows']} - 5 )) "$signin" $c4
        draw_chars $(( ${pr_right} - (${#exit} / 2) )) $(( ${_screen['rows']} - 5 )) "$exit" $c5
        read -n1 -s input
        if [[ $input = $ESC ]]
        then
            read -n2 -s x
            if [[ $x == ${key_map['UP']} ]]
            then
                if [[ $index == 4 || $index == 5 ]]
                then index=3
                elif [[ $index == 3 ]]
                then index=1
                fi
            elif [[ $x == ${key_map['DOWN']} ]]
            then
                if [[ $index == 1 || $index == 2 ]]
                then index=3
                elif [[ $index == 3 ]]
                then index=4
                fi
            elif [[ $x == ${key_map['LEFT']} ]]
            then
                if [[ $index == 2 ]]
                then index=1
                elif [[ $index == 5 ]]
                then index=5
                fi
            else
                if [[ $index == 1 ]]
                then index=2
                elif [[ $index == 4 ]]
                then index=5
                fi
            fi
            if [[ $index == 0 ]]
            then index=1
            fi
        elif [[ $input = "" ]]
        then
            if [[ $index == 1 ]]
            then
                sign_input 1 $pr_left
                local id=$inp_id
            elif [[ $index == 2 ]]
            then ch_dup
            elif [[ $index == 3 ]]
            then
                sign_input 3 $pr_left
                local pw=$inp_pw
            elif [[ $index == 4 ]]
            then user_add
            elif [[ $index == 5 ]]
            then end_func
            else continue
            fi
            if [[ $en == 1 || $index == 4 || $index == 5 ]]
            then end_func
            fi
        else continue
        fi
    done
}

signout_func()
{
    local index=0
    local id="        ID        "
    local pw="        PW        "
    local signout="  SIGN OUT  "
    local exit="   EXIT   "
    local pr_left=$((${_screen['cols']} / 14 * 6))
    local pr_right=$((${_screen['cols']} / 14 * 10))
    clear
    
    while [ true ]
    do
        color_set

        draw_chars $(( $half_width - 20 )) 3 ' ____ ___ ____ _   _    ___  _   _ _____ ' 0
        draw_chars $(( $half_width - 20 )) 4 '/ ___|_ _/ ___| \ | |  / _ \| | | |_   _|' 0
        draw_chars $(( $half_width - 20 )) 5 '\___ \| | |  _|  \| | | | | | | | | | |  ' 0
        draw_chars $(( $half_width - 20 )) 6 ' ___) | | |_| | |\  | | |_| | |_| | | |  ' 0
        draw_chars $(( $half_width - 20 )) 7 '|____/___\____|_| \_|  \___/ \___/  |_|  ' 0
        
        draw_chars $(( ${half_width} - 9 )) $(( (${_screen['rows']} / 20) * 9 )) "                  " $c1
        draw_chars $(( ${half_width} - (${#id} / 2) )) $(( (${_screen['rows']} / 20) * 9 )) "$id" $c1
        draw_chars $(( ${half_width} - 9 )) $(( (${_screen['rows']} / 20) * 11 )) "                  " $c2
        draw_chars $(( ${half_width} - (${#pw} / 2) )) $(( (${_screen['rows']} / 20) * 11 )) "$pw" $c2
        draw_chars $(( ${pr_left} - (${#signout} / 2) )) $(( ${_screen['rows']} - 5 )) "$signout" $c3
        draw_chars $(( ${pr_right} - (${#exit} / 2) )) $(( ${_screen['rows']} - 5 )) "$exit" $c4
        read -n1 -s input
        if [[ $input = $ESC ]]
        then
            read -n2 -s x
            if [[ $x == ${key_map['UP']} ]]
            then
                if [[ $index == 4 ]]
                then index=2
                fi
                if [[ $index == 2 || $index == 3 ]]
                then index=$(( $index - 1 ))
                fi
            elif [[ $x == ${key_map['DOWN']} ]]
            then
                if [[ $index == 1 || $index == 2 ]]
                then index=$(( $index + 1 ))
                fi
            elif [[ $x == ${key_map['LEFT']} ]]
            then
                if [[ $index == 4 ]]
                then index=3
                fi
            else
                if [[ $index == 3 ]]
                then index=4
                fi
            fi
            if [[ $index == 0 ]]
            then index=1
            fi
        elif [[ $input = "" ]]
        then
            if [[ $index == 1 ]]
            then
                sign_input 1 $half_width
                local id=$inp_id
            elif [[ $index == 2 ]]
            then
                sign_input 2 $half_width
                local pw=$inp_pw
            elif [[ $index == 3 ]]
            then user_del
            elif [[ $index == 4 ]]
            then end_func
            else continue
            fi
            if [[ $index == 3 || $index == 4 ]]
            then end_func
            fi
        else continue
        fi
    done
}

login_func()
{
    player=$1
    local index=0
    local id="        ID        "
    local pw="        PW        "
    local login="   LOGIN   "
    local exit="   EXIT   "
    local pr_left=$((${_screen['cols']} / 14 * 6))
    local pr_right=$((${_screen['cols']} / 14 * 10))
    clear
    
    while [ true ]
    do
        color_set

        if [[ $player == 1 ]]
        then
            draw_chars $(( $half_width - 19 )) 2 ' _ ____    _     ___   ____ ___ _   _ ' 0
            draw_chars $(( $half_width - 19 )) 3 '/ |  _ \  | |   / _ \ / ___|_ _| \ | |' 0
            draw_chars $(( $half_width - 19 )) 4 '| | | ) | | |  | | | | |  _ | ||  \| |' 0
            draw_chars $(( $half_width - 19 )) 5 '| |  __/  | |__| |_| | |_| || || |\  |' 0
            draw_chars $(( $half_width - 19 )) 6 '|_|_|     |_____\___/ \____|___|_| \_|' 0
        else
            draw_chars $(( $half_width - 21 )) 3 ' ____  ____    _     ___   ____ ___ _   _ ' 0
            draw_chars $(( $half_width - 21 )) 4 '|___ \|  _ \  | |   / _ \ / ___|_ _| \ | |' 0
            draw_chars $(( $half_width - 21 )) 5 '  __) | | ) | | |  | | | | |  _ | ||  \| |' 0
            draw_chars $(( $half_width - 21 )) 6 ' / __/|  __/  | |__| |_| | |_| || || |\  |' 0
            draw_chars $(( $half_width - 21 )) 7 '|_____|_|     |_____\___/ \____|___|_| \_|' 0
        fi
        
        draw_chars $(( ${half_width} - 9 )) $(( (${_screen['rows']} / 20) * 9 )) "                  " $c1
        draw_chars $(( ${half_width} - (${#id} / 2) )) $(( (${_screen['rows']} / 20) * 9 )) "$id" $c1
        draw_chars $(( ${half_width} - 9 )) $(( (${_screen['rows']} / 20) * 11 )) "                  " $c2
        draw_chars $(( ${half_width} - (${#pw} / 2) )) $(( (${_screen['rows']} / 20) * 11 )) "$pw" $c2
        draw_chars $(( ${pr_left} - (${#login} / 2) )) $(( ${_screen['rows']} - 5 )) "$login" $c3
        draw_chars $(( ${pr_right} - (${#exit} / 2) )) $(( ${_screen['rows']} - 5 )) "$exit" $c4
        
        read -n1 -s input
        if [[ $input = $ESC ]]
        then
            read -n2 -s x
            if [[ $x == ${key_map['UP']} ]]
            then
                if [[ $index == 4 ]]
                then index=2
                fi
                if [[ $index == 2 || $index == 3 ]]
                then index=$(( $index - 1 ))
                fi
            elif [[ $x == ${key_map['DOWN']} ]]
            then
                if [[ $index == 1 || $index == 2 ]]
                then index=$(( $index + 1 ))
                fi
            elif [[ $x == ${key_map['LEFT']} ]]
            then
                if [[ $index == 4 ]]
                then index=3
                fi
            else
                if [[ $index == 3 ]]
                then index=4
                fi
            fi
            if [[ $index == 0 ]]
            then index=1
            fi
        elif [[ $input = "" ]]
        then
            if [[ $index == 1 ]]
            then
                sign_input 1 $half_width
                local id=$inp_id
            elif [[ $index == 2 ]]
            then
                sign_input 2 $half_width
                local pw=$inp_pw
            elif [[ $index == 3 && -n "$inp_id" && -n "$inp_pw" ]]
            then
                user_ch
                return
            elif [[ $index == 4 ]]
            then end_func
            else continue
            fi
        else continue
        fi
    done
    
}

lobby_func()
{
    local index=0
    local start="   START   "
    local exit="   EXIT   "
    local pr_left=$((${_screen['cols']} / 14))
    local pr_right=$((${_screen['cols']} / 14))
    clear
    
    while [ true ]
    do
        color_set

        draw_chars $(( $half_width - 15 )) 2 '    _  _____  _    __  ____  __ ' 0
        draw_chars $(( $half_width - 15 )) 3 '   / \|_   _|/ \   \ \/ /\ \/ / ' 0
        draw_chars $(( $half_width - 15 )) 4 '  / _ \ | | / _ \   \  /  \  /  ' 0
        draw_chars $(( $half_width - 15 )) 5 ' / ___ \| |/ ___ \  /  \  /  \  ' 0
        draw_chars $(( $half_width - 15 )) 6 '/_/   \_\_/_/   \_\/_/\_\/_/\_\ ' 0

        draw_chars $(( $half_width - 14 )) 8 ' _     ___  ____  ______   __' 0
        draw_chars $(( $half_width - 14 )) 9 '| |   / _ \| __ )| __ ) \ / /' 0
        draw_chars $(( $half_width - 14 )) 10 '| |  | | | |  _ \|  _ \\ V / ' 0
        draw_chars $(( $half_width - 14 )) 11 '| |__| |_| | |_) | |_) || |  ' 0
        draw_chars $(( $half_width - 14 )) 12 '|_____\___/|____/|____/ |_|  ' 0

        draw_chars $(( ${pr_left} * 5 - 5 )) 14 ' _ ____  ' 0
        draw_chars $(( ${pr_left} * 5 - 5 )) 15 '/ |  _ \ ' 0
        draw_chars $(( ${pr_left} * 5 - 5 )) 16 '| | |_) |' 0
        draw_chars $(( ${pr_left} * 5 - 5 )) 17 '| |  __/' 0
        draw_chars $(( ${pr_left} * 5 - 5 )) 18 '|_|_|' 0

        draw_chars $(( ${pr_right} * 11 - 6 )) 14 ' ____  ____  ' 0
        draw_chars $(( ${pr_right} * 11 - 6 )) 15 '|___ \|  _ \ ' 0
        draw_chars $(( ${pr_right} * 11 - 6 )) 16 '  __) | |_) |' 0
        draw_chars $(( ${pr_right} * 11 - 6 )) 17 ' / __/|  __/ ' 0
        draw_chars $(( ${pr_right} * 11 - 6 )) 18 '|_____|_|    ' 0

        draw_chars $(( ${pr_right} * 4 )) 20 "ID : $player1" 0
        draw_chars $(( ${pr_right} * 4 )) 21 "WIN : $player1_win" 0
        draw_chars $(( ${pr_right} * 4 )) 22 "LOSE : $player1_lose" 0

        draw_chars $(( ${pr_right} * 10 )) 20 "ID : $player2" 0
        draw_chars $(( ${pr_right} * 10 )) 21 "WIN : $player2_win" 0
        draw_chars $(( ${pr_right} * 10 )) 22 "LOSE : $player2_lose" 0
                
        draw_chars $(( ${pr_left} * 6 - (${#start} / 2) )) $(( ${_screen['rows']} - 3 )) "$start" $c1
        draw_chars $(( ${pr_right} * 10 - (${#exit} / 2) )) $(( ${_screen['rows']} - 3 )) "$exit" $c2
        
        read -n1 -s input
        if [[ $input = $ESC ]]
        then
            read -n2 -s x
            if [[ $x == ${key_map['LEFT']} ]]
            then
                if [[ $index == 2 ]]
                then index=1
                fi
            elif [[ $x == ${key_map['RIGHT']} ]]
            then
                if [[ $index == 1 ]]
                then index=2
                fi
            fi
            if [[ $index == 0 ]]
            then index=1
            fi
        elif [[ $input = "" ]]
        then
            if [[ $index == 1 ]]
            then
                if [[ -n $player1 && -n $player2 ]]
                then mapsel_func
                else end_func
                fi
            elif [[ $index == 2 ]]
            then end_func
            else continue
            fi
        else continue
        fi
    done
}

mapsel_func()
{
    local index=0
    local map1="     MAP 1    "
    local map2="     MAP 2    "
    local pr_left=$((${_screen['cols']} / 14 * 5))
    local pr_right=$((${_screen['cols']} / 14 * 11))
    clear
    
    while [ true ]
    do
        color_set

        draw_chars $(( $half_width - 15 )) 2 '    _  _____  _    __  ____  __ ' 0
        draw_chars $(( $half_width - 15 )) 3 '   / \|_   _|/ \   \ \/ /\ \/ / ' 0
        draw_chars $(( $half_width - 15 )) 4 '  / _ \ | | / _ \   \  /  \  /  ' 0
        draw_chars $(( $half_width - 15 )) 5 ' / ___ \| |/ ___ \  /  \  /  \  ' 0
        draw_chars $(( $half_width - 15 )) 6 '/_/   \_\_/_/   \_\/_/\_\/_/\_\ ' 0

        draw_chars $(( $half_width - 30 )) 8  ' __  __    _    ____    ____  _____ _     _____ ____ _____ ' 0
        draw_chars $(( $half_width - 30 )) 9  '|  \/  |  / \  |  _ \  / ___|| ____| |   | ____/ ___|_   _|' 0
        draw_chars $(( $half_width - 30 )) 10 '| |\/| | / _ \ | |_) | \___ \|  _| | |   |  _|| |     | |  ' 0
        draw_chars $(( $half_width - 30 )) 11 '| |  | |/ ___ \|  __/   ___) | |___| |___| |__| |___  | |  ' 0
        draw_chars $(( $half_width - 30 )) 12 '|_|  |_/_/   \_\_|     |____/|_____|_____|_____\____| |_|  ' 0

        draw_maps 1
        draw_maps 2
        
        draw_chars $(( ${pr_left} - (${#map1} / 2) )) $(( ${_screen['rows']} - 3 )) "$map1" $c1
        draw_chars $(( ${pr_right} - (${#map2} / 2) )) $(( ${_screen['rows']} - 3 )) "$map2" $c2
        
        read -n1 -s input
        if [[ $input = $ESC ]]
        then
            read -n2 -s x
            if [[ $x == ${key_map['LEFT']} ]]
            then
                if [[ $index == 2 ]]
                then index=1
                fi
            elif [[ $x == ${key_map['RIGHT']} ]]
            then
                if [[ $index == 1 ]]
                then index=2
                fi
            fi
            if [[ $index == 0 ]]
            then index=1
            fi
        elif [[ $input = "" ]]
        then
            if [[ $index == 1 ]]
            then play_func 3
            elif [[ $index == 2 ]]
            then play_func 4
            else continue
            fi
        else continue
        fi
    done
}

play_func()
{
    local map_i=$1
    local x_index=0
    local y_index=0
    local index=0
    local pr_left=$((${_screen['cols']} / 14 * 5))
    local pr_right=$((${_screen['cols']} / 14 * 11))
    selnum_1=0
    selnum_2=0
    arr=()
    for ((i=0;i<64;i++))
    do
        arr+=(0)
    done
    if [[ $map_i == 4 ]]
    then
        for temp in ${yellow_map[@]}
        do
            arr[$temp]=2
        done
    fi
    clear
    
    while [ true ]
    do
        draw_chars $(( $half_width - 15 )) 2 '    _  _____  _    __  ____  __ ' 0
        draw_chars $(( $half_width - 15 )) 3 '   / \|_   _|/ \   \ \/ /\ \/ / ' 0
        draw_chars $(( $half_width - 15 )) 4 '  / _ \ | | / _ \   \  /  \  /  ' 0
        draw_chars $(( $half_width - 15 )) 5 ' / ___ \| |/ ___ \  /  \  /  \  ' 0
        draw_chars $(( $half_width - 15 )) 6 '/_/   \_\_/_/   \_\/_/\_\/_/\_\ ' 0
        
        draw_maps $map_i
        
        index=$(( ($y_index - 1) * 8 + ($x_index - 1) ))

		if [[ $x_index -ne 0 && $y_index -ne 0 ]]
		then map_highlight $x_index $y_index 47
		fi

        for ((i=0;i<64;i++))
        do
            if [[ ${arr[$i]} == 1 ]]
            then
                r=$(($i % 8))
                c=$(($i / 8))
                map_highlight $r+1 $c+1 44
            fi
        done
        
        draw_chars $(( ${pr_left} - 3 )) $(( ${_screen['rows']} - 1 )) "1P : $selnum_1" 0
        draw_chars $(( ${pr_right} - 3 )) $(( ${_screen['rows']} - 1 )) "2P : $selnum_2" 0

        read -n1 -s input
        if [[ $input = $ESC ]]
        then
            read -n2 -s x
            if [[ $x == ${key_map['UP']} ]]
            then
                if [[ $y_index > 1 ]]
                then ((y_index--))
                fi
            elif [[ $x == ${key_map['DOWN']} ]]
            then
                if [[ $y_index < 8 ]]
                then ((y_index++))
                fi
            elif [[ $x == ${key_map['LEFT']} ]]
            then
                if [[ $x_index > 1 ]]
                then ((x_index--))
                fi
            elif [[ $x == ${key_map['RIGHT']} ]]
            then
                if [[ $x_index < 8 ]]
                then ((x_index++))
                fi
            else continue
            fi
            if [[ $x_index == 0 || $y_index == 0 ]]
            then
                x_index=8
                y_index=8
            fi
        elif [[ $input = "" ]]
        then
            if [[ $x_index -ne 0 && $y_index -ne 0 ]]
            then
                if [[ ${arr[index]} == 0 ]]
                then
                    map_sel $index
                    ((selnum_1++))
                fi
            else continue
            fi
        else continue
        fi
    done
}

map_sel()
{
    local i=$1
    arr[$i]=1
}

map_highlight()
{
    local x=$(( ((${1} - 1) * 4) + 1 + ${map_width} ))
    local y=$(( ((${2} - 1) * 2) + 9 ))
    local c=$3
    draw_chars $x $y '   ' $c
}

ch_dup()
{
    if [[ -z $inp_id ]]
    then return
    elif [[ -n `grep ${inp_id} userdata.txt` ]]
    then draw_chars $(( $half_width - 9 )) $(( (${_screen['rows']} / 20) * 19 )) "    같은 ID 존재    " 44
    else draw_chars $(( $half_width - 9 )) $(( (${_screen['rows']} / 20) * 19 )) "    회원 가입 가능    " 44
    fi
    en=1
    sleep 5
}

user_ch()
{
    if [[ -z `grep "${inp_id} ${inp_pw}" userdata.txt` ]]
    then
        unset inp_id
        unset inp_pw
        exit
    fi
    if [[ $player == 1 ]]
    then
        player1=${inp_id}
        player1_win=`grep $inp_id userdata.txt | cut -d ' ' -f 3`
        player1_lose=`grep $inp_id userdata.txt | cut -d ' ' -f 4`
    else
        player2=${inp_id}
        player2_win=`grep $inp_id userdata.txt | cut -d ' ' -f 3`
        player2_lose=`grep $inp_id userdata.txt | cut -d ' ' -f 4`
    fi

    clear
}

user_del()
{
    if [[ -n `grep "${inp_id} ${inp_pw}" userdata.txt` ]]
    then sed -i "/^${inp_id}/d" userdata.txt
    fi
}

user_add()
{
    if [[ -z ${inp_id} || -n `grep "${inp_id}" userdata.txt` ]]
    then end_func
    else echo -e "${inp_id} ${inp_pw} 0 0" >> userdata.txt
    fi
}

sign_input()
{
    local index=$1
    local pr=$2
    local h=0
    if [[ $index == 1 ]]
    then h=9
    else h=11
    fi
    draw_chars $(( ${pr} - 9 )) $(( (${_screen['rows']} / 20) * $h )) "                  " 41
    draw_chars $(( ${pr} - 10 )) $(( (${_screen['rows']} / 20) * $h )) " " 0
    if [[ $index == 1 ]]
    then
        read inp_id
        clear
    else
        read inp_pw
        clear
    fi
}

color_set()
{
    c1=44
    c2=44
    c3=44
    c4=44
    c5=44
    c6=44
    if [[ $index == 1 ]]
    then c1=41
    elif [[ $index == 2 ]]
    then c2=41
    elif [[ $index == 3 ]]
    then c3=41
    elif [[ $index == 4 ]]
    then c4=41
    elif [[ $index == 5 ]]
    then c5=41
    elif [[ $index == 6 ]]
    then c6=41
    fi
}

end_func()
{
    clear
    exit
}

if [ ! -e $file ]
then
        touch userdata.txt
fi

main
