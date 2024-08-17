// responsible of reading and merge configuration from several sources
// TODO: manage defaults tools from reading from $HOME/.code-ai or other sources

import { Tool, ToolRunConfig } from './tool/types';

// export interface Config {
//   openAi?: {
//     apiKey?: string;
//   };
//   ollama?: {};
//   // tools: Tool[]
// }

// let config: Config | null = null;

// let defaultTools: Tool[] = []

// function getDefaultTools() {
//   if()
// }

export function getConfig(): ToolRunConfig {
  // if (!config) {
  let config: ToolRunConfig = {
    openAi: {
      apiKey: process.env.OPENAI_API_KEY,
      model: 'gpt-3.5-turbo',
    },
  };
  // TODO : must support a .code-ai.json config, CLI overrides, envvars overrides, etc
  // }
  return config;
}
