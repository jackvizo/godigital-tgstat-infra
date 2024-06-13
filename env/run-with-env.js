const fs = require('fs');
const {loadedEnv} = require('./bootstrap');

if (loadedEnv.error) {
  throw loadedEnv.error;
}

// Create a command string with exported environment variables
let command = '';
for (const k in loadedEnv.parsed) {
  command += `export ${k}=${loadedEnv.parsed[k]}\n`;
}

// Append the original command to be executed
const originalCommand = process.argv.slice(2).join(' ');
command += originalCommand + '\n';

// Write to a temporary shell script
const scriptPath = '___TEMP___.sh';
fs.writeFileSync(scriptPath, command, {mode: 0o755});

// Execute the script
const {exec} = require('child_process');
exec(`sh ${scriptPath}`, (error, stdout, stderr) => {
  if (error) {
    console.error(`exec error: ${error}`);
    return;
  }
  if (stderr) {
    console.error(`stderr: ${stderr}`);
  }
  console.log(stdout);

  // Optionally, delete the script after execution
  fs.unlinkSync(scriptPath);
});