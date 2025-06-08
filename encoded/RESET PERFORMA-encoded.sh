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

__OBF__=\"IyEvc3lzdGVtL2Jpbi9zaAoKZWNobyAiTWVyZXNldCBwZW5nYXR1cmFuIHBlcmZvcm1hLi4uIgoKIyBNZW5nZW1iYWxpa2FuIG1vZGUgZGF5YSBrZSBkZWZhdWx0CmNtZCBwb3dlciBzZXQtbW9kZSAwCnNldHRpbmdzIHB1dCBnbG9iYWwgbG93X3Bvd2VyIDAKCiMgTWVuZ2VtYmFsaWthbiBwZW5nYXR1cmFuIGFuaW1hc2kKc2V0dGluZ3MgcHV0IGdsb2JhbCB3aW5kb3dfYW5pbWF0aW9uX3NjYWxlIDEKc2V0dGluZ3MgcHV0IGdsb2JhbCB0cmFuc2l0aW9uX2FuaW1hdGlvbl9zY2FsZSAxCnNldHRpbmdzIHB1dCBnbG9iYWwgYW5pbWF0b3JfZHVyYXRpb25fc2NhbGUgMQoKIyBNZW5nZW1iYWxpa2FuIHBlbmdhdHVyYW4gR1BVCnNldHRpbmdzIHB1dCBnbG9iYWwgZ3B1X3JlbmRlcmVyICJkZWZhdWx0IgpzZXR0aW5ncyBwdXQgZ2xvYmFsIGZvcmNlX2h3X3VpIDAKCiMgTWVuZ2VtYmFsaWthbiBwZW5nYXR1cmFuIHNlbnNpdGl2aXRhcyBsYXlhcgpzZXR0aW5ncyBwdXQgZ2xvYmFsIHRvdWNoX3NlbnNpdGl2aXR5X21vZGUgMAoKIyBNZW5nZW1iYWxpa2FuIG1vZGUgQ1BVCmVjaG8gInNjaGVkdXRpbCIgPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWZyZXEvc2NhbGluZ19nb3Zlcm5vcgplY2hvICJzY2hlZHV0aWwiID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MS9jcHVmcmVxL3NjYWxpbmdfZ292ZXJub3IKZWNobyAic2NoZWR1dGlsIiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTIvY3B1ZnJlcS9zY2FsaW5nX2dvdmVybm9yCmVjaG8gInNjaGVkdXRpbCIgPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUzL2NwdWZyZXEvc2NhbGluZ19nb3Zlcm5vcgoKIyBNZW5nZW1iYWxpa2FuIHNlbXVhIGFwbGlrYXNpIHlhbmcgZGlub25ha3RpZmthbgpmb3IgcGtnIGluICQocG0gbGlzdCBwYWNrYWdlcyAtZCk7IGRvCiAgICBwbSBlbmFibGUgJHtwa2cjcGFja2FnZTp9CmRvbmUKCmVjaG8gIlJlc2V0IHBlcmZvcm1hIHNlbGVzYWkhIgo=\"
__EXEC__ \"\$(__DECODE__ \"$__OBF__\")\"
