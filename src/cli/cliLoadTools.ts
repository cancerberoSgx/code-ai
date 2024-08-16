import fs, { existsSync, mkdirSync } from 'fs';
import YAML from 'yaml';
import { CliArgs } from '.';
import { Tool } from '../tool/types';
import { registerTool } from '../tool/registerTool';
import path, { join } from 'path';
import { homedir } from 'os';

/** loads default tools from local file */
export function cliRegisterTools(args: CliArgs) {
  let filePath = '';
  if (!args.config) {
    registerDefaultTools();
    // throw new Error('TODO: read config from $HOME/.code-ai or current folder');
  } else {
    filePath = args.config;
    const tools = parseToolsFile(filePath);
    registerTool(tools);
  }
  // tools.forEach(tool => registerTool(tool));
}

function parseToolsFile(filePath: string) {
  const file = fs.readFileSync(filePath, 'utf8');
  const r = YAML.parse(file);
  Object.keys(r).forEach(name => (r[name].metadata.name = name));

  const tools: Tool[] = Object.values(r);
  return tools;
}

function registerDefaultTools() {
  const filePath = join(__dirname, '..', '..', 'config', 'defaultTools.yml');
  const tools = parseToolsFile(filePath);
  registerTool(tools);
}

// const defaultConfigFolder = join(homedir(), '.code-ai')
// const defaultToolsFile = join(defaultConfigFolder, 'tools.yml')

// /** call me on npm prepare so we make sure an updated tools config file is  */
// function loadDefaultTools(){
//   if(!existsSync(defaultConfigFolder)) {
//     mkdirSync(defaultToolsFile)
//   }
//   if(!existsSync(defaultConfigFolder)) {
//   }
// }
