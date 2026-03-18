const fs = require('fs');
const content = fs.readFileSync('original_clean.js', 'utf8');
const searchStrings = ['Sofía', 'SofÃ­a', 'Sam', 'Rahul', 'Dhanya'];

searchStrings.forEach(s => {
    let index = -1;
    while ((index = content.indexOf(s, index + 1)) !== -1) {
        console.log(`Found "${s}" at index ${index}`);
        console.log(`Context: ${content.substring(Math.max(0, index - 50), Math.min(content.length, index + 100))}`);
    }
});
