#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: nightly-43-gb81f9f7
if [ -n "$ZSH_VERSION" ]; then
    EXEC_SHELL="zsh"
elif [ -n "$KSH_VERSION" ]; then
    EXEC_SHELL="ksh"
else
    EXEC_SHELL="bash"
fi
if [ -n "$ZSH_VERSION" ]; then
    __exec_shell_version="$ZSH_VERSION"
    IFS='.' read -r __exec_v1 __exec_v2 __exec_v3 <<< "${__exec_shell_version}"
    set -A EXEC_SHELL_VERSION -- "${__exec_v1:-0}" "${__exec_v2:-0}" "${__exec_v3:-0}"
elif [ -n "$KSH_VERSION" ]; then
    __exec_shell_version="${KSH_VERSION#Version }"
    __exec_shell_version="${__exec_shell_version#* }"
    __exec_shell_version="${__exec_shell_version%% *}"
    __exec_v1="${__exec_shell_version%%[!0-9]*}"
    __exec_v2=0
    __exec_v3=0
    EXEC_SHELL_VERSION=(${__exec_v1:-0} ${__exec_v2:-0} ${__exec_v3:-0})
else
    EXEC_SHELL_VERSION=("${BASH_VERSINFO[0]}" "${BASH_VERSINFO[1]}" "${BASH_VERSINFO[2]}")
fi
# array_find(array: [Text], value: Text)
array_find__0_v0() {
    local array_503=("${!1}")
    local value_504="${2}"
    index_506=0;
    for element_505 in "${array_503[@]}"; do
        if [[ "${value_504}" == "${element_505}" ]]; then
            ret_array_find0_v0="${index_506}"
            return 0
        fi
        (( index_506++ )) || true
    done
    ret_array_find0_v0=-1
    return 0
}

# array_contains(array: [Text], value: Text)
array_contains__2_v0() {
    local array_501=("${!1}")
    local value_502="${2}"
    array_find__0_v0 array_501[@] "${value_502}"
    local result_507="${ret_array_find0_v0}"
    ret_array_contains2_v0="$(( result_507 >= 0 ))"
    return 0
}

# int_check(string: Text)
int_check__14_v0() {
    local string_615="${1}"
    [ "${string_615}" -eq "${string_615}" ] >/dev/null 2>&1
    __status=$?
    ret_int_check14_v0="$(( __status == 0 ))"
    return 0
}

