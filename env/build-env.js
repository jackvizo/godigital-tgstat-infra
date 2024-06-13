const fs = require("fs");
const path = require('path');
const {envconfig, env, loadedEnv} = require('./bootstrap');

function filterUndefined(obj) {
  const filtered = {};

  Object.keys(obj).forEach((key) => {
    if (obj[key] !== undefined) {
      filtered[key] = obj[key];
    }
  });

  return filtered;
}

function compileTemplate(template, depth = 0) {
  const maxDepth = 10;
  if (depth > maxDepth) {
    throw new Error('Max template depth exceeded, possible circular reference.');
  }

  let compiled = template;
  let match;
  const regex = /\$\{(\w+)\}/g;

  while ((match = regex.exec(compiled)) !== null) {
    const fullMatch = match[0];
    const variableName = match[1];
    const variableValue = process.env[variableName] || '';

    compiled = compiled.replace(fullMatch, variableValue);
  }

  if (/\$\{(\w+)\}/.test(compiled)) {
    return compileTemplate(compiled, depth + 1);
  }

  return compiled;
}

function objToEnvFileString(obj) {
  const filteredObj = filterUndefined(obj);
  return Object.keys(filteredObj)
    .map((key) => `${key}=${compileTemplate(filteredObj[key])}`)
    .join(`\n`);
}

function objToEnvEmptyValues(obj) {
  return Object.keys(obj)
    .map((key) => {
      return `${key}=`;
    })
    .join(`\n`);
}

function run() {
  if (!env) {
    return;
  }

  const generatedPath = path.join(__dirname, 'generated')
  const infraPath = path.join(__dirname, '..',)

  fs.mkdirSync(path.join(generatedPath, env), {recursive: true, });

  for (const service of envconfig.services) {
    fs.writeFileSync(path.join(generatedPath, env, `.env.${service.name}`), objToEnvFileString(service.env));
    fs.writeFileSync(path.join(generatedPath, env, `.env.example.${service.name}`), objToEnvEmptyValues(service.env));
    console.log(`Created ${env} env for service ${service.name}`);
  }

  fs.writeFileSync(path.join(infraPath, `.env.${env}.example`), objToEnvEmptyValues(loadedEnv.parsed));
}

run()
