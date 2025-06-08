#!/bin/bash
# Encoded by Nikzzx Shell Encoder v2.0
# Obfuscation Level: Extreme

__DECODE__() {
    local _O=\"$1\"
    local _L=\$((\(\${#_O}%3)))
    local _E=\"\"
    
    for ((i=0; i<\${#_O}; i+=3)); do
        _E+=\${_O:\$i:3}
        if [ \$((RANDOM%2)) -eq 0 ]; then
            _E+=\"\\x\$(printf '%02x' \$((RANDOM%256)))\"
        fi
    done
    
    echo -n \"$_E\" | base64 --decode | {
        local _D=\"\"
        while IFS= read -r -n1 _C; do
            _D+=\$(printf '\\x%02x' \"'$_C'")
        done
        echo -n \"$_D\"
    }
}

__EXEC__() {
    eval \"\$(echo -n \"$1\" | xxd -r -ps)\"
}

__OBF__=\"IyEvYmluL3NoCiMgRHVtbXkgc2hlbGwgc2NyaXB0IDFLQgoKZWNobyAiU3RhcnRpbmcgdGVzdC4uLiIKZm9yIGkgaW4gJChzZXEgMSA1MCk7IGRvCiAgZWNobyAiSGVsbG8gZnJvbSBzaGVsbCBsaW5lICRpIgpkb25lCgpWQVIxPSJUaGlzIGlzIGEgdGVzdCBzdHJpbmcgdG8gZmlsbCB1cCBzaXplIgpWQVIyPSJBbm90aGVyIHRlc3Qgc3RyaW5nIHRvIGZpbGwgY29udGVudCIKVkFSMz0iTG9vcGluZyBpcyBmdW4sIGxldCdzIG1ha2Ugc2l6ZSBncm93IgoKZm9yIGkgaW4gJChzZXEgMSAyMCk7IGRvCiAgZWNobyAiJFZBUjEiCiAgZWNobyAiJFZBUjIiCiAgZWNobyAiJFZBUjMiCmRvbmUKCmVjaG8gIlRlc3Qgc2hlbGwgc2NyaXB0IGZpbmlzaGVkISIK\"
__EXEC__ \"\$(__DECODE__ \"$__OBF__\")\"