# num_check(string: Text)
num_check__16_v0() {
    local string_616="${1}"
    local __length_2="${string_616}"
    if (( ${#__length_2} == 0 )); then
        ret_num_check16_v0=0
        return 0
    fi
    printf "%f" "${string_616}" >/dev/null 2>&1
    __status=$?
    ret_num_check16_v0="$(( __status == 0 ))"
    return 0
}

# bool_check(string: Text)
bool_check__17_v0() {
    local string_617="${1}"
    local array_3=("true" "false" "1" "0")
    array_contains__2_v0 array_3[@] "${string_617}"
    ret_bool_check17_v0="${ret_array_contains2_v0}"
    return 0
}

command_4="$(echo -e "\x1B")"
__status=$?
# replace(source: Text, search: Text, replace: Text)
replace__24_v0() {
    local source_544="${1}"
    local search_545="${2}"
    local replace_546="${3}"
    # Here we use a command to avoid #646
    local result_547=""
    left_comp=("${EXEC_SHELL_VERSION[@]}")
    right_comp=(4 3)
    local comp
    comp="$(
        # Compare if left array >= right array
        len_comp="$( (( "${#left_comp[@]}" < "${#right_comp[@]}" )) && echo "${#left_comp[@]}"|| echo "${#right_comp[@]}")"
        for (( i=0; i<len_comp; i++ )); do
            left="${left_comp[i]?"Index out of bounds (at unknown)"}"
            right="${right_comp[i]?"Index out of bounds (at unknown)"}"
            if (( left > right )); then
                echo 1
                exit
            elif (( left < right )); then
                echo 0
                exit
            fi
        done
        (( "${#left_comp[@]}" == "${#right_comp[@]}" || "${#left_comp[@]}" > "${#right_comp[@]}" )) && echo 1 || echo 0
)"
    if { [[ "${EXEC_SHELL}" == "ksh" ]] || { [[ "${EXEC_SHELL}" == "bash" ]] && [[ "${comp}" != 0 ]]; }; }; then
        result_547="${source_544//"${search_545}"/"${replace_546}"}"
        __status=$?
    else
        result_547="${source_544//"${search_545}"/${replace_546}}"
        __status=$?
    fi
    ret_replace24_v0="${result_547}"
    return 0
}

# split(text: Text, delimiter: Text)
split__28_v0() {
    local text_514="${1}"
    local delimiter_515="${2}"
    local result_516=()
    # zsh uses -A for array, bash uses -a, ksh is VERY bad at splitting anything
    if [[ "${EXEC_SHELL}" == "zsh" ]]; then
        IFS="${delimiter_515}" read -rd '' -A result_516 < <(printf %s "$text_514")
        __status=$?
    elif [[ "${EXEC_SHELL}" == "ksh" ]]; then
        if [[ "${delimiter_515}" == "
" ]]; then
            while read -r -d $'\n'; do result_516+=("$REPLY"); done < <(echo "$text_514")
            __status=$?
        else
            IFS="${delimiter_515}" read -rd '' -a result_516 < <(printf %s "$text_514")
            __status=$?
        fi
    elif [[ "${EXEC_SHELL}" == "bash" ]]; then
        IFS="${delimiter_515}" read -rd '' -a result_516 < <(printf %s "$text_514")
        __status=$?
    fi
    ret_split28_v0=("${result_516[@]}")
    return 0
}

# lowercase(text: Text)
lowercase__35_v0() {
    local text_625="${1}"
    left_comp=("${EXEC_SHELL_VERSION[@]}")
    right_comp=(4 3)
    local comp
    comp="$(
        # Compare if left array < right array
        len_comp="$( (( "${#left_comp[@]}" < "${#right_comp[@]}" )) && echo "${#left_comp[@]}"|| echo "${#right_comp[@]}")"
        for (( i=0; i<len_comp; i++ )); do
            left="${left_comp[i]?"Index out of bounds (at unknown)"}"
            right="${right_comp[i]?"Index out of bounds (at unknown)"}"
            if (( left < right )); then
                echo 1
                exit
            elif (( left > right )); then
                echo 0
                exit
            fi
        done
        (( "${#left_comp[@]}" < "${#right_comp[@]}" )) && echo 1 || echo 0
)"
    if { [[ "${EXEC_SHELL}" == "bash" ]] && [[ "${comp}" != 0 ]]; }; then
        text_625="$(printf '%s' "${text_625}" | tr '[:upper:]' '[:lower:]')"
        __status=$?
    else
        typeset -l text_625
            text_625="${text_625}"
        __status=$?
    fi
    ret_lowercase35_v0="${text_625}"
    return 0
}

# text_contains(source: Text, search: Text)
text_contains__40_v0() {
    local source_522="${1}"
    local search_523="${2}"
    [[ "${source_522}" == *"${search_523}"* ]]
    __status=$?
    ret_text_contains40_v0="$(( __status == 0 ))"
    return 0
}

# starts_with(text: Text, prefix: Text)
starts_with__46_v0() {
    local text_550="${1}"
    local prefix_551="${2}"
    [[ "${text_550}" == "${prefix_551}"* ]]
    __status=$?
    ret_starts_with46_v0="$(( __status == 0 ))"
    return 0
}

command_8="$(echo -e "\x1B")"
__status=$?
__ESC_41="${command_8}"
__WHITE_42="${__ESC_41}[38;5;255m"
__BLACK_43="${__ESC_41}[38;5;0m"
__RED_44="${__ESC_41}[38;5;1m"
__RED_BG_45="${__ESC_41}[48;5;1m"
__RED_UNDERLINE_46="${__ESC_41}[4;58:5:1m"
__GREEN_47="${__ESC_41}[38;5;2m"
__GREEN_BG_48="${__ESC_41}[48;5;2m"
__GREEN_UNDERLINE_49="${__ESC_41}[4;58:5:2m"
__YELLOW_50="${__ESC_41}[38;5;214m"
__YELLOW_BG_51="${__ESC_41}[48;5;214m"
__YELLOW_UNDERLINE_52="${__ESC_41}[4;58:5:2m"
__BLUE_53="${__ESC_41}[38;5;4m"
__BLUE_BG_54="${__ESC_41}[48;5;4m"
__BLUE_UNDERLINE_55="${__ESC_41}[4;58:5:4m"
__MAGENTA_56="${__ESC_41}[38;5;5m"
__MAGENTA_BG_57="${__ESC_41}[48;5;5m"
__MAGENTA_UNDERLINE_58="${__ESC_41}[4;58:5:5m"
__CYAN_59="${__ESC_41}[38;5;38m"
__CYAN_BG_60="${__ESC_41}[48;5;38m"
__CYAN_UNDERLINE_61="${__ESC_41}[4;58:5:38m"
__GRAY_62="${__ESC_41}[38;5;241m"
__GRAY_BG_63="${__ESC_41}[48;5;241m"
__GRAY_UNDERLINE_64="${__ESC_41}[4;58:5:241m"
__PURPLE_65="${__ESC_41}[38;5;63m"
__PURPLE_BG_66="${__ESC_41}[48;5;63m"
__PURPLE_UNDERLINE_67="${__ESC_41}[4;58:5:63m"
__NC_68="${__ESC_41}[0m"
__BOLD_69="${__ESC_41}[1m"
__DIM_70="${__ESC_41}[2m"
__UNDERLINE_71="${__ESC_41}[4m"
# print_prefix(style: Text, string: Text, color: Text, color_bg: Text)
print_prefix__70_v0() {
    local style_469="${1}"
    local string_470="${2}"
    local color_471="${3}"
    local color_bg_472="${4}"
    if [[ "${style_469}" == "minimal" ]]; then
        ret_print_prefix70_v0="${__BOLD_69}${color_471}${string_470}${__NC_68}"
        return 0
    elif [[ "${style_469}" == "classic" ]]; then
        ret_print_prefix70_v0="${__BOLD_69}${color_471}[${string_470}]${__NC_68}"
        return 0
    elif [[ "${style_469}" == "inverted" ]]; then
        ret_print_prefix70_v0="${__GRAY_BG_63}${__BOLD_69}${color_471} ${string_470} ${__NC_68}"
        return 0
    else
        ret_print_prefix70_v0="${color_bg_472}${__WHITE_42}${__BOLD_69} ${string_470} ${__NC_68}"
        return 0
    fi
}

__PREFIX_FORMAT_72="default"
# update_error_format(prefix_style: Text, monotone: Bool)
update_error_format__74_v0() {
    local prefix_style_467="${1}"
    local monotone_468="${2}"
    local __length_9="${prefix_style_467}"
    if (( ${#__length_9} > 0 )); then
        print_prefix__70_v0 "${prefix_style_467}" "ERROR" "${__RED_44}" "${__RED_BG_45}"
    fi
    if [[ ${monotone_468} != 0 ]]; then
        __ERROR_FORMAT_74+="${__RED_44}"
    fi
}

# update_warn_format(prefix_style: Text, monotone: Bool)
update_warn_format__75_v0() {
    local prefix_style_475="${1}"
    local monotone_476="${2}"
    local __length_10="${prefix_style_475}"
    if (( ${#__length_10} > 0 )); then
        print_prefix__70_v0 "${prefix_style_475}" "WARN" "${__YELLOW_50}" "${__YELLOW_BG_51}"
    fi
    if [[ ${monotone_476} != 0 ]]; then
        __WARN_FORMAT_77+="${__YELLOW_50}"
    fi
}

# update_success_format(prefix_style: Text, monotone: Bool)
update_success_format__76_v0() {
    local prefix_style_477="${1}"
    local monotone_478="${2}"
    local __length_11="${prefix_style_477}"
    if (( ${#__length_11} > 0 )); then
        print_prefix__70_v0 "${prefix_style_477}" "SUCCESS" "${__GREEN_47}" "${__GREEN_BG_48}"
    fi
    if [[ ${monotone_478} != 0 ]]; then
        __SUCCESS_FORMAT_76+="${__GREEN_47}"
    fi
}

# update_log_format(prefix_style: Text, monotone: Bool)
update_log_format__77_v0() {
    local prefix_style_473="${1}"
    local monotone_474="${2}"
    local __length_12="${prefix_style_473}"
    if (( ${#__length_12} > 0 )); then
        print_prefix__70_v0 "${prefix_style_473}" "INFO" "${__BLUE_53}" "${__BLUE_BG_54}"
    fi
    if [[ ${monotone_474} != 0 ]]; then
        __LOG_FORMAT_75+="${__BLUE_53}"
    fi
}

# update_format(prefix: Text, monotone: Bool)
update_format__78_v0() {
    local prefix_465="${1}"
    local monotone_466="${2}"
    update_error_format__74_v0 "${prefix_465}" "${monotone_466}"
    update_log_format__77_v0 "${prefix_465}" "${monotone_466}"
    update_warn_format__75_v0 "${prefix_465}" "${monotone_466}"
    update_success_format__76_v0 "${prefix_465}" "${monotone_466}"
}

command_13="$(echo -e "\x1B")"
__status=$?
# #!/bin/env amber
# capture_native_regex(string: Text, regex: Text, capture_array: [Text])
capture_native_regex__136_v0() {
    local string_532="${1}"
    local regex_533="${2}"
    local -n capture_array_534="${3}"
    local __length_14="${regex_533}"
    local __length_15="${string_532}"
    if { (( ${#__length_14} == 0 )) || (( ${#__length_15} == 0 )); }; then
        ret_capture_native_regex136_v0=0
        return 0
    fi
    [[ "${string_532}" =~ ${regex_533} ]]
    __status=$?
    local capture_status_535="${__status}"
    case "${EXEC_SHELL}" in
        "bash") capture_array_534=("${BASH_REMATCH[@]}") ;; 
        "zsh") capture_array_534=("${MATCH[@]}") ;; 
        "ksh") capture_array_534=("${.sh.match[@]}") ;;
    esac
    __status=$?
    ret_capture_native_regex136_v0="$(( capture_status_535 == 0 ))"
    return 0
}

# type placeholders
# #!/bin/env amethyst
update_format__78_v0 "${__PREFIX_FORMAT_72}" 0
# #!/bin/env amethyst
__DEBUGGER_FUNCS_487=()
# render_debug_line(funcname: Text, code: Int)
render_debug_line__164_v0() {
    local funcname_488="${1}"
    local code_489="${2}"
    array_contains__2_v0 __DEBUGGER_FUNCS_487[@] "${funcname_488}"
    local ret_array_contains2_v0__20_12="${ret_array_contains2_v0}"
    if (( ! ret_array_contains2_v0__20_12 )); then
        ret_render_debug_line164_v0=''
        return 0
    fi
    if (( code_489 != 0 )); then
        printf '%s\n' "${__ESC_41}[1A${__RED_44}●${__NC_68}"
    fi
    local command_508=""
    local temp_509=""
    command_508="$BASH_COMMAND"
    __status=$?
    local captured_510=()
    split__28_v0 "${command_508}" " "
    local ret_split28_v0__29_17=("${ret_split28_v0[@]}")
    local cmd_517="${ret_split28_v0__29_17[0]?"Index out of bounds (at /root/projects/debugger/src/main.ab:29:37)"}"
    text_contains__40_v0 "${command_508}" "="
    local ret_text_contains40_v0__57_9="${ret_text_contains40_v0}"
    capture_native_regex__136_v0 "${command_508}" "^(.*)=([\"|\$].*)" "captured_510"
    local ret_capture_native_regex136_v0__57_41="${ret_capture_native_regex136_v0}"
    if { [[ "${cmd_517}" == "[" ]] || [[ "${cmd_517}" == "[[" ]]; }; then
        local modified_518="${command_508}"
        split__28_v0 "${command_508}" " "
        local ret_split28_v0__33_25=("${ret_split28_v0[@]}")
        for part_519 in "${ret_split28_v0__33_25[@]}"; do
            text_contains__40_v0 "${part_519}" "\${"
            local ret_text_contains40_v0__34_20="${ret_text_contains40_v0}"
            if [[ ${ret_text_contains40_v0__34_20} != 0 ]]; then
                local resolved_524=""
                eval "resolved_524=${part_519}";
                    modified_518="${modified_518//${part_519}/${__BLUE_UNDERLINE_55}${part_519}${__NC_68} ${__GRAY_62}\'${resolved_524}\'${__NC_68}}";
                __status=$?
            fi
        done
        echo "  ${__BOLD_69}>${__NC_68} ${modified_518}"
    elif [[ "${cmd_517}" == "((" ]]; then
        local modified_525="${command_508}"
        split__28_v0 "${command_508}" " "
        local ret_split28_v0__46_25=("${ret_split28_v0[@]}")
        for part_526 in "${ret_split28_v0__46_25[@]}"; do
            text_contains__40_v0 "${part_526}" "_"
            local ret_text_contains40_v0__47_20="${ret_text_contains40_v0}"
            if [[ ${ret_text_contains40_v0__47_20} != 0 ]]; then
                local resolved_527=""
                eval "resolved_527=${!part_526}";
                        modified_525="${modified_525//${part_526}/${__BLUE_UNDERLINE_55}${part_526}${__NC_68} ${__GRAY_62}${resolved_527}${__NC_68}}";
                __status=$?
            fi
        done
        echo "  ${__BOLD_69}>${__NC_68} ${modified_525}"
    elif { [[ "${ret_text_contains40_v0__57_9}" != 0 ]] && [[ "${ret_capture_native_regex136_v0__57_41}" != 0 ]]; }; then
        local array_destruct_22=("${captured_510[@]}")
        local name_537="${array_destruct_22[1]?"Index out of bounds (at /root/projects/debugger/src/main.ab:58:23)"}"
        local new_value_538="${array_destruct_22[2]?"Index out of bounds (at /root/projects/debugger/src/main.ab:58:29)"}"
        local resolved_value_539=""
        temp_509="${!name_537}"
        __status=$?
        replace__24_v0 "${new_value_538}" "\"" ""
        local ret_replace24_v0__62_28="${ret_replace24_v0}"
        starts_with__46_v0 "${ret_replace24_v0__62_28}" "\$"
        local ret_starts_with46_v0__62_16="${ret_starts_with46_v0}"
        if [[ ${ret_starts_with46_v0__62_16} != 0 ]]; then
            if [[ "${new_value_538}" == "\$?" ]]; then
                resolved_value_539="${code_489}"
            else
                eval "resolved_value_539=\"'${new_value_538}'\""
                __status=$?
            fi
        fi
        if [[ "${temp_509}" == "" ]]; then
            echo "  ${__BOLD_69}${__GREEN_47}+${__NC_68} ${name_537} = $(if [[ "${resolved_value_539}" != '' ]]; then echo "${__BLUE_UNDERLINE_55}"; else echo ""; fi)${new_value_538}${__NC_68} ${__GRAY_62}${resolved_value_539}${__NC_68} "
        else
            echo "  ${__BOLD_69}${__CYAN_59}±${__NC_68} ${name_537} = ${__GRAY_62}${temp_509} -> ${__NC_68}${__BOLD_69}$(if [[ "${resolved_value_539}" != '' ]]; then echo "${__BLUE_UNDERLINE_55}"; else echo ""; fi)${new_value_538}${__NC_68} ${__GRAY_62}${resolved_value_539}${__NC_68} "
        fi
    elif [[ "${cmd_517}" == "return" ]]; then
        replace__24_v0 "${command_508}" "return " ""
        local code_552="${ret_replace24_v0}"
        if [[ "${code_552}" != "0" ]]; then
            code_552="${__RED_44}${code_552}"
        else
            code_552="${__GREEN_47}${code_552}"
        fi
        echo "
${__BOLD_69}=>${__NC_68} return ${code_552}${__NC_68}"
    elif [[ "${cmd_517}" == "false" ]]; then
        echo "  ${__BOLD_69}>${__NC_68} ${__RED_44}false${__NC_68}"
    else
        local modified_553="${command_508}"
        split__28_v0 "${command_508}" " "
        local ret_split28_v0__85_25=("${ret_split28_v0[@]}")
        for part_554 in "${ret_split28_v0__85_25[@]}"; do
            text_contains__40_v0 "${part_554}" "\${"
            local ret_text_contains40_v0__86_20="${ret_text_contains40_v0}"
            if [[ ${ret_text_contains40_v0__86_20} != 0 ]]; then
                local resolved_555=""
                eval "resolved_555=${part_554}";
                    modified_553="${modified_553//${part_554}/${__BLUE_UNDERLINE_55}${part_554}${__NC_68} ${__GRAY_62}\'${resolved_555}\'${__NC_68}}";
                __status=$?
            fi
        done
        echo "  ${__BOLD_69}>${__NC_68} ${modified_553}"
    fi
}

# enable_func_debug()
enable_func_debug__165_v0() {
    local varname_612=""
    varname_612="${FUNCNAME[1]}"
    typeset -t ${varname_612}
    __status=$?
    array_contains__2_v0 __DEBUGGER_FUNCS_487[@] "${varname_612}"
    local ret_array_contains2_v0__102_12="${ret_array_contains2_v0}"
    if (( ! ret_array_contains2_v0__102_12 )); then
        __DEBUGGER_FUNCS_487+=("${varname_612}")
    fi
}

trap ''"render_debug_line__164_v0"' $FUNCNAME $?' DEBUG
set -T
__status=$?
# readline(prompt: Text, hidden: Bool, max: Int)
readline__167_v0() {
    local prompt_609="${1}"
    local hidden_610="${2}"
    local max_611="${3}"
    # trust $ set -x $
    enable_func_debug__165_v0 
    local args_613=""
    if [[ ${prompt_609} != '' ]]; then
        if [[ "${EXEC_SHELL}" == "bash" ]]; then
            args_613+=" -p \"${prompt_609}\""
        elif [[ "${EXEC_SHELL}" == "zsh" ]]; then
            args_613+="?\"${prompt_609}\" "
        fi
    fi
    if (( max_611 > 0 )); then
        if { [[ "${EXEC_SHELL}" == "bash" ]] || [[ "${EXEC_SHELL}" == "ksh" ]]; }; then
            args_613+=" -N ${max_611}"
        elif [[ "${EXEC_SHELL}" == "zsh" ]]; then
            args_613+=" -k ${max_611}"
        fi
    fi
    if { [[ "${hidden_610}" != 0 ]] && [[ "${EXEC_SHELL}" != "ksh" ]]; }; then
        args_613+=" -s"
    fi
    local output_614=""
    if [[ "${EXEC_SHELL}" == "ksh" ]]; then
        if [[ ${hidden_610} != 0 ]]; then
            stty -echo 2>/dev/null; read output_614?"${prompt_609}"; stty echo 2>/dev/null
            __status=$?
        else
            read output_614?"${prompt_609}"
            __status=$?
        fi
    else
        read ${args_613} output_614 || read ${args_613} output_614 < /dev/tty
        __status=$?
    fi
    # trust $ set +x $
    ret_readline167_v0="${output_614}"
    return 0
}

# prompt(type: Int, required: Bool, hidden: Bool, prompt: Text)
prompt__168_v0() {
    local type_604="${1}"
    local required_605="${2}"
    local hidden_606="${3}"
    local prompt_607="${4}"
    # enable_func_debug()
    readline__167_v0 "${prompt_607}" "${hidden_606}" 0
    result_608="${ret_readline167_v0}"
    false
    __status=$?
    while { [[ "${required_605}" != 0 ]] && [[ "${result_608}" == "" ]]; }; do
        readline__167_v0 "${prompt_607}" "${hidden_606}" 0
        result_608="${ret_readline167_v0}"
    done
    if (( type_604 == 2 )); then
        int_check__14_v0 "${result_608}"
        local ret_int_check14_v0__55_23="${ret_int_check14_v0}"
        while (( ! ret_int_check14_v0__55_23 )); do
            readline__167_v0 "${prompt_607}" "${hidden_606}" 0
            result_608="${ret_readline167_v0}"
        done
    elif (( type_604 == 3 )); then
        num_check__16_v0 "${result_608}"
        local ret_num_check16_v0__59_23="${ret_num_check16_v0}"
        while (( ! ret_num_check16_v0__59_23 )); do
            readline__167_v0 "${prompt_607}" "${hidden_606}" 0
            result_608="${ret_readline167_v0}"
        done
    elif (( type_604 == 4 )); then
        bool_check__17_v0 "${result_608}"
        local ret_bool_check17_v0__63_23="${ret_bool_check17_v0}"
        while (( ! ret_bool_check17_v0__63_23 )); do
            readline__167_v0 "${prompt_607}" "${hidden_606}" 0
            result_608="${ret_readline167_v0}"
        done
    fi
    ret_prompt168_v0="${result_608}"
    return 0
}

# read_confirm(prompt: Text, default: Bool)
read_confirm__169_v0() {
    local prompt_623="${1}"
    local default_624="${2}"
    readline__167_v0 "${prompt_623}" 0 1
    local ret_readline167_v0__77_29="${ret_readline167_v0}"
    lowercase__35_v0 "${ret_readline167_v0__77_29}"
    local value_626="${ret_lowercase35_v0}"
    local __length_26="${value_626}"
    if (( ${#__length_26} == 0 )); then
        ret_read_confirm169_v0="${default_624}"
        return 0
    fi
    ret_read_confirm169_v0=$([[ "${value_626}" == "y" ]] && echo 1 || echo 0)
    return 0
}

prompt__168_v0 1 1 0 "test: "
ret_prompt168_v0__92_10="${ret_prompt168_v0}"
printf '%s\n' "${ret_prompt168_v0__92_10}"
echo "ok"
read_confirm__169_v0 "" 0
ret_read_confirm169_v0__94_10="${ret_read_confirm169_v0}"
echo "${ret_read_confirm169_v0__94_10}"
