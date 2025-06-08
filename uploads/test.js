// Dummy JS file 1KB

function testFunc() {
    console.log("Starting JS test...");

    let str = "abcdefghijklmnopqrstuvwxyz";
    let output = "";

    for (let i = 0; i < 40; i++) {
        output += str + i + "\n";
    }

    console.log(output);
}

testFunc();

let spamText = "";
for (let i = 0; i < 50; i++) {
    spamText += "Line " + i + ": JavaScript dummy test content.\n";
}
console.log(spamText);
