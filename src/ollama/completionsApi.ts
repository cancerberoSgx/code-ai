import { ChatMessage, OllamaConfig } from '../tool/types';
import ollama from 'ollama';

interface ChatCompletionArgs {
  prompt: string;
  systemPrompt?: string;
  config: OllamaConfig;
}

/** high level function to reqeust chat completions */
export async function chatCompletion(args: ChatCompletionArgs): Promise<string> {
  const messages: ChatMessage[] = [
    { role: 'system', content: args.systemPrompt || 'You are an expert developer' },
    { role: 'user', content: args.prompt },
  ];
  const response = await ollama.chat({
    model: args.config.model || 'llama3.1',
    messages,
  });
  return response.message.content;
}
