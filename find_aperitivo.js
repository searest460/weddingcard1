const fs = require('fs');
const content = fs.readFileSync('original_clean.js', 'utf8');
const searchStr = 'Aperitivo';
const index = content.indexOf(searchStr);
if (index >= 0) {
    console.log(`Found at ${index}`);
    console.log(content.substring(index - 200, index + 3000));
} else {
    console.log('Not found');
}
