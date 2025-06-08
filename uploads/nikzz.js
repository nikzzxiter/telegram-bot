document.addEventListener('DOMContentLoaded', function () {
    // DOM Elements
    const originalHtml = document.getElementById('originalHtml');
    const encryptedHtml = document.getElementById('encryptedHtml');
    const encryptBtn = document.getElementById('encryptBtn');
    const copyBtn = document.getElementById('copyBtn');
    const pasteBtn = document.getElementById('pasteBtn');
    const previewBtn = document.getElementById('previewBtn');
    const testBtn = document.getElementById('testBtn');
    const previewModal = document.getElementById('previewModal');
    const previewIframe = document.getElementById('previewIframe');
    const closePreview = document.getElementById('closePreview');
    const toast = document.getElementById('toast');
    const toastMessage = document.getElementById('toastMessage');

    // Encryption Methods
    const encryptionMethods = {
        evalUnescape: function (html, level) {
            let hex = '';
            for (let i = 0; i < html.length; i++) {
                hex += '%' + html.charCodeAt(i).toString(16);
            }

            let encrypted = `<html><head></head><body><script type="text/javascript"><!--\n`;
            const layers = level === 'normal' ? 2 : level === 'extended' ? 4 : 6;

            for (let i = 0; i < layers; i++) {
                if (i === layers - 1) {
                    encrypted += `eval(unescape('${hex}'))\n`;
                } else {
                    encrypted += `eval(unescape('${btoa(hex)}'))\n`;
                    hex = btoa(hex);
                }
            }

            encrypted += '//--></script><noscript><i>Javascript required</i></noscript></body></html>';
            return encrypted;
        },
        base64: function (html, level) {
            let encoded = html;
            const iterations = level === 'normal' ? 3 : level === 'extended' ? 5 : 7;

            for (let i = 0; i < iterations; i++) {
                encoded = btoa(encoded);
            }

            const decodedScript = `
                <script>
                    let code = '${encoded}';
                    ${Array(iterations).fill().map(() => 'code = atob(code);').join('\n')}
                    document.open();
                    document.write(code);
                    document.close();
                </script>
                <noscript><i>Javascript required</i></noscript>
            `;
            return decodedScript;
        },
        charCode: function (html, level) {
            const charCodes = [];
            for (let i = 0; i < html.length; i++) {
                charCodes.push(html.charCodeAt(i));
            }

            let obfuscationLevel = level === 'normal' ? 1 : level === 'extended' ? 2 : 3;
            let charCodeStr = charCodes.join(',');
            for (let i = 0; i < obfuscationLevel; i++) {
                charCodeStr = btoa(charCodeStr);
            }

            const decodedScript = `
                <script>
                    let codes = '${charCodeStr}';
                    ${Array(obfuscationLevel).fill().map(() => 'codes = atob(codes);').join('\n')}
                    const arr = codes.split(',');
                    let html = '';
                    for (let i = 0; i < arr.length; i++) {
                        html += String.fromCharCode(parseInt(arr[i]));
                    }
                    document.open();
                    document.write(html);
                    document.close();
                </script>
                <noscript><i>Javascript required</i></noscript>
            `;
            return decodedScript;
        }
    };

    // Event Listeners
    encryptBtn.addEventListener('click', function () {
        const html = originalHtml.value.trim();
        if (!html) {
            showToast('Please enter HTML code to encrypt', false);
            return;
        }
        const method = document.querySelector('input[name="encryptionMethod"]:checked').value;
        const level = document.querySelector('input[name="securityLevel"]:checked').value;
        try {
            const encrypted = encryptionMethods[method](html, level);
            encryptedHtml.value = encrypted;
            showToast('HTML encrypted successfully!', true);
        } catch (error) {
            showToast('Encryption failed: ' + error.message, false);
            console.error(error);
        }
    });

    copyBtn.addEventListener('click', function () {
        if (!encryptedHtml.value) {
            showToast('No encrypted code to copy', false);
            return;
        }
        encryptedHtml.select();
        document.execCommand('copy');
        showToast('Encrypted code copied to clipboard!', true);
    });

    pasteBtn.addEventListener('click', function () {
        navigator.clipboard.readText()
            .then(text => {
                originalHtml.value = text;
                showToast('Pasted from clipboard!', true);
            })
            .catch(err => {
                showToast('Failed to read from clipboard', false);
                console.error('Failed to read clipboard contents: ', err);
            });
    });

    previewBtn.addEventListener('click', function () {
        if (!encryptedHtml.value) {
            showToast('No encrypted code to preview', false);
            return;
        }
        const blob = new Blob([encryptedHtml.value], { type: 'text/html' });
        previewIframe.src = URL.createObjectURL(blob);
        previewModal.classList.add('active');
    });

    testBtn.addEventListener('click', function () {
        if (!encryptedHtml.value) {
            showToast('No encrypted code to test', false);
            return;
        }
        try {
            const testWindow = window.open();
            testWindow.document.write(encryptedHtml.value);
            testWindow.document.close();
            showToast('Testing encrypted HTML in new window', true);
        } catch (error) {
            showToast('Test failed: ' + error.message, false);
            console.error(error);
        }
    });

    closePreview.addEventListener('click', function () {
        previewModal.classList.remove('active');
        previewIframe.src = '';
    });

    previewModal.addEventListener('click', function (e) {
        if (e.target === previewModal) {
            previewModal.classList.remove('active');
            previewIframe.src = '';
        }
    });

    // Helper Functions
    function showToast(message, isSuccess) {
        toastMessage.textContent = message;
        toast.className = isSuccess ? 'toast toast-success show' : 'toast show';
        setTimeout(() => {
            toast.classList.remove('show');
        }, 3000);
    }
});