import { asArray } from '../util';
import { Tool } from './types';

let tools: Tool[] = [];

export function registerTool(newTool: Tool | Tool[]) {
  // if (getTool(tool.metadata.name)) {
  //   throw new Error(`Tool named "${tool.metadata.name}" already exists`);
  // }
  tools = [...tools, ...asArray(newTool)].filter((e, i, a) => a.findIndex(e2 => e2.metadata.name === e.metadata.name) === i);
  // tools.push(tool);
}

export function getTool(name: string) {
  const tool = tools.find(t => t.metadata.name === name);
  if (!tool) {
    throw new Error(`Tool not found: ${name}`);
  }
  return tool;
}

export function getTools() {
  return tools;
}
