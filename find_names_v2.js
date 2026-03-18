const fs = require('fs');
const fd = fs.openSync('original_clean.js', 'r');
const buffer = Buffer.alloc(100000);
const searchStrings = ['Sofía', 'SofÃ­a', 'Sam', 'Rahul', 'Dhanya'];
let bytesRead;
let pos = 0;

while ((bytesRead = fs.readSync(fd, buffer, 0, 100000, pos)) > 0) {
    const chunk = buffer.toString('utf8', 0, bytesRead);
    searchStrings.forEach(s => {
        let index = -1;
        while ((index = chunk.indexOf(s, index + 1)) !== -1) {
            console.log(`Found "${s}" at absolute index ${pos + index}`);
            console.log(`Context: ${chunk.substring(Math.max(0, index - 50), Math.min(chunk.length, index + 100))}`);
        }
    });
    pos += bytesRead - 100; // Overlap to catch strings across boundaries
    if (bytesRead < 100000) break;
}
fs.closeSync(fd);
