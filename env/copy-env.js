const fs = require("fs");
const path = require('path');
const {envconfig, env} = require('./bootstrap');


function run() {
  if (!env) {
    return;
  }


  for (const service of envconfig.services) {
    const envFileDir = path.join(__dirname, 'generated', env);

    const envFilePath = path.join(envFileDir, `.env.${service.name}`);
    const envExampleFilePath = path.join(__dirname, 'generated', env, `.env.example.${service.name}`);

    const targetDotenvFilePath = path.join(service.path, service.envFilename || '.env');
    const targetDotenvExampleFilePath = path.join(service.path, '.env.example')

    if (fs.existsSync(service.path)) {
      fs.cpSync(envFilePath, targetDotenvFilePath);
      console.log(`Created .env at path ${targetDotenvFilePath}`);
      fs.cpSync(envExampleFilePath, targetDotenvExampleFilePath);
      fs.unlinkSync(envExampleFilePath);
      console.log(`Created .env.example at path ${targetDotenvExampleFilePath}`);
    }
  }

}

run()
