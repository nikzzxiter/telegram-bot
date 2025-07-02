#!/bin/bash
# Military Grade Protection

kxdfkygphm() {
    if [ -z "$ANDROID_ROOT" ] && [ -z "$TERMUX_VERSION" ]; then
        echo "ERROR: Only works on Android terminals"
        exit 1
    fi
}

ldutvlpvwhd() {
    if ps aux 2>/dev/null | grep -E "(chrome|firefox|gdb|strace)" >/dev/null; then
        echo "ERROR: Debugging tools detected"
        exit 1
    fi
}

ocehafwe() {
    echo "$1" | base64 -d 2>/dev/null
}

gxyhzmme() {
    echo "$1" | xxd -r -p 2>/dev/null
}

eulammmpnkr() {
    local data="$1"
    # Decode base64
    data=$(ocehafwe "$data")
    if [ -z "$data" ]; then
        echo "Decode failed"
        return 1
    fi
    # Decode hex
    data=$(gxyhzmme "$data")
    if [ -z "$data" ]; then
        echo "Decode failed"
        return 1
    fi
    # Final base64 decode
    data=$(ocehafwe "$data")
    echo "$data"
}

# Junk variables
axezpumkz=393903
jzyyjxsk=766202
jssrnnqyubd=$(date +%s 2>/dev/null)

# Security checks
kxdfkygphm
ldutvlpvwhd

# Payload chunks
urlyoprzv="NDk3OTQ1NzY1OTZkNmM3NTRjMzM0ZTZmNDM2OTRkNjc1MjQ4NTY3NDYyNTg2YjY3NjMzMjY4NmM2MjQ3Nzc2NzYzMzI0ZTc5NjE1ODQyMzA0OTQ0NDY0YzUxNjc2ZjRiNWE1NzRlNmY2Mjc5NDE2OTU1MzM1MjY4NjM2ZTUyNzA2MjZkNjM2NzY0NDc1NjdhNjQ0MzM0NzU0YzY5NDk0YjVhNmQzOTc5NDk0NzZiNjc2MTU3MzQ2NzRhNDM2ODdhNWE1ODQ1Njc0ZDUzNDEzMTRkNDM2YjM3NDk0NzUyNzY0MzY5NDE2NzVhNTc0ZTZmNjI3OTQx"
lgynqouashh="Njk1MzQ3NTY3MzYyNDczODY3NWE2ZTRhNzY2MjUzNDI3YTYxNDc1NjczNjI0MzQyNzM2MTU3MzU2YzQ5NDM1MjcwNDk2NzcwNmI2MjMyMzU2YzQzNjc3MDU3NTE1NjQ5Nzg1MDUzNGE1NTYxNDc2YzdhNDk0NzZjN2E0OTQ3NDU2NzY0NDc1NjdhNjQ0MzQyN2E2NDQ4NGE3MDYyNmQ2MzY3NjQ0NzM4Njc1YTZkNmM3MzYyNDM0MjMxNjM0MzQyN2E2MTU4NzA2YzQ5Njc3MDU3NTE1NjQ5Nzk1MDUzNGE0MjYyNmQzOTMwNjE0NzU2Nzk0OTQ4"
ffwnfdvh="NTI2YzYzMzM1MTY3NjMzMzUyNzk2MTU3MzU2ZTQ5NDg1Mjc2NDk0NzVhNzA2MjQ3Nzc2NzU5MzIzOTc1NjQ0NzU2NzU2NDQzNDk0YjU2NmI0NjUzNGQ3YTMwNjk1NDQ3Mzk3NjYzNDc2Yzc1NWE3OTQyNzA2Mzc5NDI2ZDY0NTczNDczNDk0Nzc4NmM2NDQzNjQ3YTQ5NDczMTY4NjEzMjU1Njc2MzMyNmMzNjVhNTM0MjZlNjM2ZDM5MzM0OTY3NmY0YjVhNmQzOTc5NDk0NzZiNjc2MTU3MzQ2NzRhNDM2ODdhNWE1ODQ1Njc0ZDUzNDE3OTRk"
qhcryqye="NDM2YjM3NDk0NzUyNzY0MzY5NDE2NzVhNTc0ZTZmNjI3OTQxNjk0YTQ2NWE0MjU1NmE0NTY5NDM2OTQxNjc1YTU3NGU2ZjYyNzk0MTY5NGE0NjVhNDI1NTZhNDk2OTQzNjk0MTY3NWE1NzRlNmY2Mjc5NDE2OTRhNDY1YTQyNTU2YTRkNjk0MzZkNTI3NjYyNmQ1NTRiNDM2ZDU2NmE2MTQ3Mzg2NzQ5NmM1MjZjNjMzMzUxNjc2MzMyNjg2YzYyNDc3NzY3NjMzMjRlNzk2MTU4NDIzMDQ5NDc1YTcwNjI2ZDZjN2E2MTQ3NTY2YjQ5NTM0OTRi"

# Reconstruct payload
lrpsojifq="$urlyoprzv$lgynqouashh$ffwnfdvh$qhcryqye"

# Decode and execute
echo "Decoding payload..."
fmdfwwhefyxxqmm=$(eulammmpnkr "$lrpsojifq")

if [ -n "$fmdfwwhefyxxqmm" ]; then
    echo "Executing decoded script..."
    eval "$fmdfwwhefyxxqmm"
else
    echo "Failed to decode payload"
    exit 1
fi

# Cleanup
unset kxdfkygphm ldutvlpvwhd ocehafwe gxyhzmme eulammmpnkr
unset axezpumkz jzyyjxsk jssrnnqyubd urlyoprzv lgynqouashh
unset ffwnfdvh qhcryqye lrpsojifq fmdfwwhefyxxqmm
