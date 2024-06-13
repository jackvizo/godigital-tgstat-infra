const path = require('path');
const env = process.env.ENV?.toLowerCase();
const infraRoot = path.join(__dirname, '..')

if (!env) {
  console.error("no env specified");
  process.exit(1);
}

if (!['dev', 'stage', 'production'].includes(env)) {
  console.error("env must be one of: dev, stage, production");
  process.exit(1);
}

const loadedEnv = require("dotenv").config({path: path.join(infraRoot, `.env.${env}`)});

const envconfig = require(path.join(infraRoot, '.envconfig'));

module.exports = {
  envconfig,
  env,
  loadedEnv
}
